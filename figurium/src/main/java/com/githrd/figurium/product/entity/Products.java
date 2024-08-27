package com.githrd.figurium.product.entity;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "products")  // 실제 테이블 이름을 명시적으로 지정합니다.
public class Products {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // ID가 자동으로 생성되도록 설정
    private int id;

    @ManyToOne
    @JoinColumn(name = "category_id", nullable = false) // 외래 키 필드 이름을 지정
    private Category category;

    private String name;

    private int price;
    private int quantity;

    private String imageUrl;
    private String createdAt;
    private String updatedAt;
}
