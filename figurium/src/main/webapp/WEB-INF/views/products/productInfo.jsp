<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="fun" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>상품상세</title>
    <link rel="stylesheet" type="text/css" href="../../../resources/css/productInfo.css">

</head>
<jsp:include page="../common/header.jsp"/>
<body>
<div style="height: 90px"></div>
<div id="content-wrap-area">
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
                    <img src="${product.imageUrl}">
                </div>
            </div>

            <!-- 상품의 이름이나 가격 결제 금액 등 들어 갈 곳 -->
            <div class="product_info">
                <h3>${product.name}</h3>
                <h5>${product.price}￦</h5>
                <div class="block2-txt-child2">
                    <a href="#" id="product_like" class="btn-addwish-b2">
                        <img id="heart-icon" class="icon-heart"
                             src="${pageContext.request.contextPath}/resources/images/icons/icon-heart-01.png"
                             alt="Empty Heart Icon">
                    </a>
                </div>
                <hr>
                <table class="info_table">
                    <tr>
                        <th>제조사</th>
                        <td>${product.category.name}</td>
                    </tr>

                    <tr>
                        <th>남은재고</th>
                        <td>${product.quantity}</td>
                    </tr>

                    <tr>
                        <th>출고 날짜</th>
                        <td>${fun:substring(product.createdAt,0,10)}</td>
                    </tr>

                    <tr>
                        <th>수량</th>
                        <td>
                            <div class="quantity-box">
                                <button type="button" class="quantity-btn decrease" onclick="decreaseQuantity()">-
                                </button>
                                <input type="text" id="quantity" value="1" readonly>
                                <button type="button" class="quantity-btn increase" onclick="increaseQuantity()">+
                                </button>
                            </div>
                        </td>
                    </tr>
                </table>

                <hr>
                <div class="total_price_box">
                    <span class="total_price">총 결제금액</span>
                    <p id="total_price">${product.price}</p>원
                </div>

                <div class="price_bye">
                    <input class="price_bye_btn" type="button" value="바로구매"
                           onclick="location.href='shopingCart2.do'">
                </div>

                <div class="price_cart">
                    <input class="price_cart_btn" type="button" value="장바구니"
                           onclick="location.href='shopingCart.do'">
                </div>
            </div>

        </div>
    </form>
    <!-- 리뷰,Q&A Tap-->

    <div class="tap_box">
        <ul class="tap_detail">
            <li class="tap_review"><a href="#">Reviews(${reviewCount})</a></li>
            <li class="tap_qa"><a href="#">Q&A(0)</a></li>
        </ul>

    </div>

    <!-- 리뷰영역 -->
    <div class="reviews_box">
        <form>
            <input type="hidden" name="productId" value="${product.id}">
            <span class="reviewInsert_btn_box">
                    <input class="reviewInsert_btn" type="button" value="리뷰작성" onclick="reviewInsertForm(this.form);">
                </span>
        </form>

        <table class="review_table">
            <tr>
                <th class="review_number">번호</th>
                <th class="review_title">제목</th>
                <th class="review_name">작성자</th>
                <th class="review_regdate">작성일</th>
                <th class="review_star">별점</th>
            </tr>

            <c:forEach var="review" items="${reviewList}">
                <tr>
                    <td>${review.number}</td>
                    <td class="review_td_title">${review.title}</td>
                    <td>${review.content}</td>
                    <td>
                            ${fun:substring(review.createdAt,0,10)} ${fun:substring(review.createdAt,11,16)}
                    </td>
                    <td class="review_star">
                        <!-- 별점 예시: review.rating 값에 따라 별 표시 -->
                        <c:forEach var="i" begin="1" end="${review.rating}">
                            <span class="star">&#9733;</span>
                        </c:forEach>
                        <c:forEach var="i" begin="${review.rating + 1}" end="5">
                            <span class="star">&#9734;</span>
                        </c:forEach>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>


    <!-- Q&A Tap -->

    <div class="tap_box">
        <ul class="tap_detail">
            <li class="tap_review"><a href="#">Reviews(${reviewCount})</a></li>
            <li class="tap_qa"><a href="#">Q&A(0)</a></li>
        </ul>

    </div>
    <!-- Q&A 영역 -->

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
                <th class="review_star">상태</th>
            </tr>

            <tr>
                <td>1</td>
                <td class="review_td_title">[기타문의]입고 문의</td>
                <td>홍길동</td>
                <td>2024-08-28</td>
                <td>답변완료</td>
            </tr>

            <!-- 테이블의 더미 데이터 -->
            <tr>
                <td>1</td>
                <td class="review_td_title">[기타문의]입고 문의</td>
                <td>홍길동</td>
                <td>2024-08-28</td>
                <td>미답변</td>
            </tr>

            <tr>
                <td>1</td>
                <td class="review_td_title">[기타문의]입고 문의</td>
                <td>홍길동</td>
                <td>2024-08-28</td>
                <td>미답변</td>
            </tr>

            <tr>
                <td>1</td>
                <td class="review_td_title">[기타문의]입고 문의</td>
                <td>홍길동</td>
                <td>2024-08-28</td>
                <td>답변완료</td>
            </tr>

            <tr>
                <td>1</td>
                <td class="review_td_title">[기타문의]입고 문의</td>
                <td>홍길동</td>
                <td>2024-08-28</td>
                <td>답변완료</td>
            </tr>

        </table>
    </div>
</div>


<jsp:include page="../common/footer.jsp"/>
</body>


<script>
    //상품의 좋아요 하트 채우기
    document.addEventListener('DOMContentLoaded', function () {
        var heartIcon = document.getElementById('heart-icon');
        var isLiked = false;  // 하트가 클릭 되었는지 확인

        heartIcon.addEventListener('click', function (e) {
            e.preventDefault();

            if (isLiked) {
                heartIcon.src = '/resources/images/icons/icon-heart-01.png'; // 빈 하트 이미지
            } else {
                heartIcon.src = '/resources/images/icons/icon-heart-02.png'; // 채워진 하트 이미지
            }

            isLiked = !isLiked;  // 클릭 시 마다 하트가 채워지고 사라지고 반복 가능
        });
    });

</script>


<script>
    // 상품의 수량 선택 버튼이 동작 될 때마다 가격 변동 설정
    const pricePerUnit = ${product.price}; // 상품의 가격
    const maxQuantity = ${product.quantity}; // 최대 재고량

    function decreaseQuantity() {
        var quantityInput = document.getElementById('quantity');
        var currentQuantity = parseInt(quantityInput.value);

        if (currentQuantity > 1) {
            quantityInput.value = currentQuantity - 1;
            updateTotalPrice();
        }
    }

    function increaseQuantity() {
        var quantityInput = document.getElementById('quantity');
        var currentQuantity = parseInt(quantityInput.value);
        var maxQuantity = ${product.quantity}; // 상품의 재고량까지

        if (currentQuantity < maxQuantity) {
            quantityInput.value = currentQuantity + 1;
            updateTotalPrice();
        }
    }

    function updateTotalPrice() {
        var quantity = parseInt(document.getElementById('quantity').value);
        var pricePerUnit = ${product.price}; // 상품의 가격
        var totalPrice = quantity * pricePerUnit; // 상품의 총 가격 = 현재 수량 * 상품의 가격
        document.getElementById('total_price').innerHTML = totalPrice; // 해당 ID값에 뿌림
    }
</script>

<script>
    // 리뷰작성 버튼 클릭 함수
    function reviewInsertForm(f) {

        let productId = f.productId.value;

        let user = "${sessionScope.user}";

        if (user === "null" || user === "") {
            alert("로그인이 필요한 서비스 입니다.");
            return;
        }

        f.action = 'reviewInsertForm.do';
        f.method = "POST";
        f.submit();

    }

</script>


</html>