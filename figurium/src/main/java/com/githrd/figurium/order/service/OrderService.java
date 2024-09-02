package com.githrd.figurium.order.service;

import com.githrd.figurium.order.vo.MyOrderVo;
import com.githrd.figurium.product.vo.CartsVo;

import java.util.List;

public interface OrderService {

    // 전체조회
    List<CartsVo> updateCartQuantities(int loginUserId, List<Integer> quantities);

    int calculateTotalPrice(List<CartsVo> cartsVoList);

    List<MyOrderVo> selectListByUserId(int userId);
}
