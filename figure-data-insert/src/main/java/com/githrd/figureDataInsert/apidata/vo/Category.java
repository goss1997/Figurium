package com.githrd.figureDataInsert.apidata.vo;

import jakarta.persistence.*;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
public class Category {

    private String name;

    public Category() {

    }
    public Category(String name) {
        this.name = name;
    }

}