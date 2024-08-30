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
    public List<ReviewVo> selectList() {
        return reviewDao.selectList();
    }

    @Override
    public int insertReview(ReviewVo reviewVo) {
        return reviewDao.insertReview(reviewVo);
    }
}
