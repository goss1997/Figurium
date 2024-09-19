package com.githrd.figurium.user.vo;

import com.githrd.figurium.auth.dto.UserProfile;
import lombok.Data;

@Data
public class SocialAccountVo {

    private int id;
    private int userId;
    private String provider;
    private String providerUserId;
    private String createdAt;

    // 싱글톤 패턴
    private static SocialAccountVo instance;

    private SocialAccountVo() {
    }

    public static synchronized SocialAccountVo getInstance() {
        if (instance == null) {
            instance = new SocialAccountVo();
        }
        return instance;
    }

    // 인스턴스를 초기화하는 메서드
    public void setSocialAccountInfo(int userId, String provider, String providerUserId) {
        this.userId = userId;
        this.provider = provider;
        this.providerUserId = providerUserId;
    }

}
