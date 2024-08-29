package com.githrd.figurium.order.config;

import com.siot.IamportRestClient.IamportClient;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AppConfig {

    String apiKey = "1108573077381870";
    String secretKey = "p7w48z3iVEeq6QO8vBA5sOPevweFp7LmcApW5ZFePYX3vJSt7dyyIZdsYs3KfEjztvMy9FlqhPmY0zgn";

    @Bean
    public IamportClient iamportClient() {
        return new IamportClient(apiKey, secretKey);
    }
}
