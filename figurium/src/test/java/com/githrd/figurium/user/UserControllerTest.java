package com.githrd.figurium.user;

import com.githrd.figurium.order.service.OrderService;
import com.githrd.figurium.user.controller.UserController;
import com.githrd.figurium.user.entity.User;
import com.githrd.figurium.user.service.UserService;
import com.githrd.figurium.user.vo.UserVo;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(UserController.class)
public class UserControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private UserService userService;

    @MockBean
    private OrderService orderService;

    @MockBean
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Mock
    private MockHttpSession session;

    @InjectMocks
    private UserController userController;

    @BeforeEach
    public void setup(WebApplicationContext wac) {
        MockitoAnnotations.openMocks(this);
        this.mockMvc = MockMvcBuilders.webAppContextSetup(wac).build();
    }

    @Test
    public void testLogin_Success() throws Exception {
        // Given
        User mockUser = new User();
        mockUser.setEmail("test@example.com");
        mockUser.setPassword("$2a$10$eBv..."); // Bcrypt 암호화된 비밀번호

        when(userService.findByEmail("test@example.com")).thenReturn(mockUser);
        when(bCryptPasswordEncoder.matches("password", mockUser.getPassword())).thenReturn(true);

        // When & Then
        mockMvc.perform(post("/user/login.do")
                        .param("email", "test@example.com")
                        .param("password", "password"))
                .andExpect(status().isOk())
                .andExpect(content().string("Login successful"));
    }

    @Test
    public void testLogin_Failure_WrongPassword() throws Exception {
        // Given
        User mockUser = new User();
        mockUser.setEmail("test@example.com");
        mockUser.setPassword("$2a$10$eBv..."); // Bcrypt 암호화된 비밀번호

        when(userService.findByEmail("test@example.com")).thenReturn(mockUser);
        when(bCryptPasswordEncoder.matches("wrongpassword", mockUser.getPassword())).thenReturn(false);

        // When & Then
        mockMvc.perform(post("/user/login.do")
                        .param("email", "test@example.com")
                        .param("password", "wrongpassword"))
                .andExpect(status().isUnauthorized())
                .andExpect(content().string("비밀번호가 일치하지 않습니다."));
    }

    @Test
    public void testLogout() throws Exception {
        // Given
        // No setup needed

        // When & Then
        mockMvc.perform(get("/user/logout.do"))
                .andExpect(status().is3xxRedirection());
    }

    @Test
    public void testCheckEmail_Used() throws Exception {
        // Given
        when(userService.findByEmail("test@example.com")).thenReturn(new User());

        // When & Then
        mockMvc.perform(get("/user/check_email.do")
                        .param("email", "test@example.com"))
                .andExpect(status().isOk())
                .andExpect(content().json("{\"isUsed\":true}"));
    }

    @Test
    public void testSignup_Success() throws Exception {
        // Given
        UserVo userVo = new UserVo();
        userVo.setEmail("test@example.com");
        userVo.setPassword("password");

        when(userService.signup(any(UserVo.class), any())).thenReturn(1);

        // When & Then
        mockMvc.perform(post("/user/sign-up.do")
                        .flashAttr("user", userVo))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/"));
    }

    @Test
    public void testMyPage_Success() throws Exception {
        // Given
        User mockUser = new User();
        mockUser.setId(1);
        when(session.getAttribute("loginUser")).thenReturn(mockUser);
        when(userService.findUserById(1)).thenReturn(mockUser);

        // When & Then
        mockMvc.perform(get("/user/my-page.do"))
                .andExpect(status().isOk())
                .andExpect(view().name("user/myPage"));
    }

    @Test
    public void testUpdateProfileImage_Unauthorized() throws Exception {
        // Given
        when(session.getAttribute("loginUser")).thenReturn(null);

        // When & Then
        mockMvc.perform(post("/user/update-profile-image.do")
                        .contentType(MediaType.MULTIPART_FORM_DATA)
                        .param("file", ""))
                .andExpect(status().isUnauthorized())
                .andExpect(content().string("로그인한 사용자만 요청 가능합니다."));
    }

    @Test
    public void testOrderList_Success() throws Exception {
        // Given
        User mockUser = new User();
        mockUser.setId(1);
        when(session.getAttribute("loginUser")).thenReturn(mockUser);

        // When & Then
        mockMvc.perform(get("/user/order-list.do"))
                .andExpect(status().isOk())
                .andExpect(view().name("user/myOrderList"));
    }
}
