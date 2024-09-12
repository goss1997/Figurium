package com.githrd.figurium.product.controller;

import com.githrd.figurium.product.dao.CartsMapper;
import com.githrd.figurium.product.dao.ProductsMapper;
import com.githrd.figurium.product.service.CartService;
import com.githrd.figurium.product.vo.CartsVo;
import com.githrd.figurium.user.entity.User;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
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
public class CartsController {

    private final HttpSession session;
    private final CartsMapper cartsMapper;
    private final CartService cartService;

    @Autowired
    public CartsController(HttpSession session,
                           CartsMapper cartsMapper,
                           CartService cartService) {
        this.session = session;
        this.cartsMapper = cartsMapper;
        this.cartService = cartService;
    }

    // 장바구니에 담기
    @RequestMapping("/shoppingCart.do")
        public String shopingCart(Model model, int productId, int quantity) {

        // 세션에서 로그인 사용자 정보 가져오기
        User loginUser = (User)session.getAttribute("loginUser");

        // 로그인 사용자 정보가 null인지 체크
        if (loginUser == null) {
            model.addAttribute("errorMessage", "로그인 후 구매가 가능합니다.");
            return "redirect:/";
        }

        // 이 상품이 추가가 되어있으면, 장바구니에 상품 추가를 거치지 않고 넘기기
        CartsVo checkCart = cartsMapper.selectCartsById(productId,loginUser.getId());
        System.out.println(checkCart);
        if (checkCart == null) {
            Map<String, Object> map = new HashMap<>();
            map.put("loginUserId", loginUser.getId());
            map.put("productId", productId);
            map.put("quantity", quantity);

            // 장바구니에 해당 ID로 상품 추가
            cartsMapper.insertCarts(map);
            System.out.println("추가성공!!!!");

        } else {
            // 기존의 수량 업데이트
            cartsMapper.updateCartItemQuantity(checkCart.getId(), checkCart.getQuantity() + quantity);
        }



        // 장바구니 목록 다시 가져오기
        List<CartsVo> cartsVo = cartsMapper.selectList(loginUser.getId());
        model.addAttribute("cartsVo", cartsVo);


        return "products/shopingCart";
        }

        // 장바구니에 담긴 상품 삭제
        @RequestMapping(value = "/CartDelete.do")
        @ResponseBody
        public String CartDelete(@RequestParam(value = "productId") int productId,
                                 @RequestParam(value = "loginUserId") int  loginUserId ) {

            int res = cartsMapper.deleteCartProduct(productId, loginUserId);
            System.out.println("productId = " + productId);
            System.out.println("loginUserId = " + loginUserId);
            return "success";
        }

        // 내 장바구니 리스트 호출
        @RequestMapping(value = "/CartList.do")
        public String CartList( Model model) {

            User loginUser = (User) session.getAttribute("loginUser");

            List<CartsVo> cartsVo = cartsMapper.selectList(loginUser.getId());

            model.addAttribute("cartsVo", cartsVo);

            return "products/shopingCart";
        }

        // 해당 상품이 장바구니에 있는지 확인
    @RequestMapping("checkCartItem")
    @ResponseBody
    public Map<String,Object> checkCartItem(@RequestParam("productId") int productId,
                                            @RequestParam("user") int userId) {
        Map<String,Object> response = new HashMap<>();

        int result = cartService.checksCartItem(productId, userId);

        if (result > 0) {
            response.put("data",true); // 성공시 ture
        }else {
            response.put("data",false); // 실패시 false
        }

        return response;

    }



}
