package com.githrd.figurium.order.dao;

import com.githrd.figurium.order.vo.Orders;
import org.apache.ibatis.annotations.Mapper;

import java.util.Map;

@Mapper
public interface OrderMapper {

    int insertOrders(Map<String, Object> map);
    Orders selectOneLast();
}