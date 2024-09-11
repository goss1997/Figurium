package com.githrd.figurium.order;


import com.githrd.figurium.order.service.OrderService;
import com.githrd.figurium.product.dao.ProductsMapper;
import org.junit.Test;
import org.junit.jupiter.api.BeforeEach;
import org.mockito.Mock;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.concurrent.locks.Lock;

@SpringBootTest
public class OrderTest {

    @Mock
    private ProductsMapper productsMapper;

    @Mock
    private OrderService orderService;

    @Mock
    private Lock lock;

    @BeforeEach
    public void setUp() {
        int num1 = 10;
        int num2 = 20;
        System.out.println("Before");
    }

    @Test
    public void testUpdateProductQuantity() {

    }
}
