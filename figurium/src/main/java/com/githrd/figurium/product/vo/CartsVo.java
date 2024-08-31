package com.githrd.figurium.product.vo;

import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.util.Date;

@Data
@Alias("carts")
public class CartsVo {

    // 쇼핑 카트 테이블 (Create table carts)
    int id;         // primary key
    int user_id;
    int product_id;
    int quantity;
    Date added_time;


}
