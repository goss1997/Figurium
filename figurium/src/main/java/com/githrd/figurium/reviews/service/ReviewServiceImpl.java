package com.githrd.figurium.reviews.service;

import com.githrd.figurium.reviews.dao.ReviewDao;
import com.githrd.figurium.reviews.vo.ReviewVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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
}
