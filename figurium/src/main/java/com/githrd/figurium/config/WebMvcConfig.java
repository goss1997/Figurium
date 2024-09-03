package com.githrd.figurium.config;

import com.githrd.figurium.exception.MyCustomExceptionResolver;
import com.githrd.figurium.interceptor.LoginInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.util.List;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    /**
     * 예외 처리를 위한 Handler 추가.
     */
    @Override
    public void configureHandlerExceptionResolvers(List<HandlerExceptionResolver> resolvers) {
        // MyCustomExceptionResolver를 추가하여 예외 처리
        resolvers.add(new MyCustomExceptionResolver());
    }



//    @Override
//    public void addResourceHandlers(ResourceHandlerRegistry registry) {
//        // 정적 리소스에 대한 핸들러 설정 (필요 시 추가)
//    }
//
//    @Bean
//    public InternalResourceViewResolver viewResolver() {
//        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
//        resolver.setPrefix("/WEB-INF/views/");
//        resolver.setSuffix(".jsp");
//        return resolver;
//    }
//
    /**
     * 사용자의 로그인 검증을 위한 Interceptor 추가.
     */
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        //인증 체크
        registry.addInterceptor(new LoginInterceptor())
                // 인증이 필요한 url
                .addPathPatterns("/CartList.do")
                // 인증을 제외할 url
                .excludePathPatterns(
                        "/resources/**"
                );
    }


}



