package com.githrd.figurium.user.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserVo {

    private int id;
    private String email;
    private String password;
    private String name;
    private String phone;
    private String address;
    private String profileImgUrl;
    private int role;
    private int deleted;
    private String createdAt;
    private String updatedAt;

    public UserVo(String email, String name, String profileImgUrl) {
        this.name = name;
        this.email = email;
        this.profileImgUrl = profileImgUrl;
    }
}
