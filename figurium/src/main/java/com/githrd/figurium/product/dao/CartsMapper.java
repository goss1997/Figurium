package com.githrd.figurium.product.dao;

import com.githrd.figurium.product.vo.CartsVo;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CartsMapper {

    int insertCarts(CartsVo cartsVo);
}
