package com.githrd.figurium.order.vo;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Data;

@Data           // Getter + Setter
@Entity         // 해당 테이블과 클래스가 매핑되게 설정
public class ShippingAddresses {

    // 배송지 정보 테이블 (Create table shipping_addresses)
    @GeneratedValue(strategy = GenerationType.IDENTITY) // MySQL = AUTO_INCREMENT 속성과 동일
    @Id
    int id;             // primary key

    int order_id;       // foreign key
    String recipient_name;
    String phone;
    String address;
    String delivery_request;

}
