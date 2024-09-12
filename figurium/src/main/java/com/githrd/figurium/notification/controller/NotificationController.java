package com.githrd.figurium.notification.controller;

import com.githrd.figurium.exception.customException.UserNotFoundException;
import com.githrd.figurium.notification.sevice.NotificationService;
import com.githrd.figurium.notification.vo.Notification;
import com.githrd.figurium.user.entity.User;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.util.List;

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

    /**
     * 특정 사용자의 알림 목록을 조회
     * @param userId : 알림을 조회할 사용자 ID
     * @return : 사용자에게 전송된 알림 목록
     */
    @GetMapping("/user/{userId}")
    public ResponseEntity<List<Notification>> getNotificationsByUserId(@PathVariable int userId) {
        List<Notification> notifications = notificationService.getNotificationsByUserId(userId);
        return ResponseEntity.ok(notifications);
    }

    /**
     * 모든 알림을 조회
     * @return : 모든 알림 목록
     */
    @GetMapping("/all")
    public ResponseEntity<List<Notification>> getAllNotifications() {
        List<Notification> notifications = notificationService.getAllNotifications();
        return ResponseEntity.ok(notifications);
    }

    /**
     * 알림을 읽음 상태로 업데이트
     * @param notificationId : 읽음 상태로 업데이트할 알림 ID
     * @return : ResponseEntity : 업데이트 상태 반환
     */
    @PatchMapping("/read/{notificationId}")
    public ResponseEntity<?> markNotificationAsRead(@PathVariable int notificationId) {
        notificationService.updateNotificationAsRead(notificationId);
        return ResponseEntity.ok("Notification marked as read.");
    }

    /**
     * 특정 알림 삭제
     * @param notificationId : 삭제할 알림 ID
     * @return : ResponseEntity : 삭제 상태 반환
     */
    @DeleteMapping("/{notificationId}")
    public ResponseEntity<?> deleteNotification(@PathVariable int notificationId) {
        notificationService.deleteNotification(notificationId);
        return ResponseEntity.ok("Notification deleted.");
    }

    /**
     * 게시글 작성 시 관리자에게 알림 전송
     * @param userId : 게시글 작성자 ID
     * @param postTitle : 게시글 제목
     * @return : ResponseEntity : 알림 전송 상태 반환
     */
    @PostMapping("/notifyAdminOnPost")
    public ResponseEntity<?> notifyAdminOnPost(@RequestParam int userId, @RequestParam String postTitle) {
        notificationService.notifyAdminOnPost(userId, postTitle);
        return ResponseEntity.ok("Notification sent to admin.");
    }

    /**
     * 게시글에 답변 작성 시 사용자에게 알림 전송
     * @param userId : 게시글 작성자 ID
     * @param responseTitle : 답변 제목
     * @return : ResponseEntity : 알림 전송 상태 반환
     */
    @PostMapping("/notifyUserOnResponse")
    public ResponseEntity<?> notifyUserOnResponse(@RequestParam int userId, @RequestParam String responseTitle) {
        notificationService.notifyUserOnResponse(userId, responseTitle);
        return ResponseEntity.ok("Notification sent to user.");
    }


}
