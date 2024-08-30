package com.githrd.figurium.order.dao;

import com.githrd.figurium.order.vo.Customers;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CustomersMapper {

    int insertCustomers(Customers customers);
}