package com.githrd.figurium.apidata.controller;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.githrd.figurium.apidata.repository.ProductRepository;
import com.githrd.figurium.apidata.vo.Product;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.apache.logging.log4j.util.Strings.isNotBlank;

@Component
@RequiredArgsConstructor
public class ApiLoader implements ApplicationRunner {

    private static final String CLIENT_ID = "k3dOcVhGUB1aI43JnnPZ"; // 네이버 개발자 센터에서 발급받은 클라이언트 ID
    private static final String CLIENT_SECRET = "H3EvTVFM8B"; // 네이버 개발자 센터에서 발급받은 클라이언트 시크릿

    private final ProductRepository productRepository;

    @Override
    public void run(ApplicationArguments args) throws Exception {
        System.out.println("--- 스프링부트 실행 시 메소드 호출 라인 ---");

        List<Product> productList = new ArrayList<>();
        List<String> category = Arrays.asList("반프레스토", "세가", "후류", "메가하우스", "반다이");


        String query = "피규어";
        String apiUrl = "https://openapi.naver.com/v1/search/shop.json?query=" + query + "+" + category.get(0) + "&display=100";

        // Create RestTemplate instance
        RestTemplate restTemplate = new RestTemplate();

        // Set request headers
        HttpHeaders headers = new HttpHeaders();
        headers.set("X-Naver-Client-Id", CLIENT_ID);
        headers.set("X-Naver-Client-Secret", CLIENT_SECRET);

        // Create HTTP entity with headers
        HttpEntity<String> entity = new HttpEntity<>(headers);

        // Make HTTP GET request
        ResponseEntity<String> response = restTemplate.exchange(apiUrl, HttpMethod.GET, entity, String.class);
        String jsonResponse = response.getBody();

        // Parse JSON response using Jackson ObjectMapper
        ObjectMapper objectMapper = new ObjectMapper();

        // 알 수 없는 필드를 무시하도록 설정
        objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

        // null 또는 빈 값 제외
        objectMapper.setSerializationInclusion(JsonInclude.Include.NON_EMPTY);

        try {
            JsonNode rootNode = objectMapper.readTree(jsonResponse);
            JsonNode itemsNode = rootNode.path("items");

            if (itemsNode.isArray() && !itemsNode.isEmpty()) {

                for (JsonNode node : itemsNode) {

                    // Convert JSON node to Product object
                    Product product = objectMapper.treeToValue(node, Product.class);

                    // brand와 maker가 공란이 아닌지 확인
                    if (isNotBlank(product.getBrand()) && isNotBlank(product.getMaker())) {
                        // 조건을 만족하는 경우만 리스트에 추가
                        productList.add(product);
                    }

                }

                // insert all product to database
                // saveAllAndFlush : flush와 db 저장을 한번에 하기.
                productRepository.saveAllAndFlush(productList);

            } else {
                System.out.println("No items found.");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

    }


}
