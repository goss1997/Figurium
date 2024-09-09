package com.githrd.figurium.product.dao;

import com.githrd.figurium.product.entity.Products;
import com.githrd.figurium.product.vo.ProductsVo;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface ProductsMapper {

    ProductsVo selectOneGetName(int productId);
    ProductsVo selectOneCheckProduct(int productId, int itemQuantity);
    int updateProductQuantity(int productId, int itemQuantity);
    int productInsert(ProductsVo vo);
    int productUpdate(ProductsVo vo);


}
