package com.githrd.figurium.product.service;


import com.githrd.figurium.product.vo.CartsVo;

import java.util.List;

public interface CartService {

    public void addProductCart(int userId , int productId, int quantity);

    List<CartsVo> checksCartItemList(int userId, List<Integer> productId);

}
