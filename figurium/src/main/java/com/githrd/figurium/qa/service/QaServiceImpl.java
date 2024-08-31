package com.githrd.figurium.qa.service;

import com.githrd.figurium.qa.dao.QaDao;
import com.githrd.figurium.qa.vo.QaVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class QaServiceImpl implements QaService {

    @Autowired
    private QaDao qaDao;

    @Override
    public List<QaVo> getAllQa() {
        return qaDao.selectAll();
    }

    @Override
    public QaVo getQaById(int id) {
        return qaDao.selectById(id);
    }

    @Override
    public void saveQa(QaVo qaVo) {
        qaDao.insert(qaVo);
    }

    @Override
    public void updateQa(QaVo qaVo) {
        qaDao.update(qaVo);
    }

    @Override
    public void deleteQa(int id) {
        qaDao.delete(id);
    }
}