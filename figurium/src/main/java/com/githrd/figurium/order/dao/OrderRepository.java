package com.githrd.figurium.order.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Map;

@Repository
public class OrderRepository {

    private SqlSession sqlSession;

    @Autowired
    public OrderRepository(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    // 결제완료시 orders table에 insert
    public void insertOrder(Map<String, Object> map) {
        sqlSession.insert("orders.insertOrders", map);
    }
}
