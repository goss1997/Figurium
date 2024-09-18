package com.githrd.figurium.order.controller;

import com.githrd.figurium.common.session.SessionConstants;
import com.githrd.figurium.exception.customException.OutofStockException;
import com.githrd.figurium.order.service.OrderService;
import com.githrd.figurium.product.dao.CartsMapper;
import com.githrd.figurium.product.vo.CartsVo;
import com.githrd.figurium.user.entity.User;
import com.githrd.figurium.user.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@Slf4j
@RequestMapping("/order")
@RequiredArgsConstructor
public class OrderController {

    private final OrderService orderService;
    private final UserService userService;
    private final CartsMapper cartsMapper;
    private final HttpSession session;

    @Value("${imp.api.key}")
    private String apiKey;

    @Value("${imp.api.secretkey}")
    private String secretKey;

    /*
     *   바로구매창
     */
    @RequestMapping("orderFormRight.do")
    public String orderFormRight(@RequestParam(required = false) int quantity,
                            @RequestParam(required = false) int productId,
                            HttpSession session,
                            Model model) {

        User user = (User) session.getAttribute(SessionConstants.LOGIN_USER);

        // 해당 상품이 추가되어있으면 더이상 insert 하지 않기
        CartsVo checkCart = cartsMapper.selectCartsById(productId,user.getId());

        if(checkCart == null) {
            int res = cartsMapper.insertCartItem(user.getId(), productId, quantity);
        }

        List<CartsVo> cartsList = cartsMapper.checksCartItemOne(productId, user.getId());

        // JSP에서 계산 이뤄지게 하는 방식은 권장되지 않아서 서버딴에서 결제 처리
        CartsVo cartsVo = cartsList.get(0);
        int existingQuantity = cartsVo.getQuantity();

        if(existingQuantity != quantity) {
            cartsVo.setQuantity(quantity); // 새로운 수량으로 업데이트
            // 수량을 가져와서 수량이 변경되었다면, 변경된 수량 반영
            int res = cartsMapper.updateCartQuantity(cartsVo);
        }

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

        User user = (User) session.getAttribute(SessionConstants.LOGIN_USER);
        int loginUserId = user.getId();

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
     *   주문/결제창
     */
//    @RequestMapping("orderForm.do")
//    public String orderForm(@RequestParam(required = false) List<Integer> cartQuantities,
//                            @RequestParam(required = false) List<Integer> productId,
//                            HttpSession session,
//                            Model model) {
//
//        User user = (User) session.getAttribute(SessionConstants.LOGIN_USER);
//        int loginUserId = user.getId();
//
//        List<CartsVo> cartsList = cartsMapper.checksCartItemList(user.getId(),productId);
//
//        // 기존 수량 체크
//        for (int i = 0; i < cartsList.size(); i++) {
//            CartsVo cartsVo = cartsList.get(i);
//            int existingQuantity = cartsVo.getQuantity();
//            int newQuantity = cartQuantities.get(i);
//
//            if(existingQuantity != newQuantity) {
//                cartsVo.setQuantity(newQuantity); // 새로운 수량으로 업데이트
//                // 수량을 가져와서 수량이 변경되었다면, 변경된 수량 반영
//                int res = cartsMapper.updateCartQuantity(cartsVo);
//            }
//        }
//
//
//        // JSP에서 계산 이뤄지게 하는 방식은 권장되지 않아서 서버딴에서 결제 처리
//        int totalPrice = 0;
//
//        for(CartsVo products:cartsList) {
//            totalPrice += products.getPrice() * products.getQuantity();
//        }
//
//        model.addAttribute("cartsList", cartsList);
//        model.addAttribute("totalPrice", totalPrice);
//        session.setAttribute("sessionTotalPrice", totalPrice);
//        return "order/orderForm";
//    }


    /*
     *   재고 처리 확인
     */
    @RequestMapping("checkProduct.do")
    @ResponseBody
    public ResponseEntity<?> checkProduct(@RequestParam(value ="productIds[]") List<Integer> productIds,
                                       @RequestParam(value="itemQuantities[]") List<Integer> itemQuantities) {

        // user session 없으면 결제 진행 불가
        User user = (User) session.getAttribute(SessionConstants.LOGIN_USER);
        if(user == null) {
            return ResponseEntity.ok("notSession");
        }

        String result = orderService.checkProductStock(productIds, itemQuantities);

        return ResponseEntity.ok(result);
    }
    
    

    @RequestMapping(value = "inicisPay.do")
    @ResponseBody
    public String inicisPay(int price, String paymentType, Integer userId, String merchantUid) {

        orderService.insertOrder(price, paymentType, userId, merchantUid);

        System.out.println("결제성공");

        return "map";
    }



    @PostMapping(value = "insertInformation.do")
    @ResponseBody
    public String insertInformation(int loginUserId, String name, String phone, String email,
                                    String address, String recipientName,
                                    String shippingPhone, String deliveryRequest,
                                    @RequestParam(value="productIds[]") List<Integer> productIds,
                                    @RequestParam(value="itemPrices[]") List<Integer> itemPrices,
                                    @RequestParam(value="itemQuantities[]") List<Integer> itemQuantities
                                    ) {

        try {

            // 장바구니 아이템 삭제, 구매아이템 저장, 재고 확인
            int orderId = orderService.updateProductInfo(productIds, itemPrices, itemQuantities, loginUserId);

            // 주문하는 Customer 정보 저장
            orderService.insertCustomer(orderId, name, phone, email);

            // 배송지 정보 저장
            orderService.insertShippingAddresses(orderId, recipientName, shippingPhone, address, deliveryRequest);

            // 주문 성공 알람 보내기
            orderService.orderSuccessAlram(orderId, loginUserId);

            return "success";

        } catch (Exception e) {
            log.error("Error occurred while linking account: ", e);
            throw new OutofStockException("Failed to link account: " + e.getMessage());
        }

    }
//
//
//    /*
//     *   결제 성공시 주문 데이터 저장
//     */
//    @PostMapping(value = "insertInformation.do")
//    @ResponseBody
//    @Transactional
//    public String insertInformation(int loginUserId, String name, String phone, String email,
//                                    String address, String recipientName,
//                                    String shippingPhone, String deliveryRequest,
//                                    @RequestParam(value="productIds[]") List<Integer> productIds,
//                                    @RequestParam(value="itemPrices[]") List<Integer> itemPrices,
//                                    @RequestParam(value="itemQuantities[]") List<Integer> itemQuantities
//                                    ) {
//
//        try {
//            // Customers insert
//            // 최근에 생성된 order_id의 idx 주입
//            int orderId = orderMapper.selectOneLast().getId();
//
//
//            for(int i = 0; i < productIds.toArray().length; i++) {
//
//                OrderItems orderItems = new OrderItems();
//                orderItems.setOrderId(orderId);
//
//                int productId = productIds.get(i);
//                int itemPrice = itemPrices.get(i);
//                int itemQuantity = itemQuantities.get(i);
//
//                // 각 값을 저장
//                orderItems.setProductId(productId);
//                orderItems.setItemPrice(itemPrice);
//                orderItems.setItemQuantity(itemQuantity);
//
//                // 장바구니에 입력되어 있는 정보 중 구매한 상품 전부 삭제
//                cartsMapper.deleteCartProduct(productId, loginUserId);
//
//                orderItemsMapper.insertOrderItems(orderItems);
//
//                // 처음에 재고 확인 후 시간차 주문공격 체크
//                ProductsVo productsVo = productsMapper.selectOneCheckProduct(productId, itemQuantity);
//                int itemQuantityCheck = productsVo.getQuantity();
//                // 상품 정보에 재고 업데이트
//                // TODO 귀여미 Exception 처리
//                if(itemQuantityCheck-itemQuantity<0) {
//                    log.error("There is insufficient stock due to someone else's purchase.: {}", "재고수량부족");
//                    throw new OutofStockException("Insufficient stock: 재고가 부족합니다.");
//                }
//
//                int res = productsMapper.updateProductQuantity(productId, itemQuantity);
//            }
//
//            Customers customers = new Customers();
//
//            customers.setOrderId(orderId);
//            customers.setName(name);
//            customers.setPhone(phone);
//            customers.setEmail(email);
//
//            int res = customersMapper.insertCustomers(customers);
//
//            // Shipping_addresses insert
//            ShippingAddresses shippingAddresses = new ShippingAddresses();
//
//            shippingAddresses.setOrderId(orderId);
//            shippingAddresses.setRecipientName(recipientName);
//            shippingAddresses.setShippingPhone(shippingPhone);
//            shippingAddresses.setAddress(address);
//            shippingAddresses.setDeliveryRequest(deliveryRequest);
//
//            // 매핑 생성
//            int res2 = shippingAddressesMapper.insertShippingAddresses(shippingAddresses);
//
//            return "success";
//
//        } catch (Exception e) {
//            log.error("Error occurred while linking account: ", e);
//            throw new OutofStockException("Failed to link account: " + e.getMessage());
//        }
//
//    }

}
