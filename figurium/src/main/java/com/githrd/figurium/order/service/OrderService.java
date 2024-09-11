package com.githrd.figurium.order.service;

import com.githrd.figurium.order.vo.MyOrderVo;
import com.githrd.figurium.product.vo.CartsVo;

import java.util.List;

public interface OrderService {

    // 전체조회
    int updateCartQuantityRight(int quantity, int loginUserId, int productId);

    int calculateTotalPrice(List<CartsVo> cartsVoList);

    List<MyOrderVo> selectListByUserId(int userId);

    int updateProductQuantity(int productId, int loginUserId);

    // 상품 재고 체크
    String checkProductStock(List<Integer> productIds, List<Integer> itemQuantities);

    // Order 주문 정보 저장
    int insertOrder(int price, String paymentType, Integer userId, String merchantUid);

    // 장바구니 상품 삭제, 구매 상품 정보 저장
    int updateProductInfo(List<Integer> productIds, List<Integer> itemPrices, List<Integer> itemQuantities, int loginUserId);

    // 주문자 정보 저장
    int insertCustomer(int orderId, String name, String phone, String email);

    // 배송지 정보 저장
    int insertShippingAddresses(int orderId, String recipientName, String shippingPhone, String address, String deliveryRequest);
}
