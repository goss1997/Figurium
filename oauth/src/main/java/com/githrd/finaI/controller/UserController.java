package com.githrd.finaI.controller;

import com.githrd.finaI.dto.JwtToken;
import com.githrd.finaI.util.JwtTokenProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Map;

@RequiredArgsConstructor
@Controller
public class UserController {

    private final JwtTokenProvider jwtTokenProvider;

    /**
     * 소셜 로그인한 사용자의 JWT 생성
     */
    @GetMapping("/oauth/loginInfo")
    public String generateSocialLoginJWT(Authentication authentication, RedirectAttributes ra) {
        OAuth2User oAuth2User = (OAuth2User) authentication.getPrincipal();
        Map<String, Object> attributes = oAuth2User.getAttributes();
        String nickName = String.valueOf(attributes.get("name"));
        String profileImage = String.valueOf(attributes.get("profileImage"));

        // 사용자의 정보를 가지고 jwt 생성.
        JwtToken jwtToken = jwtTokenProvider.generateToken(authentication, nickName, profileImage);

        ra.addFlashAttribute("jwt",jwtToken);

        return "redirect:/";
    }




}
