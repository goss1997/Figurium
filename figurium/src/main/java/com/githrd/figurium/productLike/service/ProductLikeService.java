package com.githrd.figurium.productLike.service;

import com.githrd.figurium.productLike.vo.ProductLikeVo;

public interface ProductLikeService {

   public int toggleProductLike(ProductLikeVo vo);

   boolean isProductLikedByUser(int productId, int userId);
}
