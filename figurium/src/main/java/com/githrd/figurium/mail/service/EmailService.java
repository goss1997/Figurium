package com.githrd.figurium.mail.service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import java.util.Random;

@Service
@RequiredArgsConstructor
public class EmailService {

    private final JavaMailSender mailSender;
    private final HttpServletRequest request;


    public String sendVerificationEmail(String toEmail) throws MessagingException {
        // 6자리 랜덤 인증번호 생성
        String verificationCode = generateVerificationCode();

        // 이메일 메시지 작성
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true);

        helper.setFrom("Figurium");
        helper.setTo(toEmail);
        helper.setSubject("Figurium 이메일 인증");
        // HTML 형식으로 이메일 본문 작성
        String htmlContent = "<div style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #ddd; border-radius: 10px;'>"
                + "<h2 style='color: #333;'>Figurium 이메일 인증 코드</h2>"
                + "<p>안녕하세요,</p>"
                + "<p>회원가입을 완료하려면 아래 인증 코드를 입력해 주세요.</p>"
                + "<div style='background-color: #f8f9fa; border: 1px solid #e1e1e1; padding: 15px; text-align: center; font-size: 24px; font-weight: bold; color: #0056b3;'>"
                + verificationCode
                + "</div>"
                + "<p>감사합니다!<br>Figurium 팀</p>"
                + "<hr style='border: none; border-top: 1px solid #e1e1e1;'>"
                + "<small style='color: #666;'>이 이메일은 자동으로 생성된 메시지입니다. 답장하지 마세요.</small>"
                + "</div>";

        helper.setText(htmlContent, true); // 두 번째 매개변수 true는 HTML 형식을 나타냄

        // 이메일 발송
        mailSender.send(message);

        return verificationCode; // 생성된 인증번호 반환
    }

    public boolean sendPasswordResetUrl(String toEmail) throws MessagingException {

        // 서버 경로 가져오기
        String scheme = request.getScheme(); // http or https
        String serverName = request.getServerName(); // server host name

        // 실서버일 경우 https로 변경
        if(serverName.equals("www.figurium.shop")) {
            scheme = "https";
        }
        
        int serverPort = request.getServerPort(); // port number

        // Build the base URL
        String baseUrl = scheme + "://" + serverName + ":" + serverPort + request.getContextPath();

        // 이메일 메시지 작성
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true);

        helper.setFrom("Figurium");
        helper.setTo(toEmail);
        helper.setSubject("Figurium 비밀번호 재설정");
        // HTML 형식으로 이메일 본문 작성
        String htmlContent = "<div style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #ddd; border-radius: 10px;'>"
                + "<h2 style='color: #333;'>Figurium 비밀번호 재설정</h2>"
                + "<p>안녕하세요,</p>"
                + "<p>회원님의 " + toEmail + " 계정 비밀번호 재설정을 위해 아래 버튼을 클릭해주세요:</p>"
                + "<form action='" + baseUrl + "/user/reset-password-form.do' method='POST' style='text-align: center;'>"
                + "<input type='hidden' name='updateEmail' value='" + toEmail + "'/>"
                + "<button type='submit' style='background-color: #0056b3; color: white; border: none; padding: 15px 30px; font-size: 16px; border-radius: 5px; cursor: pointer;'>비밀번호 재설정</button>"
                + "</form>"
                + "<p>감사합니다!<br>Figurium 팀</p>"
                + "<hr style='border: none; border-top: 1px solid #e1e1e1;'>"
                + "<small style='color: #666;'>이 이메일은 자동으로 생성된 메시지입니다. 답장하지 마세요.</small>"
                + "</div>";

        helper.setText(htmlContent, true); // 두 번째 매개변수 true는 HTML 형식을 나타냄

        // 이메일 발송
        mailSender.send(message);

        return true; // 성공 시 true 반환
    }


    private String generateVerificationCode() {
        Random random = new Random();
        int code = 100000 + random.nextInt(900000);  // 6자리 인증번호 생성
        return String.valueOf(code);
    }
}
