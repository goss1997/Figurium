package com.githrd.figurium.order.dto;

import lombok.Data;

// ShopingOrderController에서 사용하는 inicisPay() 메서드에서
// 받아오는 parameter 값을 더 깔끔하게 쓰기위해서 DTO 클래스를 분리
@Data
public class PaymentRequest {
    private int itemPrice;
    private String memName;
    private String orderName;
    private String orderPhone;
    private String orderEmail;
    private String shippingAddress;
    private String shippingName;
    private String shippingPhone;
    private String deliveryRequest;
    private String paymentType;
    private String[] itemNames;
    private int[] itemPrices;
    private int[] itemQuantities;
}
