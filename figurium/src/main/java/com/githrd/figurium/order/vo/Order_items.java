package com.githrd.figurium.order.vo;

import jakarta.persistence.*;
import lombok.Data;

@Data           // Getter + Setter
@Entity         // 해당 테이블과 클래스가 매핑되게 설정
public class Order_items {

    // 주문 상품 테이블 (Create table order_items)
    @GeneratedValue(strategy = GenerationType.IDENTITY) // MySQL = AUTO_INCREMENT 속성과 동일
    @Id
    int id;         // primary key


//    @ManyToOne
//    int order_id;   // orders foreign key
    int product_id; // products foreign key
    int price;
    int quantity;


}
