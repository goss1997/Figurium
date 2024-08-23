package com.githrd.figureDataInsert.apidata.service;

import com.githrd.figureDataInsert.apidata.repository.ProductBulkRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ProductService {

    private final ProductBulkRepository productBulkRepository;




}
