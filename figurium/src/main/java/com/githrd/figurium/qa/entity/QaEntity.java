package com.githrd.figurium.qa.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

import java.util.Date;

@Data
@Entity
@Table(name = "qa")
public class QaEntity {

    @Id
    Integer id;

    Integer productId;
    Integer userId;

    String title;
    String content;

    String recontent;

    String created;
    String updated;

}
