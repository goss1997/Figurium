package com.githrd.figurium.order.vo;

import lombok.Data;

import java.util.Date;

@Data           // Getter + Setter
public class Orders {

    // 주문 테이블 (Create table orders)
    int id;             // primary key
    int userId;        // foreign key
    String paymentType;
    int price;
    String status;
    Date orderTime;



}
