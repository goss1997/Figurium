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

    private int orderId;
    private int userId;
    private String paymentType;
    private int price;
    private String status;
    private String createdAt;
    private String productName;
    private String imageUrl;
    private int remainCount;


}
