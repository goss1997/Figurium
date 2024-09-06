package com.githrd.figurium.reviews.service;

import com.githrd.figurium.reviews.dao.ReviewDao;
import com.githrd.figurium.reviews.vo.ReviewVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ReviewServiceImpl implements ReviewService {

    private final ReviewDao reviewDao;

    @Autowired
    public ReviewServiceImpl(ReviewDao reviewDao) {
        this.reviewDao = reviewDao;
    }

    @Override
    public List<ReviewVo> reviewsByProductId(Integer productId) {
        return reviewDao.reviewsByProductId(productId);
    }

    @Override
    public int reviewCountByProductId(int productId) {
        return reviewDao.reviewCountByProductId(productId);
    }

    @Override
    public int insertReview(ReviewVo reviewVo) {
        return reviewDao.insertReview(reviewVo);
    }

    @Override
    public ReviewVo getReviewById(Integer id) {
        return reviewDao.getReviewById(id);
    }

    @Override
    public String selectImageUrl(int id) {
        return reviewDao.selectImageUrl(id);
    }

    @Override
    public int updateReview(ReviewVo reviewVo) {
        return reviewDao.updateReview(reviewVo);
    }

    @Override
    public int deleteReview(ReviewVo reviewVo) {
        return reviewDao.deleteReview(reviewVo);
    }

    @Override
    public int reviewRatingAvg(int productId) {
        Integer ratingAvg = reviewDao.reviewRatingAvg(productId); // Integer로 변경
        if (ratingAvg != null) {
            // 소수점 이하 버림 (필요 없는 경우, 아래 주석 처리)
            return ratingAvg;
        }
        return 0; // 기본값
    }

    @Override
    public int selectRowTotal(Map<String, Object> map) {
        return reviewDao.selectRowTotal(map);
    }

    @Override
    public List<ReviewVo> selectAllWithPagination(Map<String, Object> map) {
        return reviewDao.selectAllWithPagination(map);
    }

    @Override
    public List<ReviewVo> getReviewsWithPagination(int productId, int offset, int size) {
        Map<String, Object> map = new HashMap<>();
        map.put("productId", productId);
        map.put("offset", offset);
        map.put("size", size);
        return reviewDao.selectAllWithPagination(map);
    }


}
