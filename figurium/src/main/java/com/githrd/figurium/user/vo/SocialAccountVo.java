package com.githrd.figurium.user.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SocialAccountVo {

    private int id;
    private int userId;
    private String provider;
    private String providerUserId;
    private String createdAt;

    public SocialAccountVo(int userId, String provider,String providerUserId) {
        this.userId = userId;
        this.provider = provider;
        this.providerUserId = providerUserId;
    }
}
