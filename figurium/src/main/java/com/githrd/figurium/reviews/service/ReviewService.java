package com.githrd.figurium.reviews.service;

import com.githrd.figurium.reviews.vo.ReviewVo;

import java.util.List;


public interface ReviewService {

    List<ReviewVo> reviewsByProductId(Integer productId);

    int reviewCountByProductId(int productId);

    int insertReview(ReviewVo reviewVo);

    ReviewVo getReviewById(Integer id);

    String selectImageUrl(int id);

    int updateReview(ReviewVo reviewVo);

    int deleteReview(ReviewVo reviewVo);

    int reviewRatingAvg(int productId);
}
