package com.githrd.figureDataInsert.apidata.repository;

import com.githrd.figureDataInsert.apidata.vo.Product;
import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.sql.PreparedStatement;
import java.util.List;

@Repository
@RequiredArgsConstructor
public class ProductBulkRepository {

    private final JdbcTemplate jdbcTemplate;

    @Transactional
    public void bulkInsertProducts(List<Product> products) {
        String sql = "INSERT INTO products (title, maker, link, price, image_url) " +
                "VALUES (?, ?, ?, ?, ?)";

        jdbcTemplate.batchUpdate(sql,
                products,
                products.size(),
                (PreparedStatement ps, Product product) -> {
                    ps.setString(1, product.getTitle());
                    ps.setString(2, product.getMaker());
                    ps.setString(3, product.getLink());
                    ps.setString(4, product.getPrice());
                    ps.setString(5, product.getImageUrl());
                });

    }

}
