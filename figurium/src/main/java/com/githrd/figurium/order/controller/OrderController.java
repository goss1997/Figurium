package com.githrd.figurium.order.controller;

import com.githrd.figurium.order.dao.CustomersMapper;
import com.githrd.figurium.order.dao.OrderItemsMapper;
import com.githrd.figurium.order.dao.OrderMapper;
import com.githrd.figurium.order.dao.ShippingAddressesMapper;
import com.githrd.figurium.order.vo.Customers;
import com.githrd.figurium.order.vo.OrderItems;
import com.githrd.figurium.order.vo.ShippingAddresses;
import com.githrd.figurium.product.entity.Products;
import com.githrd.figurium.product.repository.ProductRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class OrderController {

    private final ProductRepository productRepository;
    private OrderMapper orderMapper;
    private CustomersMapper customersMapper;
    private ShippingAddressesMapper shippingAddressesMapper;
    private OrderItemsMapper orderItemsMapper;
    private HttpSession session;

    @Autowired
    public OrderController(ProductRepository productRepository, OrderMapper orderMapper,
                           CustomersMapper customersMapper, ShippingAddressesMapper shippingAddressesMapper,
                           OrderItemsMapper orderItemsMapper, HttpSession session) {
        this.productRepository = productRepository;
        this.orderMapper = orderMapper;
        this.customersMapper = customersMapper;
        this.shippingAddressesMapper = shippingAddressesMapper;
        this.orderItemsMapper = orderItemsMapper;
        this.session = session;
    }


    @GetMapping("order/orderForm.do")
    public String orderForm(Model model) {

        // 지훈이형 Product DB 아무거나 던져보기
        Pageable pageable = PageRequest.of(0, 2);
        List<Products> cartsList = productRepository.findBuyProductsTwo(pageable);

        // JSP에서 계산 이뤄지게 하는 방식은 권장되지 않아서 서버딴에서 결제 처리
        int totalPrice = 0;

        for(Products products:cartsList) {
            totalPrice += products.getPrice() * products.getQuantity();
        }

        // session 가져오기
        session.getAttribute("user");

        model.addAttribute("cartsList", cartsList);
        model.addAttribute("totalPrice", totalPrice);
        return "order/orderForm";
    }

    // inicis 결제 요청 처리하기 (PaymentRequest => DTO로 사용)
    @RequestMapping(value = "order/inicisPay.do")
    @ResponseBody
    public String inicisPay(int price, String paymentType) {

        System.out.println("TEST");

        // 주문자 정보 insert
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("price",price);
        map.put("paymentType",paymentType);

        int res = orderMapper.insertOrders(map);
        System.out.println("결제성공");

        map.put("status", "success");

        return "map";
    }

    @RequestMapping(value = "order/insertInformation.do")
    @ResponseBody
    public String insertInformation(String name, String phone, String email,
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


        OrderItems orderItems = new OrderItems();
        orderItems.setOrderId(orderId);

        for(int i = 0; i < productIds.toArray().length; i++) {

            for (int productId : productIds) {
                System.out.println(productId);
                orderItems.setProductId(productId);
            }

            for (int itemPrice : itemPrices) {
                System.out.println(itemPrice);
                orderItems.setItemPrice(itemPrice);
            }

            for (int itemQuantity : itemQuantities) {
                System.out.println(itemQuantity);
                orderItems.setItemQuantity(itemQuantity);
            }

            orderItemsMapper.insertOrderItems(orderItems);

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
