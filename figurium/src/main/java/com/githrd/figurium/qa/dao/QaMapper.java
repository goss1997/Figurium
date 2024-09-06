package com.githrd.figurium.qa.dao;

import com.githrd.figurium.qa.vo.QaVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface QaMapper {
    List<QaVo> selectAll(); // 모든 게시글 조회
    QaVo selectById(int id); // ID로 게시글 조회
    void insert(QaVo qaVo); // 게시글 저장
    void update(QaVo qaVo); // 게시글 수정
    void delete(int id); // 게시글 삭제

    List<QaVo> selectAllWithPagination(Map<String, Object> map);

    int selectRowTotal(Map<String, Object> map); // 총 게시물 수 조회// 페이징 처리된 게시글 조회
}