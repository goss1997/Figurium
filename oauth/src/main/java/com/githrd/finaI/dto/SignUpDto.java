package com.githrd.finaI.dto;

import com.githrd.finaI.model.Member;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SignUpDto {

    private String email;
    private String password;
    private String nickname;
    private String address;
    private String phone;
    private String profileImg;
    private List<String> roles = new ArrayList<>();

    public Member toEntity(String encodedPassword, List<String> roles) {

        return Member.builder()
                .email(email)
                .password(encodedPassword)
                .nickname(nickname)
                .address(address)
                .phone(phone)
                .profileImg(profileImg)
                .roles(roles)
                .build();
    }
}