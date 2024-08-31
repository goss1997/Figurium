package com.githrd.figurium.qa.dao;

import com.githrd.figurium.qa.vo.QaVo;

import java.util.List;

public interface QaDao {
    List<QaVo> selectAll();
    QaVo selectById(int id);
    void insert(QaVo qaVo);
    void update(QaVo qaVo);
    void delete(int id);
}