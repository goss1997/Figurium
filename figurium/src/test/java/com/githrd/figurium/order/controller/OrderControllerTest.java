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

// 이 Test는 동시성 주문 (재고 차감)에 대한 검증을 위한 테스트 입니다.
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

        // 5개의 스레드 사용
        int threadCount = 5;

        // 최대 5개의 스레드 동시 사용 설정
        ExecutorService executorService = Executors.newFixedThreadPool(5);
        // 모든 스레드가 완료될 때까지 기다리는 카운터를 설정
        CountDownLatch latch = new CountDownLatch(threadCount);

        // 이 과정을 몇번 실행할 것인가(5번)
        for(int i = 0; i < threadCount; i++) {
            executorService.submit(()-> {
                try {
                     // productId 5번 상품의 재고(9개)를 1개씩 차감 시킨다.
                    boolean result = orderService.updateProductQuantity(5,1);   // 재고 차감 Serivce
                    System.out.println(result);

                } finally {
                    latch.countDown();  // 카운터를 감소시킨다.
                }
            });
        }

        latch.await();  // 모든 스레드가 작업을 마칠 때까지 대기
        assertEquals(4, productsMapper.getProductQuantity(5));  // 상품번호 2번의 재고가 5개인지 검증

    }
}