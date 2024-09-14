package com.githrd.figurium.order.dao;

import com.githrd.figurium.order.vo.ShippingAddresses;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ShippingAddressesMapper {

    int insertShippingAddresses(ShippingAddresses shippingAddresses);
}