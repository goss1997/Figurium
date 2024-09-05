package com.githrd.figurium.qa.dao;

import com.githrd.figurium.qa.vo.QaVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class QaDaoImpl implements QaDao {

    @Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "com.githrd.figurium.qa.dao.QaDao";

    @Override
    public List<QaVo> selectAll() {
        return sqlSession.selectList(NAMESPACE + ".selectAll");
    }

    @Override
    public QaVo selectById(int id) {
        return sqlSession.selectOne(NAMESPACE + ".selectById", id);
    }

    @Override
    public void insert(QaVo qaVo) {
        sqlSession.insert(NAMESPACE + ".insert", qaVo);
    }

    @Override
    public void update(QaVo qaVo) {
        sqlSession.update(NAMESPACE + ".update", qaVo);
    }

    @Override
    public void delete(int id) {
        sqlSession.delete(NAMESPACE + ".delete", id);
    }

    @Override
    public List<QaVo> selectAllWithPagination(Map<String, Integer> offset) {
        return sqlSession.selectList(NAMESPACE + ".selectAllWithPagination", offset);
    }

    @Override
    public int selectRowTotal(Map<String, Object> map) {
        return sqlSession.selectOne(NAMESPACE + ".selectRowTotal", map);
    }
}