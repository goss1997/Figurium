package com.githrd.figurium.product.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.ToString;

import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "products")  // 실제 테이블 이름을 명시적으로 지정합니다.
@ToString
public class Products {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // ID가 자동으로 생성되도록 설정
    private int id;

    @ManyToOne
    @JoinColumn(name = "category_name", nullable = false) // 외래 키 필드 이름을 지정
    private Category category;

    private String name;

    private int price;
    private int quantity;

    private String imageUrl;

    // String Type -> LocalDateTime 변경
    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

}
