package com.githrd.figurium.qa.vo;

import jakarta.persistence.Column;
import jdk.jfr.Name;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class QaVo {
    private Integer id;
    private Integer userId;  // Integer 타입으로 설정


    private Integer ordersId;  // Integer 타입으로 설정
    private Integer productId;
    private String title;
    private String content;
    private String reply;
    private LocalDateTime created;
    private LocalDateTime updated;
    private String category;
    private String replyStatus;
    private String name;
}