package com.githrd.figurium.reviews.service;

import com.githrd.figurium.reviews.vo.ReviewVo;

import java.util.List;


public interface ReviewService {

    List<ReviewVo> reviewsByProductId(Integer productId);

    int reviewCountByProductId(int productId);

    int insertReview(ReviewVo reviewVo);





}
