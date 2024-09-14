package com.githrd.figurium.auth.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class UserProfile {

    @JsonIgnore
    private int id;

    private String name; // 사용자 이름
    private String provider; // 로그인한 서비스
    private String email; // 사용자의 이메일
    private String profileImageUrl; // 사용자 이미지 url
    private String providerUserId; // 사용자 고유 ID(소셜 제공)

}
