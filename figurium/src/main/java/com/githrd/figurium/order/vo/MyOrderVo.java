package com.githrd.figurium.order.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.apache.ibatis.type.Alias;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Alias("myOrders")
public class MyOrderVo {

    private int id;             // 주문번호
    private String paymentType; // 결제타입
    private int userId;         // user번호
    private String status;      // 주문상태
    private String createdAt;   // 주문생성시간
    private String valid;       // 주문유효값  ( 결제  <==> 환불   상태 확인용 y = 결제완료   n = 환불

    private int price;          // 주문상품가격
    private int quantity;       // 주문상품갯수
    private String name;        // 이름

    private String customerPhone;   // 주문한 사람 번호
    private String email;           // 주문한 사람 이메일

    private String recipientName;   // 받는 사람 이름
    private String phone;           // 받는 사람 번호

    private String address;         // 받는 사람 주소
    private String deliveryRequest; // 배송요청사항

    private String productName;     // 상품이름
    private String imageUrl;        // 상품이미지
    private int productCount;       // 상품총갯수 - 1(외 1개, 외 2개 별도로 포함시키려는 컬럼)

    // sum(price * quantity) as total_value  -- 각 행의 price * quantity의 총합
    private int totalValue;         // order 번호에 대한 총가격 계산 컬럼


}
