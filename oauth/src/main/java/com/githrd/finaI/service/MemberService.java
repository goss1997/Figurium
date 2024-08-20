package com.githrd.finaI.service;


import com.githrd.finaI.dto.JwtToken;
import com.githrd.finaI.dto.MemberDto;
import com.githrd.finaI.dto.SignUpDto;

public interface MemberService {

    JwtToken signIn(String email, String password);
    MemberDto signUp(SignUpDto signUpDto);

}
