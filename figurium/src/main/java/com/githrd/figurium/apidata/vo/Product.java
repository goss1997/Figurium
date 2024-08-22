package com.githrd.figurium.apidata.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name="products")
@JsonIgnoreProperties(ignoreUnknown = true) // JSON에 있는 알려지지 않은 필드는 무시
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    private String title;

    private String link;

    private String image;

    private String lprice;

    private String mallName;

    private String productId;

    private String productType;

    private String brand;

    private String maker;


}
