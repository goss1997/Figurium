package com.githrd.figurium.order.vo;

import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.util.Date;

@Data           // Getter + Setter
@Alias("orders")
public class Orders {

    // 주문 테이블 (Create table orders)
    int id;             // primary key
    int userId;        // foreign key
    String paymentType;
    int price;
    String status;
    Date createdAt;



}
