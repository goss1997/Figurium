package com.githrd.figurium.productLike.dao;

import com.githrd.figurium.productLike.vo.ProductLikeVo;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ProductLikeDao {

    /**
     * 사용자가 해당 상품을 이미 추천했는지 확인
     *
     * @return 추천했으면 true, 아니면 false
     */

    boolean isProductLiked(ProductLikeVo productLikeVo);

    /**
     * 상품의 추천 수를 증가
     */
    public void incrementLikeCount(ProductLikeVo productLikeVo);

    /**
     * 상품의 추천 수를 감소
     */
    public void decrementLikeCount(ProductLikeVo productLikeVo);

    /**
     * 사용자의 추천 정보를 추가
     */
    public void addLike(ProductLikeVo productLikeVo);

    /**
     * 사용자의 추천 정보를 제거
     */
    public void removeLike(ProductLikeVo productLikeVo);

    /**
     * 해당 상품과 유저의 id를 받아서 상품 화면에 뿌릴 때 좋아요를 눌렀는지 확인 하는 로직
     */
    boolean isProductLikedByUser(int productId, int userId);
}
