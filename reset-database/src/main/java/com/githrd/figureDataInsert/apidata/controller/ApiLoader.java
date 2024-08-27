package com.githrd.figureDataInsert.apidata.controller;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.githrd.figureDataInsert.apidata.repository.CategoryRepository;
import com.githrd.figureDataInsert.apidata.repository.ProductBulkRepository;
import com.githrd.figureDataInsert.apidata.vo.Product;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
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
import java.util.Random;

/**
 * ApiLoader : springboot 실행 시 바로 실행하기 위해 ApplicationRunner를 상속받았다.
 */

@Component
@RequiredArgsConstructor
public class ApiLoader implements ApplicationRunner {


    private static final String CLIENT_ID = "k3dOcVhGUB1aI43JnnPZ"; // 네이버 개발자 센터에서 발급받은 클라이언트 ID
    private static final String CLIENT_SECRET = "H3EvTVFM8B"; // 네이버 개발자 센터에서 발급받은 클라이언트 시크릿

    private final ProductBulkRepository productBulkRepository;
    private final CategoryRepository categoryRepository;

    @Override
    public void run(ApplicationArguments args) throws Exception {
        // 시작 시간 기록 (초 단위로 변환)
        long startTimeMillis = System.currentTimeMillis();
        double startTime = startTimeMillis / 1000.0;

        List<String> categories = Arrays.asList("반프레스토", "세가", "후류", "메가하우스", "반다이");

        // db 삽입용 메소드
        for (String category : categories) {
            System.out.println(" - - - - - "+category+" 데이터 삽입 중~ - - - - - ");

            // db에 카테고리 저장.
            categoryRepository.insertCategory(category);

            // 처음(start=1) 100건 조회 후 그 다음 건부터 또 100건 조회를 위한 반복문
            // 총 1000건 조회
            for (int start = 1; start < 1000; start += 100) {

                // naver open api url
                String apiUrl = "https://openapi.naver.com/v1/search/shop.json?query=피규어+" + category + "&display=100&start=" + start;

                // api를 통해 db에 저장하는 메소드
                insertDataFromNaverApiIntoDB(apiUrl, category);

            }

        }


        // 종료 시간 기록 (초 단위로 변환)
        long endTimeMillis = System.currentTimeMillis();
        double endTime = endTimeMillis / 1000.0;

        System.out.println("실행 시간: " + String.format("%.2f", (endTime - startTime)) + " 초");
        System.out.println(" - - - - F I N I S H - - - - ");

        // 애플리케이션 종료
        System.exit(0);
    }

    private void insertDataFromNaverApiIntoDB(String apiUrl, String category) {

        List<Product> productList = new ArrayList<>();

        // Create RestTemplate instance
        // api 요청하는 객체
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
        // json을 객체로 역직렬화를 위한 객체
        ObjectMapper objectMapper = new ObjectMapper();

        // 알 수 없는 필드를 무시하도록 설정
        objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

        // null 또는 빈 값 제외
        objectMapper.setSerializationInclusion(JsonInclude.Include.NON_EMPTY);

        try {
            // reedTree
            JsonNode rootNode = objectMapper.readTree(jsonResponse);
            JsonNode itemsNode = rootNode.path("items");
            int total = Integer.parseInt(rootNode.get("total").asText());

            if (itemsNode.isArray() && !itemsNode.isEmpty()) {

                for (JsonNode node : itemsNode) {

                    // Convert JSON node to Product object
                    // 이 한줄로 json을 객체로 역직렬화.
                    Product product = objectMapper.treeToValue(node, Product.class);

                    // Random 객체 생성
                    Random random = new Random();

                    // 1부터 10까지의 랜덤 정수 생성
                    int randomNumber = random.nextInt(10) + 1;

                    String maker = node.get("maker").asText();

                    // maker가 해당 category인 경우에만 추가
                    if (maker.equals(category)) {

                        // set categoryName
                        product.setCategoryName(category);

                        // set random quantity
                        product.setQuantity(randomNumber);

                        // 조건을 만족하는 경우만 리스트에 추가
                        productList.add(product);
                    }

                }

                // Bulk insert all product to database
                // insert 묶음으로 날린다. 성능향상.
                // 대량의 더미 데이터 삽입을 위해 bulk insert 하기
                productBulkRepository.bulkInsertProducts(productList);

            } else {
                System.out.println("No items found.");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
