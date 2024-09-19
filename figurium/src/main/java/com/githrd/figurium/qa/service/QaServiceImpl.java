    package com.githrd.figurium.qa.service;

    import com.githrd.figurium.notification.sevice.NotificationService;
    import com.githrd.figurium.notification.vo.Notification;
    import com.githrd.figurium.qa.dao.QaMapper;
    import com.githrd.figurium.qa.vo.QaVo;
    import com.githrd.figurium.user.service.UserService;
    import com.githrd.figurium.user.vo.UserVo;
    import org.springframework.beans.factory.annotation.Autowired;
    import org.springframework.stereotype.Service;

    import java.util.List;
    import java.util.Map;

    @Service
    public class QaServiceImpl implements QaService {


        private final QaMapper qaMapper;
        private final NotificationService notificationService;
        private final UserService userService;

        @Autowired
        public QaServiceImpl(QaMapper qaMapper, NotificationService notificationService, UserService userService) {
            this.qaMapper = qaMapper;
            this.notificationService = notificationService;
            this.userService = userService;
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

            // user에서 role이 1번인 녀석 조회 ( 모든 관리자에게 알림 전송 )
            List<UserVo> adminUsers = userService.findByRoleAdmin();

            // 반복문으로 관리자에게 알림 전송
            for (UserVo admin : adminUsers) {

                // 알림 객체 생성
                Notification notification = Notification.builder()
                        .userId( admin.getId())
                        .message("새로운 Q&A 게시글이 작성되었습니다.")
                        .url("/qa/qaSelect.do?id=" + qaVo.getId())
                        .build();

                // 알림 전송
                notificationService.sendNotification(notification);
            }

        }
        @Override
        public void saveProductQa(QaVo qaVo) {
            qaMapper.product_insert(qaVo);
        }


        @Override
        public void updateQa(QaVo qaVo) {
            qaMapper.update(qaVo);

            // 빌더 패턴으로 Notification 객체 생성.
            Notification notification = Notification.builder()
                    .userId(qaVo.getUserId())
                    .message("관리자가 답변을 남겼습니다.")
                    .url("/qa/qaSelect.do?id=" + qaVo.getId())
                    .build();

            // 사용자에게 알림 전송
            notificationService.sendNotification(notification);
        }

        @Override
        public void deleteQa(int id) {
            qaMapper.delete(id);
        }

        @Override
        public void deleteReply(int id) {
            qaMapper.deleteReply(id);
        }

        @Override
        public int getProductQaCount(int productId) {
            return qaMapper.getProductQaCount(productId);
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
        public  List<QaVo> selectProductAllWithPagination(Map<String, Object> map) {
            return qaMapper.selectProductAllWithPagination(map);
        }


        @Override
        public List<QaVo> getQaWithPagination(int offset, int limit) {
            return qaMapper.selectAllWithPagination(Map.of("offset", offset, "limit", limit));
        }


        @Override
        public int getQaCount() {
            return qaMapper.getQaCount();
        }

    }