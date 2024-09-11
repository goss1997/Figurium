package com.githrd.figurium.notification.dao;

import com.githrd.figurium.notification.vo.Notification;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface NotificationMapper {

    /**
     * 새로운 알림을 DB에 삽입
     * @param notification : 삽입할 알림 정보
     */
    void insertNotification(Notification notification);

    /**
     * 특정 사용자의 알림 목록을 조회
     * @param userId : 알림을 조회할 사용자 ID
     * @return : 사용자에게 전송된 알림 목록
     */
    List<Notification> getNotificationsByUserId(int userId);

    /**
     * 알림을 읽음 상태로 업데이트
     * @param notificationId : 읽음 상태로 업데이트할 알림 ID
     */
    void updateNotificationAsRead(int notificationId);

}
