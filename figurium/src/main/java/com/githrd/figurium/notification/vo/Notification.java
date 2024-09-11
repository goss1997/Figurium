package com.githrd.figurium.notification.vo;


import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.time.LocalDateTime;

@Data
public class Notification {
    private int id; // 알림 ID (Primary Key)
    private Long userId; // 알림을 받는 사용자 ID
    private String message; // 알림 내용
    private String url; // 알림 클릭 시 이동할 URL
    private boolean isRead; // 알림 읽음 여부
    private LocalDateTime createdAt; // 알림 생성 시간
}
