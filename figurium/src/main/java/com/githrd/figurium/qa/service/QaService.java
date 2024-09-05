package com.githrd.figurium.qa.service;

import com.githrd.figurium.qa.vo.QaVo;

import java.util.List;


public interface QaService {
    List<QaVo> getAllQa(); // 모든 게시글 조회
    QaVo getQaById(int id); // ID로 게시글 조회
    void saveQa(QaVo qaVo); // 게시글 저장
    void updateQa(QaVo qaVo); // 게시글 수정
    void deleteQa(int id); // 게시글 삭제

}