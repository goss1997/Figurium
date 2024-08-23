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
        String sql = "INSERT INTO products (category_id, name, price, quantity, image_url) " +
                "VALUES (?, ?, ?, ?, ?)";

        jdbcTemplate.batchUpdate(sql,
                products,
                products.size(),
                (PreparedStatement ps, Product product) -> {
                    ps.setInt(1, product.getCategoryId());
                    ps.setString(2,product.getName());
                    ps.setString(3,product.getPrice());
                    ps.setInt(4,product.getQuantity());
                    ps.setString(5,product.getImageUrl());
                });

    }

}
