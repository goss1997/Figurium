package com.githrd.figurium.product.service;


import com.githrd.figurium.product.vo.CartsVo;

import java.util.List;
import java.util.Map;

public interface CartService {

    public void addProductCart(int userId , int productId, int quantity);

    List<CartsVo> checksCartItemList(int userId, List<Integer> productId);

    int checksCartItem(int productId , int userId);

    int checkProductQuantity(int productId , int userId);

    int getProductQuantity(int productId);

    int cartItemCount(int userId);

    Map<Integer,Integer> checkProductStock(List<Map<String, Integer>> items);

    void productDeleteAlram(int productId);

}
