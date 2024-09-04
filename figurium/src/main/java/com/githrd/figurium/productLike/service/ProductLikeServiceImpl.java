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
        boolean isLiked = productLikeDao.isProductLiked(productLikeVo);
        if (isLiked){    // 추천 true/false
            productLikeDao.decrementLikeCount(productLikeVo); // 추천 수 감소
            productLikeDao.removeLike(productLikeVo);         // 해당 추천에 대한 유저 정보 제거
            return 0;
        }else {
            productLikeDao.incrementLikeCount(productLikeVo); // 추천 수 증가
            productLikeDao.addLike(productLikeVo);            // 해당 추천에 대한 유저 정보 추가
        return 1;
        }
    }

    @Override
    public boolean isProductLikedByUser(int productId, int userId) {
        return productLikeDao.isProductLikedByUser(productId,userId);
    }


}
