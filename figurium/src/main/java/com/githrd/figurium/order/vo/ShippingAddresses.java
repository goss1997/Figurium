package com.githrd.figurium.order.vo;

import lombok.Data;

@Data
public class ShippingAddresses {

    int id;             // primary key
    int order_id;       // foreign key
    String recipient_name;
    String phone;
    String address;
    String delivery_request;

}
