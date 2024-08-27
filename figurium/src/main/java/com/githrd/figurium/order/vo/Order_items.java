package com.githrd.figurium.order.vo;

import lombok.Data;

@Data
public class Order_items {

    // 주문 상품 테이블 (Create table order_items)
    int id;         // primary key
    int order_id;   // orders foreign key
    int product_id; // products foreign key
    int price;
    int quantity;


}
