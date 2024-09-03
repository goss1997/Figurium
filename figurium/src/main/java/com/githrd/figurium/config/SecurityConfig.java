package com.githrd.figurium.config;

import com.githrd.figurium.auth.service.OAuth2Service;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

/**
 * Spring Security 5.7 버전 이후 설정의 유연성을 높이고,
 * 더 명확하고 직관적인 설정 방법을 제공하기 위해 WebSecurityConfigurerAdapter를 제거하고,
 * 대신에 람다 표현식 기반의 설정 방식을 권장하게 되었으므로
 * SecurityFilterChain 빈을 직접 정의하는 방식으로 설정하였다.
 */

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {

    private final OAuth2Service oAuth2Service;

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        // 기존 메소드 체이닝 방식을 사용했더니 에러남.
        // spring boot 3.xx 이후 람다식으로 전달하도록 바뀜.
       return http
               .csrf(AbstractHttpConfigurer::disable)       // csrf 보안 설정 사용을 안 할 것이다.
               .httpBasic(basic -> basic.disable())     // http basic 미사용.
               .logout(AbstractHttpConfigurer::disable)     // 로그아웃 사용을 안 할 것이다.
               .formLogin(login -> login.disable())  // 폼 로그인 사용을 안 할 것이다.
               .oauth2Login(oauth2 -> oauth2                  // OAuth2를 통한 로그인을 사용할 것이다.
                       .defaultSuccessUrl("/oauth/loginInfo", false)  // 로그인 성공시 리다이렉트
                       .userInfoEndpoint(userInfo -> userInfo   // 사용자가 로그인에 성공하였을 경우
                       .userService(oAuth2Service))             // 해당 서비스 로직을 타도록 설정할 것이다.
                        )
               .build();
    }

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

}