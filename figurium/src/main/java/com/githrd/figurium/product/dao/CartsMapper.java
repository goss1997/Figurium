package com.githrd.figurium.product.dao;

import com.githrd.figurium.product.vo.CartsVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface CartsMapper {

    int insertCarts(Map<String, Object> map);
    List<CartsVo> selectList(int loginUserId);
    CartsVo selectCartsById(int productId);
    int deleteCartProduct(int productId, int loginUserId);
    int updateCartQuantity(CartsVo cartsVo);


    /* 장바구니에 상세 페이지의 상품 추가 로직 */


    // 장바구니에 상품을 추가하거나 수량을 업데이트
    public void addProductCart(int userId , int productId, int quantity);

    // 장바구니 내부에 아이템이 존재 하는지 확인
    CartsVo getCartItem (int userId, int productId);

    // 장바구니에 상품을 추가
    int insertCartItem(int userId, int productId, int quantity);

    // 장바구니에 상품의 수량을 업데이트
    int updateCartItemQuantity(int cartId, int quantity);

}
