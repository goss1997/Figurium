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
    <style>
        .product_insert > input{
            background-color:transparent;
        }
        .product_insert:hover > input{
            background-color:transparent;
            color: white;
        }

        .product_insert > button{
            background-color:transparent;
        }
        .product_insert:hover > button{
            background-color:transparent;
            color: white;
        }

    </style>

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
            <br>
            <c:if test="${loginUser.role == '1'}">

                <div style="margin-left : 60%">
                    <div class="flex-c-m stext-106 cl6 size-104 bor4 pointer hov-btn3 trans-04 m-r-8 m-tb-4 product_insert">
                        <input type="button" value="상품수정" onclick="if(confirm('정말 수정하시겠습니까?')) location.href='#'">
                    </div>
                    <div class="flex-c-m stext-106 cl6 size-104 bor4 pointer hov-btn3 trans-04 m-r-8 m-tb-4 product_insert">
                        <button class="delete-button" data-product-id="${product.id}">상품삭제</button>
                    </div>
                </div>
            </c:if>
        </div>
    </div>

        <!-- 상품에 대한 상세 이미지, 이름 등 넣을 곳 -->
        <input type="hidden" value="${product.id}">
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
                           onclick="addToCart(${product.id})">
                </div>
                <script>
                    function addToCart(productId) {
                        let quantity = $("#quantity").val();
                        location.href = "shopingCart.do?productId=" + productId + "&quantity=" + quantity;
                    }
                </script>
            </div>

        </div>
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
            <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
                <th>별점</th>
            </tr>
            </thead>
            <tbody id="reviewTable">
            <c:forEach var="review" items="${reviewList}">
                <tr>
                    <td class="review_number">${review.number}</td>
                    <td>
                        <a href="#" class="review-title" data-id="${review.id}">${review.title}</a>
                    </td>
                    <td class="review_name">${review.userName}</td>
                    <td class="review_regdate">${fun:substring(review.createdAt,0,10)} ${fun:substring(review.createdAt,11,16)}</td>
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
                <!-- 리뷰 내용을 표시할 영역 -->
                <tr id="reviewContent-${review.id}" class="review-content" style="display:none;">
                    <td colspan="5">
                        <div id="spinner-${review.id}" class="spinner" style="display:none;">로딩 중...</div>
                        <div id="reviewText-${review.id}" class="review-text"></div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>


    </div>
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

        let user = "${sessionScope.loginUser}";

        if (user === "null" || user === "") {
            alert("로그인이 필요한 서비스 입니다.");
            return;
        }

        f.action = 'reviewInsertForm.do';
        f.method = "POST";
        f.submit();

    }

</script>



<script>
    $(document).ready(function() {
        $('.review-title').on('click', function(e) {
            e.preventDefault();

            var reviewId = $(this).data('id');
            var contentRow = $('#reviewContent-' + reviewId);
            var spinner = $('#spinner-' + reviewId);
            var reviewText = $('#reviewText-' + reviewId);

            if (contentRow.is(':visible')) {
                contentRow.hide();
                return;
            }

            $('.review-content').hide();
            spinner.show();

            $.ajax({
                url: 'getReviewContent',
                type: 'GET',
                data: { id: reviewId },
                success: function(response) {
                    var contentHtml = '<div class="review-text-left">' + response.content + '</div>';

                    if (response.imageUrl) { // imageUrl이 있으면 이미지를 표시
                        contentHtml += '<img src="' + response.imageUrl + '" alt="Review Image">';
                    }

                    reviewText.html(contentHtml);
                    contentRow.show();
                    spinner.hide();
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    var errorMessage = '리뷰 내용을 불러오는 데 실패했습니다.';

                    // 에러 상태 코드와 메시지를 포함
                    if (jqXHR.status) {
                        errorMessage += ' 상태 코드: ' + jqXHR.status;
                    }
                    if (errorThrown) {
                        errorMessage += ', 오류 메시지: ' + errorThrown;
                    }

                    alert(errorMessage);
                    spinner.hide();
                }
            });
        });
    });

</script>

<script >

    $(document).ready(function () {
        $('.delete-button').on('click', function () {
            var productId = $(this).data('product-id');

            if (confirm('정말 삭제하시겠습니까?')) {
                $.ajax({
                    url: '/productDelete.do/' + productId,
                    type: 'DELETE',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    success: function (response) {
                        // 삭제 성공 후 페이지 새로 고침
                        window.location.href="/";
                    },
                    error: function (xhr, status, error) {
                        alert('상품 삭제에 실패했습니다.');
                        console.error('Error:', error);
                    }
                });
            }
        });
    });


</script>

</body>

</html>