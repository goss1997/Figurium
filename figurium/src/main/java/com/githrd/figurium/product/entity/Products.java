package com.githrd.figurium.product.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table
public class Products {

    @Id
    int id;

    int categoryId;

    String name;

    int price;
    int quantity;

    String image_url;
    String created_at;
    String updated_at;


}
