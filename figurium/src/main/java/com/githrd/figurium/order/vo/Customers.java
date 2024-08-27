package com.githrd.figurium.order.vo;

import jakarta.persistence.*;
import lombok.Data;

@Data           // Getter + Setter
@Entity         // 해당 테이블과 클래스가 매핑되게 설정
public class Customers {

    // 주문자 정보 테이블 (Create table customers)
    @GeneratedValue(strategy = GenerationType.IDENTITY) // MySQL = AUTO_INCREMENT 속성과 동일
    @Id
    int id;         // primary key


//    @ManyToOne
//    @JoinColumn(name="id")
//    Orders orders;  // foreign key

    @Column(nullable = false)   // not null 비허용
    String name;
    @Column(nullable = false)   // not null 비허용
    String phone;
    @Column(nullable = false)   // not null 비허용
    String email;

}
