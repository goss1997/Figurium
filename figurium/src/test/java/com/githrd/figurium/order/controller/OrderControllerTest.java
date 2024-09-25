package com.githrd.figurium.order.controller;

import com.githrd.figurium.order.service.OrderServiceImpl;
import com.githrd.figurium.product.dao.ProductsMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import static org.junit.Assert.assertEquals;

@SpringBootTest
public class OrderControllerTest {

    @Autowired
    private OrderServiceImpl orderService;
    @Autowired
    private ProductsMapper productsMapper;

    @BeforeEach
    public void before() {
    }

    @Test
    public void testConcurrentOrders() throws InterruptedException {

        // 100개 요청
        int threadCount = 5;

        // 멀티스레드 이용
        ExecutorService executorService = Executors.newFixedThreadPool(5);
        CountDownLatch latch = new CountDownLatch(threadCount);

        for(int i = 0; i < threadCount; i++) {
            executorService.submit(()-> {
                try {
                     // 재고 9개 - 1개씩 차감
                    boolean result = orderService.updateProductQuantity(2,1);
                    System.out.println(result);

                } finally {
                    latch.countDown();
                }
            });
        }

        latch.await();
        assertEquals(5, productsMapper.getProductQuantity(2));

    }
}