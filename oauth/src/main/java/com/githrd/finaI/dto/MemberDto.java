package com.githrd.finaI.dto;

import com.githrd.finaI.model.Member;
import lombok.*;

@Getter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MemberDto {

    private Long id;
    private String email;
    private String nickname;
    private String address;
    private String phone;
    private String profileImg;

    static public MemberDto toDto(Member member) {
        return MemberDto.builder()
                .id(member.getId())
                .email(member.getEmail())
                .nickname(member.getNickname())
                .address(member.getAddress())
                .phone(member.getPhone())
                .profileImg(member.getProfileImg()).build();
    }

    public Member toEntity() {
        return Member.builder()
                .id(id)
                .email(email)
                .nickname(nickname)
                .address(address)
                .phone(phone)
                .profileImg(profileImg).build();
    }
}
