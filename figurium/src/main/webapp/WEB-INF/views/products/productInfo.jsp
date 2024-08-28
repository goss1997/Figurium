<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>상품상세</title>
    <link rel="stylesheet" type="text/css" href="../../../resources/css/productInfo.css">
</head>
<jsp:include page="../common/header.jsp"/>
<body>
<div style="height: 90px">
    <div style="height: 50px;"></div>


    <div class="info_title">
        <div class="bread-crumb flex-w p-l-25 p-r-15 p-t-30 p-lr-0-lg">
            <a href="../" class="stext-109 cl8 hov-cl1 trans-04">
                Home
                <i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
            </a>

            <span class="stext-109 cl4">
                상품상세
            </span>
        </div>
    </div>

    <form>
        <!-- 상품에 대한 상세 이미지, 이름 등 넣을 곳 -->
        <div class="product_title">
            <div class="product_img_box">
                <!-- 상품의 이미지가 들어 갈 곳 -->
                <div class="product_img">
                    <img src="../../../resources/images/example.jpg">
                </div>
            </div>

            <!-- 상품의 이름이나 가격 결제 금액 등 들어 갈 곳 -->
            <div class="product_info">
                <h3>dddddddddddddddddddddddddddddddddddddddddddddddd</h3>
                <h5>15,000 원</h5>
                <hr>
                <table class="info_table">
                    <tr>
                        <th>제조사</th>
                        <td>반프레스토</td>
                    </tr>

                    <tr>
                        <th>남은재고</th>
                        <td>4</td>
                    </tr>

                    <tr>
                        <th>출고 날짜</th>
                        <td>2024-08-28</td>
                    </tr>

                    <tr>
                        <th>수량</th>
                        <td>
                            <div class="quantity-box">
                                <button type="button" class="quantity-btn decrease" onclick="decreaseQuantity()">-</button>
                                <input type="text" id="quantity" value="1" readonly>
                                <button type="button" class="quantity-btn increase" onclick="increaseQuantity()">+</button>
                            </div>
                        </td>
                    </tr>
                </table>

                <hr>
                <div class="total_price_box">
                    <span class="total_price">총 결제금액</span>
                    <p>50000</p>원
                </div>

                <div class="price_bye">
                    <input class="price_bye_btn" type="button" value="바로구매">
                </div>

                <div class="price_cart">
                    <input class="price_cart_btn" type="button" value="장바구니">
                </div>
            </div>

        </div>
    </form>
    <!-- TODO 리뷰 , Q&A 선택-->

    <!-- 리뷰영역 -->
    <div class="reviews_box">

        <span class="reviewInsert_btn_box">
            <input class="reviewInsert_btn" type="button" value="리뷰작성">
        </span>

        <table class="review_table">
            <tr>
                <th class="review_number">번호</th>
                <th class="review_title">제목</th>
                <th class="review_name">작성자</th>
                <th class="review_regdate">작성일</th>
                <th class="review_star">별점</th>
            </tr>

            <tr>
                <td>1</td>
                <td class="review_td_title">리뷰</td>
                <td>에이스</td>
                <td>2024-08-28</td>
                <td>5</td>
            </tr>

            <!-- 테이블의 더미 데이터 -->
            <tr>
                <td>1</td>
                <td class="review_td_title">리뷰</td>
                <td>에이스</td>
                <td>2024-08-28</td>
                <td>5</td>
            </tr>

            <tr>
                <td>1</td>
                <td class="review_td_title">리뷰</td>
                <td>에이스</td>
                <td>2024-08-28</td>
                <td>5</td>
            </tr>

            <tr>
                <td>1</td>
                <td class="review_td_title">리뷰</td>
                <td>에이스</td>
                <td>2024-08-28</td>
                <td>5</td>
            </tr>

            <tr>
                <td>1</td>
                <td class="review_td_title">리뷰</td>
                <td>에이스</td>
                <td>2024-08-28</td>
                <td>5</td>
            </tr>

        </table>

        <!-- Comment Test 용 -->
        <div class="comment-list">
            <div class="c-div">댓글목록</div>
        </div>
        <div class="comments">

            <div class="comment-update">
                <span class="comment-reply">이름</span>
                <span class="comment-reply">&nbsp; │ &nbsp;</span>
                <span class="comment-date">2024-08-28</span>
            </div>

        </div>

        <form class="fo">
            <div class="comment-input">
                <textarea placeholder="댓글을 입력하세요" name="cmt_content"></textarea>
            </div>
            <div class="comment-btn">
                <button onclick="comment_insert(this.form); return false;">댓글등록</button>
            </div>
        </form>
    </div>
</div>


<%--<jsp:include page="../common/footer.jsp"/>--%>
</body>


<script>
    // 수량을 정하는 버튼의 함수

    function decreaseQuantity() {
        var quantityInput = document.getElementById("quantity");
        var currentValue = parseInt(quantityInput.value);
        if (currentValue > 1) {
            quantityInput.value = currentValue - 1;
        }
    }

    function increaseQuantity() {
        var quantityInput = document.getElementById("quantity");
        var currentValue = parseInt(quantityInput.value);
        quantityInput.value = currentValue + 1;
    }

</script>


</html>