package com.githrd.figurium.product.dto;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("productDto")
public class ProductDto {

    String name;
    String imageUrl;
}
