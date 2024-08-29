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
    public void createQa(QaVo qa) {
        qaDao.createQa(qa);
    }

    @Override
    public QaVo getQaById(Integer id) {
        return qaDao.getQaById(id);
    }

    @Override
    public List<QaVo> getAllQas() {
        return qaDao.getAllQas();
    }

    @Override
    public void updateQa(QaVo qa) {
        qaDao.updateQa(qa);
    }

    @Override
    public void deleteQa(Integer id) {
        qaDao.deleteQa(id);
    }
}
