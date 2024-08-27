package com.githrd.figurium.order.vo;

import lombok.Data;

@Data           // Getter + Setter
public class Customers {

    // 주문자 정보 테이블 (Create table customers)
    int id;         // primary key
    int orderId;
    String name;
    String phone;
    String email;

}
