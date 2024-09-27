package com.githrd.figurium.notification.sevice;

import com.githrd.figurium.notification.dao.NotificationMapper;
import com.githrd.figurium.notification.vo.Notification;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Service
@RequiredArgsConstructor
@Slf4j
public class NotificationService {

    // 구독하는 사용자 ID와 해당 사용자의 SseEmitter 객체를 저장할 Map
    private final Map<Integer, SseEmitter> emitters = new ConcurrentHashMap<>();

    private final NotificationMapper notificationMapper;


    /**
     * 사용자가 SSE를 통해 알림을 구독
     * @param userId : 구독하는 사용자의 ID
     * @return SseEmitter : SSE 연결을 담당하는 객체
     */
    public SseEmitter subscribe(int userId) {
        log.info("subscribe 메소드 호출!");
        // 30분 동안 유지되는 SseEmitter 생성
        SseEmitter emitter = new SseEmitter(30 * 60 * 1000L);

        // 사용자 ID와 해당 SseEmitter 객체를 저장
        emitters.put(userId, emitter);

        // 연결이 완료된 경우 구독 목록에서 제거
        emitter.onCompletion(() -> emitters.remove(userId));

        // 연결이 중단된 경우 구독 목록에서 제거
        emitter.onTimeout(() -> {
            log.warn("SSE connection timeout for user: {}", userId);
            emitters.remove(userId);  // 타임아웃 발생 시 emitter 삭제
            try {
                // 타임아웃 처리 메시지 전송 (클라이언트가 이를 감지하고 재연결 가능)
                emitter.send(SseEmitter.event().name("timeout").data("Connection timed out. Please reconnect."));
            } catch (IOException e) {
                log.error("Error sending timeout message to user: {}", userId, e);
            }
        });

        // 503 에러를 방지하기 위한 더미 이벤트 전송
        try {
            // 사용자에게 알림 메시지 전송
            emitter.send(SseEmitter.event()
                    .name("SSE-Connect") // 연결 용 이벤트 이름
                    .data("EventStream Created. [userId=" + userId + "]"));

            log.info("connect to SSE");
        } catch (IOException e) {
            // 전송 실패 시 해당 사용자의 구독 해제
            emitters.remove(userId);
        }

        return emitter; // SSE 연결 반환
    }

    /**
     * 특정 사용자에게 알림을 전송
     * @param userId  : 알림을 받을 사용자 ID
     * @param message : 알림 메시지
     */
    public void sendNotification(int userId, String message) {
        // 해당 사용자 ID의 SseEmitter 객체 가져오기
        SseEmitter emitter = emitters.get(userId);
        if (emitter != null) {
            try {
                // 사용자에게 알림 메시지 전송
                emitter.send(SseEmitter.event()
                        .name("message") // 이벤트 이름 설정
                        .data(message));                // 알림 메시지 전송

                log.info(message);
            } catch (IOException e) {
                // 전송 실패 시 해당 사용자의 구독 해제
                emitters.remove(userId);
            }
        }
    }

    /**
     * 특정 사용자에게 알림을 전송
     * @param notification : db에 저장할 알림 객체
     */
    @Transactional
    public void sendNotification(Notification notification) {
        // 해당 사용자 ID의 SseEmitter 객체 가져오기
        SseEmitter emitter = emitters.get(notification.getUserId());
        if (emitter != null) {
            try {
                // 사용자에게 알림 메시지 전송
                emitter.send(SseEmitter.event()
                        .name("notification") // 이벤트 이름 설정
                        .data(notification));                // 알림 메시지 전송
            } catch (IOException e) {
                // 전송 실패 시 해당 사용자의 구독 해제
                emitters.remove(notification.getUserId());
            }
        }
        // 알림 전송 후 db에 저장
        notificationMapper.insertNotification(notification);

    }

    /**
     * 모든 사용자에게 알림을 전송
     * @param message : 알림 메시지
     */
    public void broadcastNotification(String message) {
        // 구독 중인 모든 사용자에게 알림 전송
        emitters.forEach((userId, emitter) -> {
            try {
                // 모든 사용자에게 알림 메시지 전송
                emitter.send(SseEmitter.event()
                        .name("notification") // 이벤트 이름 설정
                        .data(message));                // 알림 메시지 전송
            } catch (IOException e) {
                // 전송 실패 시 해당 사용자의 구독 해제
                emitters.remove(userId);
            }
        });
    }

    /**
     * 특정 사용자의 알림 목록을 조회
     * @param userId : 알림을 조회할 사용자 ID
     * @return : 사용자에게 전송된 알림 목록
     */
    public List<Notification> getNotificationsByUserId(int userId) {
        return notificationMapper.getNotificationsByUserId(userId);
    }

    /**
     * 모든 알림을 조회
     * @return : 모든 알림 목록
     */
    public List<Notification> getAllNotifications() {
        return notificationMapper.getAllNotifications();
    }

    /**
     * 알림을 읽음 상태로 업데이트
     * @param notificationId : 읽음 상태로 업데이트할 알림 ID
     */
    public void updateNotificationAsRead(int notificationId) {
        notificationMapper.updateNotificationAsRead(notificationId);

    }

    /**
     * 특정 알림 삭제
     * @param notificationId : 삭제할 알림 ID
     */
    public void deleteNotification(int notificationId) {
        notificationMapper.deleteNotification(notificationId);
    }

    /**
     * 모든 알림을 삭제
     */
    public void deleteAllNotifications() {
        notificationMapper.deleteAllNotifications();
    }


    /**
     * 사용자가 게시글을 작성했을 때 관리자에게 알림 전송
     * @param userId : 게시글 작성자 ID
     * @param postTitle : 게시글 제목
     */
    public void notifyAdminOnPost(int userId, String postTitle) {
        // 관리자에게 알림 생성
        String message = "회원님이 게시글을 남겼습니다: " + postTitle;
        Notification notification = new Notification();
        notification.setUserId(1); // 관리자 ID (예: 1)
        notification.setMessage(message);
        notification.setCreatedAt(LocalDateTime.now());

        // 알림 저장
        notificationMapper.insertNotification(notification);

        // 관리자에게 SSE로 알림 전송
        sendNotification(notification);
    }

    /**
     * 관리자가 게시글에 답변을 작성했을 때 사용자에게 알림 전송
     * @param userId : 게시글 작성자 ID
     * @param responseTitle : 답변 제목
     */
    public void notifyUserOnResponse(int userId, String responseTitle) {
        // 사용자에게 알림 생성
        String message = "관리자가 게시글에 답변을 남겼습니다: " + responseTitle;
        Notification notification = new Notification();
        notification.setUserId(userId);
        notification.setMessage(message);
        notification.setCreatedAt(LocalDateTime.now());

        // 알림 저장
        notificationMapper.insertNotification(notification);

        // 사용자에게 SSE로 알림 전송
        sendNotification(notification);
    }

}

