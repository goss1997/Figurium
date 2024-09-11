package com.githrd.figurium.notification.sevice;

import com.githrd.figurium.notification.dao.NotificationMapper;
import com.githrd.figurium.notification.vo.Notification;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
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
        emitter.onTimeout(() -> emitters.remove(userId));

        // 503 에러를 방지하기 위한 더미 이벤트 전송
        sendNotification(userId, "EventStream Created. [userId=" + userId + "]");

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
                        .name("notification") // 이벤트 이름 설정
                        .data(message));                // 알림 메시지 전송

                log.info("사용자"+userId+"번 에게 메세지 전송");
            } catch (IOException e) {
                // 전송 실패 시 해당 사용자의 구독 해제
                emitters.remove(userId);
            }
        }
    }

    /**
     * 특정 사용자에게 알림을 전송
     * @param userId  : 알림을 받을 사용자 ID
     * @param message : 알림 메시지
     * @param notification : db에 저장할 알림 객체
     */
    public void sendNotification(int userId, String message, Notification notification) {
        // 해당 사용자 ID의 SseEmitter 객체 가져오기
        SseEmitter emitter = emitters.get(userId);
        if (emitter != null) {
            try {
                // 사용자에게 알림 메시지 전송
                emitter.send(SseEmitter.event()
                        .name("notification") // 이벤트 이름 설정
                        .data(message));                // 알림 메시지 전송
            } catch (IOException e) {
                // 전송 실패 시 해당 사용자의 구독 해제
                emitters.remove(userId);
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
}

