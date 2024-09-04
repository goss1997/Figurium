package com.githrd.figurium.productLike.service;

import com.githrd.figurium.productLike.dao.ProductLikeDao;
import com.githrd.figurium.productLike.vo.ProductLikeVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class ProductLikeServiceImpl implements ProductLikeService {

    private final ProductLikeDao productLikeDao;

    @Autowired
    ProductLikeServiceImpl(ProductLikeDao productLikeDao) {
        this.productLikeDao = productLikeDao;
    }


    @Override
    public int toggleProductLike(ProductLikeVo productLikeVo) {
        if (productLikeDao.isProductLiked(productLikeVo)) {
            productLikeDao.decrementLikeCount(productLikeVo);
            productLikeDao.removeLike(productLikeVo);
            return 0; // 좋아요 취소
        } else {
            productLikeDao.addLike(productLikeVo);
            productLikeDao.incrementLikeCount(productLikeVo);
            return 1; // 좋아요 추가
        }
    }

    @Override
    public boolean isProductLikedByUser(int productId, int userId) {
        return productLikeDao.isProductLikedByUser(productId,userId);
    }


}
