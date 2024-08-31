package com.githrd.figurium.product.dao;

import com.githrd.figurium.product.vo.CartsVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.Map;

@Mapper
public interface CartsMapper {

    int insertCarts(Map<String, Object> map);
}
