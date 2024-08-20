package com.githrd.finaI.config;

import com.githrd.finaI.filter.JwtAuthenticationFilter;
import com.githrd.finaI.service.OAuth2Service;
import com.githrd.finaI.util.JwtTokenProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

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
    private final JwtTokenProvider jwtTokenProvider;

    /**
     * 스프링 시큐리티의 인증을 담당하는 AuthenticationManager는 이전 설정 방법으로
     * authenticationManagerBuilder를 이용해서 userDetailsService와 passwordEncoder를 설정해주어야 했다.
     * 변경된 설정에서는 AuthenticationManager 빈 생성 시 스프링 내부 동작으로
     * 위에서 작성한 userDetailsService와 passwordEncoder가 자동으로 설정된다.
     */

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        // 기존 메소드 체이닝 방식을 사용했더니 에러남.
        // spring boot 3.xx 이후 람다식으로 전달하도록 바뀜.
       return http
               .csrf(AbstractHttpConfigurer::disable)       // csrf 보안 설정 사용을 안 할 것이다.
               .httpBasic(basic -> basic.disable())     // http basic 미사용.
               .logout(AbstractHttpConfigurer::disable)     // 로그아웃 사용을 안 할 것이다.
               .formLogin(login -> login.disable())  // 폼 로그인 사용을 안 할 것이다.
               .authorizeHttpRequests(auth -> auth              // 사용자가 보내는 요청에 인증 절차 수행할 것이다.
                       .requestMatchers("/","/index.jsp").permitAll()  // "/"와 "/index.jsp" 경로는 인증 없이 접근 가능
                       .requestMatchers("/**").permitAll() // 정적 자원에 대한 접근 허용
                       .requestMatchers("/WEB-INF/views/**").permitAll() // jsp파일 접근 허용
                       .anyRequest().authenticated()       // 나머지 요청들은 모두 인증 절차 수행할 것이다.
               )
               .oauth2Login(oauth -> oauth                  // OAuth2를 통한 로그인을 사용할 것이다.
                       .defaultSuccessUrl("/oauth/loginInfo", true)  // 로그인 성공시 이동할 URL
                       .userInfoEndpoint(userInfo -> userInfo   // 사용자가 로그인에 성공하였을 경우
                       .userService(oAuth2Service))             // 해당 서비스 로직을 타도록 설정할 것이다.
               )
               // JWT 인증을 위하여 직접 구현한 필터를 UsernamePasswordAuthenticationFilter 전에 실행
               .addFilterBefore(new JwtAuthenticationFilter(jwtTokenProvider), UsernamePasswordAuthenticationFilter.class)

               .build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        // BCrypt Encoder 사용
        return PasswordEncoderFactories.createDelegatingPasswordEncoder();
    }



}