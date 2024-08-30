package com.githrd.figurium.reviews.dao;

import com.githrd.figurium.reviews.vo.ReviewVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ReviewDao {

    List<ReviewVo> selectList();

    int insertReview(ReviewVo reviewVo);

}
