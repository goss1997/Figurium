package com.githrd.figurium.notification.controller;

import com.githrd.figurium.exception.customException.UserNotFoundException;
import com.githrd.figurium.notification.sevice.NotificationService;
import com.githrd.figurium.user.entity.User;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

@RestController
@RequestMapping("/api/notifications")
@RequiredArgsConstructor
public class NotificationController {

    private final NotificationService notificationService;
    private final HttpSession session;

    /**
     * 사용자가 알림을 구독
     * @return : SseEmitter : SSE 연결 객체
     */
    @GetMapping(value = "/subscribe", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    public SseEmitter subscribe() {

        User loginUser = null;

        try {

            loginUser = (User) session.getAttribute("loginUser");
            // 서비스에서 구독 처리 후 SSE 연결 반환
            return notificationService.subscribe(loginUser.getId());

        } catch (Exception e) {
            throw new UserNotFoundException();
        }
    }

    /**
     * 특정 사용자에게 알림을 전송
     * @param userId : 알림을 받을 사용자 ID
     * @param message : 알림 메시지
     * @return : ResponseEntity : 알림 전송 상태 반환
     */
    @PostMapping("/notify")
    public ResponseEntity<?> sendNotification(@RequestParam int userId, @RequestParam String message) {
        // 서비스에서 특정 사용자에게 알림 전송
        notificationService.sendNotification(userId, message);
        return ResponseEntity.ok("Notification sent to user " + userId); // 전송 결과 반환
    }

    /**
     * 모든 사용자에게 알림을 전송
     * @param message : 알림 메시지
     * @return : ResponseEntity : 전송 상태 반환
     */
    @PostMapping("/broadcast")
    public ResponseEntity<?> broadcastNotification(@RequestParam String message) {
        // 서비스에서 모든 사용자에게 알림 전송
        notificationService.broadcastNotification(message);
        return ResponseEntity.ok("Broadcast notification sent."); // 전송 결과 반환
    }
}
