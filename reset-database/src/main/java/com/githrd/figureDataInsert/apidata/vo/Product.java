package com.githrd.figureDataInsert.apidata.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true) // JSON에 있는 알려지지 않은 필드는 무시
public class Product {

    private String categoryName;

    @JsonProperty("title")
    private String name;

    @JsonProperty("lprice")
    private String price;

    private int quantity;


    @JsonProperty("image")
    private String imageUrl;


}
