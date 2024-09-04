package com.githrd.figurium.productLike.dao;

import com.githrd.figurium.productLike.vo.ProductLikeVo;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ProductLikeDao {

    /**
     * 사용자가 해당 상품을 이미 추천했는지 확인합니다.
     *
     * @return 추천했으면 true, 아니면 false
     */

    boolean isProductLiked(ProductLikeVo productLikeVo);

    /**
     * 상품의 추천 수를 증가시킵니다.
     */
    public void incrementLikeCount(ProductLikeVo productLikeVo);

    /**
     * 상품의 추천 수를 감소시킵니다.
     */
    public void decrementLikeCount(ProductLikeVo productLikeVo);

    /**
     * 사용자의 추천 정보를 추가합니다.
     */
    public void addLike(ProductLikeVo productLikeVo);

    /**
     * 사용자의 추천 정보를 제거합니다.
     */
    public void removeLike(ProductLikeVo productLikeVo);

    boolean isProductLikedByUser(int productId, int userId);
}
