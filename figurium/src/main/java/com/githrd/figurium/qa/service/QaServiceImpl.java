    package com.githrd.figurium.qa.service;

    import com.githrd.figurium.qa.dao.QaDao;
    import com.githrd.figurium.qa.vo.QaVo;
    import org.springframework.beans.factory.annotation.Autowired;
    import org.springframework.stereotype.Service;

    import java.util.List;
    import java.util.Map;

    @Service
    public class QaServiceImpl implements QaService {

        private final QaDao qaDao;

        @Autowired
        public QaServiceImpl(QaDao qaDao) {
            this.qaDao = qaDao;
        }

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


        @Override
        public int selectRowTotal(Map<String, Object> map) {
            return qaDao.selectRowTotal(map);
        }

        @Override
        public List<QaVo> getQaWithPagination(int offset, int limit) {
            return qaDao.selectAllWithPagination(Map.of("offset", offset, "limit", limit));
        }

    }