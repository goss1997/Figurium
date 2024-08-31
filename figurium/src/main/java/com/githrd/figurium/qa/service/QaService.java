package com.githrd.figurium.qa.service;

import com.githrd.figurium.qa.vo.QaVo;

import java.util.List;


public interface QaService {
    List<QaVo> getAllQa();
    QaVo getQaById(int id);
    void saveQa(QaVo qaVo);
    void updateQa(QaVo qaVo);
    void deleteQa(int id);
}