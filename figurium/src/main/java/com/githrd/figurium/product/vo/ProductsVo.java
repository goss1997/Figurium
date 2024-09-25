package com.githrd.figurium.product.vo;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("products")
public class ProductsVo {

    // 상품 테이블 (Create table products)
    int id;         // primary key
    String categoryName;
    String name;
    int price;
    int quantity;
    String imageUrl;
    int isDeleted;
    String createdAt;
    String updatedAt;
    int likeCount;

    String searchName;

}
