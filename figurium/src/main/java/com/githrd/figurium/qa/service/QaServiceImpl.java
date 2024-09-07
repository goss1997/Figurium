    package com.githrd.figurium.qa.service;

    import com.githrd.figurium.qa.dao.QaMapper;
    import com.githrd.figurium.qa.vo.QaVo;
    import org.springframework.beans.factory.annotation.Autowired;
    import org.springframework.stereotype.Service;

    import java.util.List;
    import java.util.Map;

    @Service
    public class QaServiceImpl implements QaService {

        private final QaMapper qaMapper;

        @Autowired
        public QaServiceImpl(QaMapper qaMapper) {
            this.qaMapper = qaMapper;
        }

        @Override
        public List<QaVo> getAllQa() {
            return qaMapper.selectAll();
        }

        @Override
        public QaVo getQaById(int id) {
            return qaMapper.selectById(id);
        }

        @Override
        public void saveQa(QaVo qaVo) {
            qaMapper.insert(qaVo);
        }

        @Override
        public void updateQa(QaVo qaVo) {
            qaMapper.update(qaVo);
        }

        @Override
        public void deleteQa(int id) {
            // 먼저 게시글에 달린 모든 답변을 삭제
            qaMapper.deleteAllRepliesForQa(id);
            // 그 다음 게시글 삭제
            qaMapper.delete(id);
        }

        @Override
        public void deleteReply(int id) {
            qaMapper.deleteReply(id);
        }

        @Override
        public void deleteAllRepliesForQa(int id) {
            qaMapper.deleteAllRepliesForQa(id);
        }

        @Override
        public int selectRowTotal(Map<String, Object> map) {
            return qaMapper.selectRowTotal(map);
        }

        @Override
        public  List<QaVo> selectAllWithPagination(Map<String, Object> map) {
            return qaMapper.selectAllWithPagination(map);
        }




        @Override
        public List<QaVo> getQaWithPagination(int offset, int limit) {
            return qaMapper.selectAllWithPagination(Map.of("offset", offset, "limit", limit));
        }


    }