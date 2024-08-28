package com.githrd.figurium.order.dao;

import com.githrd.figurium.order.vo.Orders;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class OrderRepository {

    private SqlSession sqlSession;

    @Autowired
    public OrderRepository(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    // 결제완료시 orders table에 insert
    public void insertOrder(Orders orders) {
        sqlSession.insert("orders.insertOrders", orders);
    }
}
