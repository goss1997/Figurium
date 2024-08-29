package com.githrd.figurium.qa.service;

import com.githrd.figurium.qa.vo.QaVo;

import java.util.List;

public interface QaService {
    void createQa(QaVo qa);
    QaVo getQaById(Integer id);
    List<QaVo> getAllQas();
    void updateQa(QaVo qa);
    void deleteQa(Integer id);
}
