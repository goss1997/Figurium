package com.githrd.figurium.product.controller;

import com.githrd.figurium.common.session.SessionConstants;
import com.githrd.figurium.product.dao.CartsMapper;
import com.githrd.figurium.product.service.CartService;
import com.githrd.figurium.product.vo.CartsVo;
import com.githrd.figurium.user.entity.User;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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
        public String shoppingCart(Model model, int productId, int quantity) {

        // 세션에서 로그인 사용자 정보 가져오기
        User loginUser = (User)session.getAttribute(SessionConstants.LOGIN_USER);

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

        return "redirect:/CartList.do";

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

            User loginUser = (User) session.getAttribute(SessionConstants.LOGIN_USER);

            List<CartsVo> cartsVo = cartsMapper.selectList(loginUser.getId());

            model.addAttribute("cartsVo", cartsVo);

            return "products/shopingCart";
        }




        // 해당 상품이 장바구니에 있는지 확인
        @RequestMapping("checkCartItem")
        @ResponseBody
        public Map<String, Object> checkCartItem(@RequestParam("productId") int productId,
                                                 @RequestParam("user") int userId,
                                                 @RequestParam("productQuantity") int productQuantity) {
            Map<String, Object> response = new HashMap<>();

            // 장바구니에 상품이 있는지 확인
            int checksCartItem = cartService.checksCartItem(productId, userId);

            // 장바구니에 담긴 특정 상품의 수량 확인
            int cartsQuantity = cartService.checkProductQuantity(productId, userId);

            // 현재 상품의 총 재고 수 확인
            int productsQuantity = cartsMapper.getProductQuantity(productId);

            // 현재 장바구니에 담겨있는 재고 수 + 추가하려는 수량
            int totalQuantity = cartsQuantity + productQuantity;

            // 상품이 장바구니에 존재하는지 체크
            if (checksCartItem > 0) {
                response.put("selectProductsCart", true); // 성공시 true
            } else {
                response.put("selectProductsCart", false); // 실패시 false
            }

            // 재고 초과 여부를 체크
            if (totalQuantity > productsQuantity) {
                response.put("selectProductsQuantity", true); // 재고 초과시 true 반환
                response.put("message", "장바구니에 상품의 남은 재고수량을 초과하여 추가 하실 수 없습니다.");
            } else {
                response.put("selectProductsQuantity", false); // 정상적으로 장바구니에 담을 수 있는 경우 false 반환
            }

            return response;
        }

    // 장바구니 아이콘에 로그인한 사용자의 장바구니에 있는 상품의 갯수를 나타내기
    @RequestMapping("cartItemCount")
    @ResponseBody
    public ResponseEntity<Integer> cartItemCount(HttpSession session) {

        // 세션에서 User 객체를 가져오기
        User user = (User) session.getAttribute(SessionConstants.LOGIN_USER);

        // User가 세션에 존재하지 않을 경우
        if (user == null) {
            return ResponseEntity.ok(0); // 장바구니에 들어있는 상품의 수가 0개
        }

        // User 객체에서 userId 추출
        Integer userId = user.getId();
        System.out.println("userId: " + userId);

        // 장바구니 상품 수를 가져오기
        int cartItemCount = cartService.cartItemCount(userId);

        return ResponseEntity.ok(cartItemCount);
    }


    /*장바구니 에서 동시성 검사*/
    @PostMapping("/checkProductStock")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> checkProductStock(@RequestBody List<Map<String, Integer>> items) {
        List<Integer> outOfStockProductIds = cartService.checkProductStock(items);
        Map<String, Object> response = new HashMap<>();

        if (!outOfStockProductIds.isEmpty()) {

            response.put("status", "error");
            response.put("message", "재고가 부족한 상품이 있습니다.");
            response.put("outOfStockProductIds", outOfStockProductIds);
        } else {
            response.put("status", "success");
            response.put("message", "모든 상품의 재고가 충분합니다.");
        }

        return ResponseEntity.ok(response);
    }




}
