package com.githrd.figurium.config;

import com.githrd.figurium.exception.MyCustomExceptionResolver;
import com.githrd.figurium.interceptor.LoginInterceptor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import java.util.List;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Bean
    public ViewResolver viewResolver() {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setPrefix("/WEB-INF/views/");
        resolver.setSuffix(".jsp");
        return resolver;
    }


    /**
     * 예외 처리를 위한 Handler 추가.
     */
    @Override
    public void configureHandlerExceptionResolvers(List<HandlerExceptionResolver> resolvers) {
        // MyCustomExceptionResolver를 추가하여 예외 처리
        resolvers.add(new MyCustomExceptionResolver());
    }

    /**
     * 사용자의 로그인 검증을 위한 Interceptor 추가.
     */
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        //인증 체크
        registry.addInterceptor(new LoginInterceptor())
                // 인증이 필요한 url

                // 인증을 제외할 url
                .excludePathPatterns(
                        "/resources/**",
                        "/",
                        "/user/logout.do",
                        "/user/login.do",
                        "/user/signup-form.do",
                        "/user/check_email.do",
                        "/user/sign-up.do",
                        "/productInfo.do",
                        "/qa/qaList.do",
                        "/qa/qaSelect.do"
                );
    }

}
