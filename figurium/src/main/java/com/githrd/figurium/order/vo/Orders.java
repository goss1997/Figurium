package com.githrd.figurium.order.vo;

import jakarta.persistence.*;
import lombok.Data;

import java.util.Date;

@Data           // Getter + Setter
@Entity         // 해당 테이블과 클래스가 매핑되게 설정
public class Orders {

    // 주문 테이블 (Create table orders)
    @GeneratedValue(strategy = GenerationType.IDENTITY) // MySQL = AUTO_INCREMENT 속성과 동일
    @Id
    int id;             // primary key

    // user가 없어서 keep
    //    @ManyToOne
    //    @JoinColumn(name="id")
    //    User user;          // foreign key

    @Column(nullable = false, columnDefinition =
            "VARCHAR(20) DEFAULT '준비중' CHECK (status IN('준비중','출고대기','배송중','배송완료'))")
    String payment_type;
    @Column(nullable = false)   // not null 비허용
    int price;
    @Column(nullable = false)   // not null 비허용
    String status;
    @Column(nullable = false)   // not null 비허용
    Date order_time;



}
