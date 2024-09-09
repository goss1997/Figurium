package com.githrd.figurium.productLike.service;

import com.githrd.figurium.productLike.dao.ProductLikeMapper;
import com.githrd.figurium.productLike.vo.ProductLikeVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ProductLikeServiceImpl implements ProductLikeService {

    private final ProductLikeMapper productLikeMapper;

    @Autowired
    ProductLikeServiceImpl(ProductLikeMapper productLikeMapper) {
        this.productLikeMapper = productLikeMapper;
    }


    @Override
    public int toggleProductLike(ProductLikeVo productLikeVo) {
        if (productLikeMapper.isProductLiked(productLikeVo)) {
            productLikeMapper.decrementLikeCount(productLikeVo);
            productLikeMapper.removeLike(productLikeVo);
            return 0; // 좋아요 취소
        } else {
            productLikeMapper.addLike(productLikeVo);
            productLikeMapper.incrementLikeCount(productLikeVo);
            return 1; // 좋아요 추가
        }
    }

    @Override
    public boolean isProductLikedByUser(int productId, int userId) {
        return productLikeMapper.isProductLikedByUser(productId, userId);
    }

    @Override
    @Transactional
    public int deleteProductLike(ProductLikeVo productLikeVo) {
        return productLikeMapper.removeLike(productLikeVo);
    }


}
