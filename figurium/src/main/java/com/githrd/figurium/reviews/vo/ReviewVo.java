package com.githrd.figurium.reviews.vo;

import lombok.*;
import org.apache.ibatis.type.Alias;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor  // Default Constructor
@AllArgsConstructor // All Property넣어준 Overload된 생성자
@Alias("reviews")
public class ReviewVo {

    private int id;
    private int userId;
    private int productId;
    private int rating;
    private int number; // number를 주기위해 추가

    private String title;
    private String content;
    private String imageUrl;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    private String userName; // Join해서 데이터를 가져오기 위해 추가

}
