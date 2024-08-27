package com.githrd.figurium.order.vo;

import lombok.Data;

@Data
public class Customers {

    int id;         // primary key
    int order_id;   // foreign key
    String name;
    String phone;
    String email;

}
