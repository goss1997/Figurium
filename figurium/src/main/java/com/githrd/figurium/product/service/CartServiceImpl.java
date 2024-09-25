package com.githrd.figurium.product.service;

import com.githrd.figurium.product.dao.CartsMapper;
import com.githrd.figurium.product.vo.CartsVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CartServiceImpl implements CartService {

    private final CartsMapper cartsMapper;

    @Autowired
    public CartServiceImpl(CartsMapper cartsMapper) {
        this.cartsMapper = cartsMapper;
    }


    // 장바구니에 상품 추가 또는 상품 수량을 업데이트
    @Override
    @Transactional
    public void addProductCart(int userId, int productId, int quantity) {

        CartsVo cartItem = cartsMapper.getCartItem(userId, productId);

        // 장바구니 내부에 상품이 존재 할 경우 수량 업데이트
        if (cartItem != null) {
            int newQuantity = cartItem.getQuantity() + quantity;
            cartsMapper.updateCartItemQuantity(cartItem.getId(), newQuantity);
        } else {
            // 장바구니에 상품이 없을 경우 상품을 추가
            cartsMapper.insertCartItem(userId, productId, quantity);
        }

    }

    @Override
    @Transactional
    public List<CartsVo> checksCartItemList(int userId, List<Integer> productId) {
        return cartsMapper.checksCartItemList(userId, productId);
    }

    @Override
    @Transactional
    public int checksCartItem(int productId, int userId) {
        Map<String,Object> params = new HashMap<>();
        params.put("productId", productId);
        params.put("userId", userId);
        return cartsMapper.checksCartItem(params);
    }

    @Override
    @Transactional
    public int checkProductQuantity(int productId, int userId) {
        return cartsMapper.checkProductQuantity(productId, userId);
    }

    @Override
    @Transactional
    public int getProductQuantity(int productId) {
        return cartsMapper.getProductQuantity(productId);
    }

    @Override
    @Transactional
    public int cartItemCount(int userId) {
        return cartsMapper.cartItemCount(userId);
    }
}
