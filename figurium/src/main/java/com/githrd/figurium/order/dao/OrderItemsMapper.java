package com.githrd.figurium.order.dao;

import com.githrd.figurium.order.vo.OrderItems;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface OrderItemsMapper {

    int insertOrderItems(OrderItems orderItems);
}