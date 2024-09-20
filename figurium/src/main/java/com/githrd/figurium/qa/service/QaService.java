    package com.githrd.figurium.qa.service;

    import com.githrd.figurium.qa.vo.QaVo;

    import java.util.List;
    import java.util.Map;


    public interface QaService {
        List<QaVo> getAllQa(); // 모든 게시글 조회
        QaVo getQaById(int id); // ID로 게시글 조회
        void saveQa(QaVo qaVo); // 게시글 저장
        void saveProductQa(QaVo qaVo); // 게시글 저장
        void updateQa(QaVo qaVo); // 게시글 수정
        void deleteQa(int id); // 게시글 삭제
        void deleteReply(int id);
        int getProductQaCount(int productQaId);

        List<QaVo> getQaWithPagination(int offset, int limit); // 페이징 처리된 게시글 조회
        int selectRowTotal(Map<String, Object> map); // 총 게시물 수 조회
        List<QaVo> selectAllWithPagination(Map<String, Object> map);
        List<QaVo> selectProductAllWithPagination(Map<String, Object> map);

        int getReplyCount();
        int getQaCount();

    }

