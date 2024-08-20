package com.githrd.finaI.dto;

import lombok.*;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class SignInDto {

    private String email;
    private String password;

}
