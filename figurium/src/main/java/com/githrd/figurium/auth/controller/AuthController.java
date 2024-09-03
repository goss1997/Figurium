package com.githrd.figurium.auth.controller;

import com.githrd.figurium.auth.dto.UserProfile;
import com.githrd.figurium.exception.customException.AccountLinkException;
import com.githrd.figurium.exception.customException.RedirectErrorException;
import com.githrd.figurium.exception.customException.SocialLoginException;
import com.githrd.figurium.exception.customException.UserNotFoundException;
import com.githrd.figurium.user.dao.SocialAccountMapper;
import com.githrd.figurium.user.entity.User;
import com.githrd.figurium.user.service.UserService;
import com.githrd.figurium.user.vo.SocialAccountVo;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

@Slf4j
@Controller
@RequiredArgsConstructor
public class AuthController {

    private final UserService userService;
    private final HttpSession session;
    private final SocialAccountMapper socialAccountMapper;

    @PostMapping("/save-url")
    @ResponseBody
    public ResponseEntity<?> saveUrlToSession(@RequestParam String url) {
        // 세션에 URL 저장
        session.setAttribute("redirectUrl", url);

        return ResponseEntity.ok().build();
    }

    @PostMapping("/link-account")
    public String linkAccount() {
        try {
            UserProfile userProfile = (UserProfile) session.getAttribute("userProfile");
            if (userProfile == null) {
                log.error("userProfile is null! Redirecting to home page.");
                throw new RedirectErrorException("User profile is missing in session.");
            }

            log.info("연동 승인 했으므로 소셜 정보 db에 추가 및 로그인.");
            User loginUser = userService.findByEmail(userProfile.getEmail());
            if (loginUser == null) {
                log.error("User not found in the database with email: {}", userProfile.getEmail());
                throw new UserNotFoundException("User not found with email: " + userProfile.getEmail());
            }

            SocialAccountVo socialAccountVo = new SocialAccountVo(loginUser.getId(), userProfile.getProvider());
            socialAccountMapper.insertSocialAccount(socialAccountVo);

            session.removeAttribute("userProfile");
            session.setAttribute("loginUser", loginUser);

            return redirectToPreviousPage();
        } catch (Exception e) {
            log.error("Error occurred while linking account: ", e);
            throw new AccountLinkException("Failed to link account: " + e.getMessage());
        }
    }

    @GetMapping("/oauth/loginInfo")
    public String socialLogin(Authentication authentication) {
        try {
            OAuth2User oAuth2User = (OAuth2User) authentication.getPrincipal();
            Map<String, Object> attributes = oAuth2User.getAttributes();

            String email = String.valueOf(attributes.get("email"));
            String name = String.valueOf(attributes.get("name"));
            String profileImageUrl = String.valueOf(attributes.get("profileImageUrl"));
            String provider = String.valueOf(attributes.get("provider"));

            if (userService.existsByEmail(email)) {
                User user = userService.findByEmail(email);
                if (user == null) {
                    log.error("User not found in the database with email: {}", email);
                    throw new UserNotFoundException("User not found with email: " + email);
                }

                SocialAccountVo socialAccount = userService.selectSocialAccountOne(user.getId(), provider);
                if (socialAccount == null) {
                    log.info("연동을 위해 연동 페이지 포워딩");
                    session.setAttribute("userProfile", new UserProfile(name, provider, email, profileImageUrl));
                    return "user/link-account";
                } else {
                    log.info("이미 연동한 사용자");
                    session.setAttribute("loginUser", user);
                    return redirectToPreviousPage();
                }
            }

            log.info("소셜 정보 db에 저장 후 로그인.");
            User loginUser = userService.createSocialAccount(attributes);
            session.setAttribute("loginUser", loginUser);
            return redirectToPreviousPage();

        } catch (Exception e) {
            log.error("Error occurred during social login: ", e);
            throw new SocialLoginException("Failed during social login: " + e.getMessage());
        }
    }

    private String redirectToPreviousPage() {
        try {
            String redirectUrl = (String) session.getAttribute("redirectUrl");
            log.info( "리다이렉트 Url : "+redirectUrl);
            if (redirectUrl == null || redirectUrl.isEmpty()) {
                redirectUrl = "/";
            }
            session.removeAttribute("redirectUrl");
            return "redirect:" + redirectUrl;
        } catch (Exception e) {
            log.error("Error occurred while redirecting to previous page: ", e);
            throw new RedirectErrorException("Failed to redirect to previous page: " + e.getMessage());
        }
    }
}
