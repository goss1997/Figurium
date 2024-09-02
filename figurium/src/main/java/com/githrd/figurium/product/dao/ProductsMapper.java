package com.githrd.figurium.product.dao;

import com.githrd.figurium.product.vo.ProductsVo;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ProductsMapper {

    ProductsVo selectOneGetName(int productId);
    ProductsVo selectOneCheckProduct(int productId, int itemQuantity);
    int updateProductQuantity(int productId, int itemQuantity);
}
