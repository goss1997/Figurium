package com.githrd.figurium.order.controller;

import com.githrd.figurium.common.session.SessionConstants;
import com.githrd.figurium.exception.customException.OutofStockException;
import com.githrd.figurium.order.service.OrderService;
import com.githrd.figurium.product.dao.CartsMapper;
import com.githrd.figurium.product.vo.CartsVo;
import com.githrd.figurium.user.entity.User;
import com.githrd.figurium.user.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
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
    @PostMapping("orderFormRight.do")
    public String orderFormRight(@RequestParam(required = false) Integer quantity,
                            @RequestParam(required = false) Integer productId,
                            HttpSession session,
                            Model model) {

        User user = (User) session.getAttribute(SessionConstants.LOGIN_USER);

        // 모바일 결제에서 session을 받아서 다시 값을 redirect 시켜주는 경우
        if (productId == null) {

            // 처음에 결제/주문 페이지로 넘어갈때 저장한 session 값 가져오기
            List<CartsVo> cartsList = (List<CartsVo>) session.getAttribute("sessionCartsList");
            int totalPrice = (int) session.getAttribute("sessionTotalPrice");

            model.addAttribute("cartsList", cartsList);
            model.addAttribute("totalPrice", totalPrice);
            session.setAttribute("sessionTotalPrice", totalPrice);
            return "order/orderForm";
        }

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
        session.setAttribute("sessionCartsList", cartsList);
        session.setAttribute("sessionTotalPrice", totalPrice);
        return "order/orderForm";
    }


    /*
     *   주문/결제창
     */
    @PostMapping("orderForm.do")
    public String orderForm(@RequestParam(required = false) List<Integer> cartQuantities,
                            @RequestParam(required = false) List<Integer> productId,
                            HttpSession session,
                            Model model,
                            HttpServletRequest request) {

        User user = (User) session.getAttribute(SessionConstants.LOGIN_USER);
        int loginUserId = user.getId();


        // 모바일 결제에서 session을 받아서 다시 값을 redirect 시켜주는 경우
        if (productId == null || productId.isEmpty()) {

            // 처음에 결제/주문 페이지로 넘어갈때 저장한 session 값 가져오기
            List<CartsVo> cartsList = (List<CartsVo>) session.getAttribute("sessionCartsList");
            int totalPrice = (int) session.getAttribute("sessionTotalPrice");

            model.addAttribute("cartsList", cartsList);
            model.addAttribute("totalPrice", totalPrice);
            session.setAttribute("sessionTotalPrice", totalPrice);
            return "order/orderForm";
        }

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

        // 리다이렉트 URL 생성
        String redirectUrl = request.getRequestURL().toString();
        redirectUrl += "?";
        for (int i = 0; i < productId.size(); i++) {
            redirectUrl += "productId=" + productId.get(i) + "&";
            redirectUrl += "cartQuantities=" + cartQuantities.get(i) + "&";
        }
        // 마지막 '&' 제거
        redirectUrl = redirectUrl.substring(0, redirectUrl.length() - 1);
        log.info("작성된주소명 : {}", redirectUrl);

        model.addAttribute("redirectUrl", redirectUrl);


        model.addAttribute("cartsList", cartsList);
        model.addAttribute("totalPrice", totalPrice);
        session.setAttribute("sessionCartsList", cartsList);
        session.setAttribute("sessionTotalPrice", totalPrice);
        return "order/orderForm";
    }


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

}
