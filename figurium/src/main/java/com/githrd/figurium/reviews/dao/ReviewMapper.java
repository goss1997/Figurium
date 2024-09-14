package com.githrd.figurium.reviews.dao;

import com.githrd.figurium.reviews.vo.ReviewVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface ReviewMapper {


    // 해당 상품에 대한 리뷰 Insert
    int insertReview(ReviewVo reviewVo);

    // 해당 상품에 대한 리뷰의 갯수
    int reviewCountByProductId(int productId);

    // 해당 상품에 대한 리뷰의 리스트
    List<ReviewVo> reviewsByProductId(Integer productId);

    // 리뷰 1건에 해당하는 Id를 이용해 해당 리뷰 조회
    ReviewVo getReviewById(Integer id);

    // S3 삭제를 위한 리뷰에 대한 이미지 조회
    String selectImageUrl(int id);

    // 해당 리뷰 수정
    int updateReview(ReviewVo reviewVo);

    // 해당 리뷰 삭제
    int deleteReview(ReviewVo reviewVo);

    // 상품에 대한 리뷰 별점의 평균
    Integer reviewRatingAvg(int productId);

    // 페이징 처리를 위한 리뷰의 갯수를 반환
    int selectRowTotal(int productid);

    // 페이징 처리를 한 후 리뷰의 리스트를 가져오기
    List<ReviewVo> selectAllWithPagination(Map<String, Object> map);



}
