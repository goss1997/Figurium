package com.githrd.figurium.productLike.vo;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Getter
@Setter
@Alias("product_likes")
public class ProductLikeVo {

    int id;
    int userId;
    int productId;
    int productCount;

}
