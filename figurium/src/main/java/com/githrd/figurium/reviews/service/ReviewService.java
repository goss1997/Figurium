package com.githrd.figurium.reviews.service;

import com.githrd.figurium.reviews.vo.ReviewVo;

import java.util.List;


public interface ReviewService {

    List<ReviewVo> selectList();

    int insertReview(ReviewVo reviewVo);





}
