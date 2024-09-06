package com.githrd.figurium.reviews.service;

import com.githrd.figurium.reviews.vo.ReviewVo;

import java.util.List;
import java.util.Map;


public interface ReviewService {

    List<ReviewVo> reviewsByProductId(Integer productId);

    int reviewCountByProductId(int productId);

    int insertReview(ReviewVo reviewVo);

    ReviewVo getReviewById(Integer id);

    String selectImageUrl(int id);

    int updateReview(ReviewVo reviewVo);

    int deleteReview(ReviewVo reviewVo);

    int reviewRatingAvg(int productId);

    // 페이징 처리를 위한 리뷰의 갯수를 반환
    int selectRowTotal(Map<String, Object> map);

    // 페이징 처리를 한 후 리뷰의 리스트를 가져오기
    List<ReviewVo> selectAllWithPagination(Map<String, Object> map);

    public List<ReviewVo> getReviewsWithPagination(int productId, int offset, int size);





}
