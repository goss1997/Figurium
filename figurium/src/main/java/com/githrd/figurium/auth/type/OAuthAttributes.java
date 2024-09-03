package com.githrd.figurium.auth.type;


import com.githrd.figurium.auth.dto.UserProfile;

import java.util.Arrays;
import java.util.Map;
import java.util.function.Function;

public enum OAuthAttributes {

    GOOGLE("google", (attribute) -> {
        UserProfile userProfile = new UserProfile();
        userProfile.setProviderUserId((String) attribute.get("sub"));
        userProfile.setName((String) attribute.get("name"));
        userProfile.setEmail((String) attribute.get("email"));
        userProfile.setProfileImageUrl((String) attribute.get("picture"));


        return userProfile;
    }),

    NAVER("naver", (attribute) -> {
        UserProfile userProfile = new UserProfile();

        Map<String, String> responseValue = (Map) attribute.get("response");
        userProfile.setProviderUserId(responseValue.get("id"));
        userProfile.setName(responseValue.get("name"));
        userProfile.setEmail(responseValue.get("email"));
        userProfile.setProfileImageUrl(responseValue.get("profile_image"));

        return userProfile;
    }),

    KAKAO("kakao", (attribute) -> {

        Map<String, Object> account = (Map) attribute.get("kakao_account");
        Map<String, String> profile = (Map) account.get("profile");

        UserProfile userProfile = new UserProfile();
        userProfile.setProviderUserId(String.valueOf(attribute.get("id")));
        userProfile.setName(profile.get("nickname"));
        userProfile.setEmail((String) account.get("email"));
        userProfile.setProfileImageUrl(profile.get("thumbnail_image_url"));

        return userProfile;
    });

    private final String registrationId; // 로그인한 서비스(ex) google, naver..)
    private final Function<Map<String, Object>, UserProfile> of; // 로그인한 사용자의 정보를 통하여 UserProfile을 가져옴

    OAuthAttributes(String registrationId, Function<Map<String, Object>, UserProfile> of) {
        this.registrationId = registrationId;
        this.of = of;
    }

    public static UserProfile extract(String registrationId, Map<String, Object> attributes) {
        return Arrays.stream(values())
                .filter(value -> registrationId.equals(value.registrationId))
                .findFirst()
                .orElseThrow(IllegalArgumentException::new)
                .of.apply(attributes);
    }
}
