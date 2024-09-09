package com.githrd.figurium.order.controller;

import com.githrd.figurium.order.dao.CustomersMapper;
import com.githrd.figurium.order.dao.OrderItemsMapper;
import com.githrd.figurium.order.dao.OrderMapper;
import com.githrd.figurium.order.dao.ShippingAddressesMapper;
import com.githrd.figurium.order.vo.Customers;
import com.githrd.figurium.order.vo.OrderItems;
import com.githrd.figurium.order.vo.ShippingAddresses;
import com.githrd.figurium.product.dao.CartsMapper;
import com.githrd.figurium.product.dao.ProductsMapper;
import com.githrd.figurium.product.vo.CartsVo;
import com.githrd.figurium.product.vo.ProductsVo;
import com.githrd.figurium.user.entity.User;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/order")
public class OrderController {

    private final ProductsMapper productsMapper;
    private CartsMapper cartsMapper;
    private OrderMapper orderMapper;
    private CustomersMapper customersMapper;
    private ShippingAddressesMapper shippingAddressesMapper;
    private OrderItemsMapper orderItemsMapper;
    private HttpSession session;

    @Value("${imp.api.key}")
    private String apiKey;

    @Value("${imp.api.secretkey}")
    private String secretKey;

    @Autowired
    public OrderController(CartsMapper cartsMapper, OrderMapper orderMapper,
                           CustomersMapper customersMapper, ShippingAddressesMapper shippingAddressesMapper,
                           OrderItemsMapper orderItemsMapper, HttpSession session, ProductsMapper productsMapper) {
        this.cartsMapper = cartsMapper;
        this.orderMapper = orderMapper;
        this.customersMapper = customersMapper;
        this.shippingAddressesMapper = shippingAddressesMapper;
        this.orderItemsMapper = orderItemsMapper;
        this.session = session;
        this.productsMapper = productsMapper;
    }


    /*
     *   바로구매창
     */
    @RequestMapping("orderFormRight.do")
    public String orderFormRight(@RequestParam(required = false) int quantity,
                            @RequestParam(required = false) int productId,
                            HttpSession session,
                            Model model) {

        User user = (User) session.getAttribute("loginUser");

        // 해당 상품이 추가되어있으면 더이상 insert 하지 않기
        CartsVo checkCart = cartsMapper.selectCartsById(productId,user.getId());

        if (checkCart == null) {
            int res = cartsMapper.insertCartItem(user.getId(),productId,quantity);

        }
        List<CartsVo> cartsList = cartsMapper.checksCartItemOne(user.getId(),productId);

        // JSP에서 계산 이뤄지게 하는 방식은 권장되지 않아서 서버딴에서 결제 처리
        CartsVo cartsVo = cartsList.get(0);
        int totalPrice = cartsVo.getPrice() * cartsVo.getQuantity();

        model.addAttribute("cartsList", cartsList);
        model.addAttribute("totalPrice", totalPrice);
        session.setAttribute("sessionTotalPrice", totalPrice);
        return "order/orderForm";
    }


    /*
     *   주문/결제창
     */
    @RequestMapping("orderForm.do")
    public String orderForm(@RequestParam(required = false) List<Integer> cartQuantities,
                            @RequestParam(required = false) List<Integer> productId,
                            HttpSession session,
                            Model model) {

        User user = (User) session.getAttribute("loginUser");

        List<CartsVo> cartsList = cartsMapper.checksCartItemList(user.getId(),productId);

        // 기존 수량 체크
        for (int i = 0; i < cartsList.size(); i++) {
            CartsVo cartsVo = cartsList.get(i);
            int existingQuantity = cartsVo.getQuantity();
            int newQuantity = cartQuantities.get(i);

            if(existingQuantity != newQuantity) {
                cartsVo.setQuantity(newQuantity); // 새로운 수량으로 업데이트
                // 수량을 가져와서 수량이 변경되었다면, 변경된 수량 반영
                int res = cartsMapper.updateCartQuantity(cartsVo);
            }
        }


        // JSP에서 계산 이뤄지게 하는 방식은 권장되지 않아서 서버딴에서 결제 처리
        int totalPrice = 0;

        for(CartsVo products:cartsList) {
            totalPrice += products.getPrice() * products.getQuantity();
        }

        model.addAttribute("cartsList", cartsList);
        model.addAttribute("totalPrice", totalPrice);
        session.setAttribute("sessionTotalPrice", totalPrice);
        return "order/orderForm";
    }


    /*
     *   재고 처리 확인
     */
    @RequestMapping("checkProduct.do")
    @ResponseBody
    public String checkProduct(@RequestParam(value ="productIds[]") List<Integer> productIds,
                               @RequestParam(value="itemQuantities[]") List<Integer> itemQuantities) {

        for(int i = 0; i < productIds.toArray().length; i++) {

            int productId = productIds.get(i); // 재고 상품 정보
            int itemQuantity = itemQuantities.get(i); // 재고 상품 갯수


            // ProductsVo에 담아서 재고 있는지 체크
            ProductsVo productsVo = productsMapper.selectOneCheckProduct(productId, itemQuantity);

            int itemQuantityCheck = productsVo.getQuantity();

            if(itemQuantityCheck <= itemQuantity) {
                return "error";
            }
        }

        return "success";

    }
    
    
    /*
     *   inicis 결제 요청 처리하기 (PaymentRequest => DTO로 사용)
     */
    @RequestMapping(value = "inicisPay.do")
    @ResponseBody
    public String inicisPay(int price, String paymentType, Integer userId, String merchantUid) {

        // 주문자 정보 insert
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("price",price);
        map.put("paymentType",paymentType);
        map.put("userId", userId);
        map.put("merchantUid", merchantUid);

        if (paymentType.equals("vbank")) {
            map.put("status","입금대기");
        }else {
            map.put("status","준비중");
        }

        int res = orderMapper.insertOrders(map);
        System.out.println("결제성공");

        map.put("status", "success");

        return "map";
    }


    /*
     *   결제 성공시 주문 데이터 저장
     */
    @RequestMapping(value = "insertInformation.do")
    @ResponseBody
    public String insertInformation(int loginUserId, String name, String phone, String email,
                                    String address, String recipientName,
                                    String shippingPhone, String deliveryRequest,
                                    @RequestParam(value="productIds[]") List<Integer> productIds,
                                    @RequestParam(value="itemPrices[]") List<Integer> itemPrices,
                                    @RequestParam(value="itemQuantities[]") List<Integer> itemQuantities
                                    ) {

        System.out.println("insertInformation 입력완료");


        // Customers insert
        // 최근에 생성된 order_id의 idx 주입
        int orderId = orderMapper.selectOneLast().getId();



        for(int i = 0; i < productIds.toArray().length; i++) {

            OrderItems orderItems = new OrderItems();
            orderItems.setOrderId(orderId);

            int productId = productIds.get(i);
            int itemPrice = itemPrices.get(i);
            int itemQuantity = itemQuantities.get(i);

            // 각 값을 저장
            orderItems.setProductId(productId);
            orderItems.setItemPrice(itemPrice);
            orderItems.setItemQuantity(itemQuantity);

            // 장바구니에 입력되어 있는 정보 중 구매한 상품 전부 삭제
            cartsMapper.deleteCartProduct(productId, loginUserId);

            orderItemsMapper.insertOrderItems(orderItems);
            
            // 상품 정보에 재고 업데이트
            int res = productsMapper.updateProductQuantity(productId, itemQuantity);
            

        }



        Customers customers = new Customers();

        customers.setOrderId(orderId);
        customers.setName(name);
        customers.setPhone(phone);
        customers.setEmail(email);

        int res = customersMapper.insertCustomers(customers);

        // Shipping_addresses insert
        ShippingAddresses shippingAddresses = new ShippingAddresses();

        shippingAddresses.setOrderId(orderId);
        shippingAddresses.setRecipientName(recipientName);
        shippingAddresses.setShippingPhone(shippingPhone);
        shippingAddresses.setAddress(address);
        shippingAddresses.setDeliveryRequest(deliveryRequest);

        // 매핑 생성
        int res2 = shippingAddressesMapper.insertShippingAddresses(shippingAddresses);



        System.out.println("입력성공");


        return "success";
    }




}
