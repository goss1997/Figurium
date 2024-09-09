package com.githrd.figurium.reviews.service;

import com.githrd.figurium.reviews.dao.ReviewMapper;
import com.githrd.figurium.reviews.vo.ReviewVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ReviewServiceImpl implements ReviewService {

    private final ReviewMapper reviewMapper;

    @Autowired
    public ReviewServiceImpl(ReviewMapper reviewMapper) {
        this.reviewMapper = reviewMapper;
    }

    @Override
    public List<ReviewVo> reviewsByProductId(Integer productId) {
        return reviewMapper.reviewsByProductId(productId);
    }

    @Override
    public int reviewCountByProductId(int productId) {
        return reviewMapper.reviewCountByProductId(productId);
    }

    @Override
    public int insertReview(ReviewVo reviewVo) {
        return reviewMapper.insertReview(reviewVo);
    }

    @Override
    public ReviewVo getReviewById(Integer id) {
        return reviewMapper.getReviewById(id);
    }

    @Override
    public String selectImageUrl(int id) {
        return reviewMapper.selectImageUrl(id);
    }

    @Override
    public int updateReview(ReviewVo reviewVo) {
        return reviewMapper.updateReview(reviewVo);
    }

    @Override
    public int deleteReview(ReviewVo reviewVo) {
        return reviewMapper.deleteReview(reviewVo);
    }

    @Override
    public int reviewRatingAvg(int productId) {
        Integer ratingAvg = reviewMapper.reviewRatingAvg(productId); // Integer로 변경
        if (ratingAvg != null) {
            // 소수점 이하 버림 (필요 없는 경우, 아래 주석 처리)
            return ratingAvg;
        }
        return 0; // 기본값
    }

    @Override
    public int selectRowTotal(int productId) {
        return reviewMapper.selectRowTotal(productId);
    }

    @Override
    public List<ReviewVo> selectAllWithPagination(Map<String, Object> map) {
        return reviewMapper.selectAllWithPagination(map);
    }

    @Override
    public List<ReviewVo> getReviewsWithPagination(int productId, int offset, int size) {
        Map<String, Object> map = new HashMap<>();
        map.put("productId", productId);
        map.put("offset", offset);
        map.put("size", size);
        return reviewMapper.selectAllWithPagination(map);
    }


}
