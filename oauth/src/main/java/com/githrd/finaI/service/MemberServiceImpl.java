package com.githrd.finaI.service;


import com.githrd.finaI.dto.JwtToken;
import com.githrd.finaI.dto.MemberDto;
import com.githrd.finaI.dto.SignUpDto;
import com.githrd.finaI.model.Member;
import com.githrd.finaI.repository.MemberRepository;
import com.githrd.finaI.util.JwtTokenProvider;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.security.auth.login.AccountNotFoundException;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
@Slf4j
public class MemberServiceImpl implements MemberService {
    private final MemberRepository memberRepository;
    private final AuthenticationManagerBuilder authenticationManagerBuilder;
    private final JwtTokenProvider jwtTokenProvider;
    private final PasswordEncoder passwordEncoder;

    @Transactional
    @Override
    public JwtToken signIn(String email, String password) {

        Member member = null;
        try {
            member = memberRepository.findByEmail(email)
                    .orElseThrow(() -> new AccountNotFoundException("User not Found"));
        } catch (AccountNotFoundException e) {
            throw new RuntimeException(e);
        }

        boolean matches = passwordEncoder.matches(password, member.getPassword());
        if (!matches) {
            try {
                throw new AccountNotFoundException("Wrong Password");
            } catch (AccountNotFoundException e) {
                throw new RuntimeException(e);
            }
        }

        // 1. username + password 를 기반으로 Authentication 객체 생성
        // 매개변수로 db에서 가져온 검증이 완료된 암호화된 password로 UsernamePasswordAuthenticationToken 객체 생성.
        // 이때 authentication 은 인증 여부를 확인하는 authenticated 값이 false
        UsernamePasswordAuthenticationToken authenticationToken =
                new UsernamePasswordAuthenticationToken(member.getUsername(), member.getPassword());

        // 2. 실제 검증. authenticate() 메서드를 통해 요청된 Member 에 대한 검증 진행
        // authenticate 메서드가 실행될 때 CustomUserDetailsService 에서 만든 loadUserByUsername 메서드 실행
        Authentication authentication = authenticationManagerBuilder.getObject().authenticate(authenticationToken);
        System.out.println("authentication = " + authentication);

        // 3. 인증 정보를 기반으로 JWT 토큰 생성(payload 부분에 닉네임과 프로필 이미지 추가)
        JwtToken jwtToken = jwtTokenProvider.generateToken(authentication, member.getNickname(),member.getProfileImg());


        System.out.println("jwtToken = " + jwtToken.toString());

        return jwtToken;
    }

    @Transactional
    @Override
    public MemberDto signUp(SignUpDto signUpDto) {
        if (memberRepository.findByEmail(signUpDto.getEmail()).isPresent()) {
            throw new IllegalArgumentException("이미 사용 중인 이메일입니다.");
        }
        // Password 암호화
        String encodedPassword = passwordEncoder.encode(signUpDto.getPassword());
        List<String> roles = new ArrayList<>();
        roles.add("USER");  // USER 권한 부여
        return MemberDto.toDto(memberRepository.save(signUpDto.toEntity(encodedPassword, roles)));
    }
}
