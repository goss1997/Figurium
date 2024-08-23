package com.githrd.figurium.apidata.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "products")
@JsonIgnoreProperties(ignoreUnknown = true) // JSON에 있는 알려지지 않은 필드는 무시
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    private String title;

    private String maker;

    private String link;

    @JsonProperty("lprice")
    private String price;

    @JsonProperty("image")
    private String imageUrl;


}
