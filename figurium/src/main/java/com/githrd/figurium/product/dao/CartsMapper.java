package com.githrd.figurium.product.dao;

import com.githrd.figurium.product.vo.CartsVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface CartsMapper {

    int insertCarts(Map<String, Object> map);
    List<CartsVo> selectList(int loginUserId);
    CartsVo selectCartsById(int productId,int loginUserId);
    int deleteCartProduct(int productId, int loginUserId);
    int updateCartQuantity(CartsVo cartsVo);


    /* 장바구니에 상세 페이지의 상품 추가 로직 */

    // 장바구니 내부에 아이템이 존재 하는지 확인
    CartsVo getCartItem (int userId, int productId);

    // 장바구니에 상품을 추가
    int insertCartItem(int userId, int productId, int quantity);

    // 장바구니에 상품의 수량을 업데이트
    int updateCartItemQuantity(int cartId, int quantity);

    // 장바구니 에서 선택된 상품만 전달
    List<CartsVo> checksCartItemList(int userId, List<Integer> productId);

    // 즉시구매처리하기
    List<CartsVo> checksCartItemOne(int productId, int userId);

    // 장바구니에 담기전에 해당 상품이 장바구니에 존재하는지 확인
    int checksCartItem(Map<String, Object> params);

    // 현재 상품의 총 재고 수량을 가져옴
    int getProductQuantity(int productId);

    // 장바구니에 상품을 담기 전 해당 상품의 재고가 있는지 확인
    int checkProductQuantity(int productId, int userId);

    int cartItemCount(int userId);

    // 상품 삭제시 장바구니에 있는 모든 상품(id) 삭제
    void deleteCartProductAll(int productId );

    List<CartsVo> selectCartsByProductId(int productId);

}
