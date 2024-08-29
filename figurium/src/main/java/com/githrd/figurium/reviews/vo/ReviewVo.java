package com.githrd.figurium.reviews.vo;

import lombok.*;
import org.apache.ibatis.type.Alias;

@Data
@NoArgsConstructor  // Default Constructor
@AllArgsConstructor // All Property넣어준 Overload된 생성자
@Alias("reviews")
public class ReviewVo {

    int id;
    int userId;
    int productId;
    int rating;

    String content;
    String createdAt;
    String updatedAt;

}
