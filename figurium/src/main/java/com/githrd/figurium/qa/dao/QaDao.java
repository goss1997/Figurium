package com.githrd.figurium.qa.dao;

import com.githrd.figurium.qa.vo.QaVo;

import java.util.List;

public interface QaDao {
    List<QaVo> selectAll(); // 모든 게시글 조회
    QaVo selectById(int id); // ID로 게시글 조회
    void insert(QaVo qaVo); // 게시글 저장
    void update(QaVo qaVo); // 게시글 수정
    void delete(int id); // 게시글 삭제
}