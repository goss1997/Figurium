package com.githrd.figurium.order.vo;

import lombok.Data;

import java.util.Date;

@Data
public class Order {

    // 주문 테이블 (Create table orders)
    int id;             // primary key
    int user_id;        // foreign key
    String payment_type;
    int price;
    String status;
    Date order_time;



}
