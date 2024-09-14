package com.githrd.figurium.order.vo;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data           // Getter + Setter
@Alias("orderItems")
public class OrderItems {

    // 주문 상품 테이블 (Create table order_items)
    int id;         // primary key
    int orderId;   // orders foreign key
    int productId; // products foreign key
    int itemPrice;
    int itemQuantity;

}
