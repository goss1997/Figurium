package com.githrd.figurium.apidata.service;

import com.githrd.figurium.apidata.repository.ProductBulkRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ProductService {

    private final ProductBulkRepository productBulkRepository;




}
