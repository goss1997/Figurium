<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="fun" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Figurium</title>
    <meta charset="UTF-8">
    <!-- SweetAlert2 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

    <style>

        .product_insert > a {
            text-decoration: none;
            color: #888;
        }

        .product_insert:hover > a {
            text-decoration: none;
            color: white;
        }

        .section-slide{
        }
        .item-slick1{
            max-height: 500px;
        }
    </style>
</head>
<body class="animsition">
<jsp:include page="./common/header.jsp"/>
<div style="height: 75px;"></div>

<c:if test="${not empty message}">
    <script>
        Swal.fire({
            icon: 'success',
            title: '알림',
            text: '${message}'
        });
    </script>
</c:if>

<c:if test="${not empty error}">
    <script>
        Swal.fire({
            icon: 'error',
            title: '오류',
            text: '${error}'
        });
    </script>
</c:if>

<!-- 장바구니 모달 -->
<div class="wrap-header-cart js-panel-cart">
    <div class="s-full js-hide-cart"></div>

    <div class="header-cart flex-col-l p-l-65 p-r-25">
        <div class="header-cart-title flex-w flex-sb-m p-b-8">
				<span class="mtext-103 cl2">
					Your Cart
				</span>

            <div class="fs-35 lh-10 cl2 p-lr-5 pointer hov-cl1 trans-04 js-hide-cart">
                <i class="zmdi zmdi-close"></i>
            </div>
        </div>

        <div class="header-cart-content flex-w js-pscroll">
            <ul class="header-cart-wrapitem w-full">
                <li class="header-cart-item flex-w flex-t m-b-12">
                    <div class="header-cart-item-img">
                        <img src="#" alt="IMG">
                    </div>

                    <div class="header-cart-item-txt p-t-8">
                        <a href="#" class="header-cart-item-name m-b-18 hov-cl1 trans-04">
                            White Shirt Pleat
                        </a>

                        <span class="header-cart-item-info">
								1 x $19.00
							</span>
                    </div>
                </li>

                <li class="header-cart-item flex-w flex-t m-b-12">
                    <div class="header-cart-item-img">
                        <img src="#" alt="IMG">
                    </div>

                    <div class="header-cart-item-txt p-t-8">
                        <a href="#" class="header-cart-item-name m-b-18 hov-cl1 trans-04">
                            Converse All Star
                        </a>

                        <span class="header-cart-item-info">
								1 x $39.00
							</span>
                    </div>
                </li>

                <li class="header-cart-item flex-w flex-t m-b-12">
                    <div class="header-cart-item-img">
                        <img src="#" alt="IMG">
                    </div>

                    <div class="header-cart-item-txt p-t-8">
                        <a href="#" class="header-cart-item-name m-b-18 hov-cl1 trans-04">
                            Nixon Porter Leather
                        </a>

                        <span class="header-cart-item-info">
								1 x $17.00
							</span>
                    </div>
                </li>
            </ul>

            <div class="w-full">
                <div class="header-cart-total w-full p-tb-40">
                    Total: $75.00
                </div>

                <div class="header-cart-buttons flex-w w-full">
                    <a href="shoping-cart.html"
                       class="flex-c-m stext-101 cl0 size-107 bg3 bor2 hov-btn3 p-lr-15 trans-04 m-r-8 m-b-10">
                        View Cart
                    </a>

                    <a href="shoping-cart.html"
                       class="flex-c-m stext-101 cl0 size-107 bg3 bor2 hov-btn3 p-lr-15 trans-04 m-b-10">
                        Check Out
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>


<!-- Slider -->
<div class="container-fluid" style="padding: 0;width: 100%;">
    <section class="section-slide">
        <div class="wrap-slick1">
            <div class="slick1">
                <div class="item-slick1"
                     style="background-image: url(/images/Slider1.jpg);">
                    <div class="container">

                    </div>
                </div>

                <div class="item-slick1"
                     style="background-image: url(/images/Slider2.jpg);">
                    <div class="container">

                    </div>
                </div>

                <div class="item-slick1"
                     style="background-image: url(/images/Slider3.jpg);">
                    <div class="container">

                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
<br>
<!-- Product -->
<section class="bg0 p-t-23 p-b-140">
    <div class="container">
        <div class="p-b-10">
            <h3 class="ltext-103 cl5">
                ★ Figurium New Figure ★
            </h3>
        </div>

        <!-- 카테고리 -->
        <div class="flex-w flex-sb-m p-b-52">
            <div class="flex-w flex-l-m filter-tope-group m-tb-10">
                <button class="stext-106 " data-filter="*">
                    이달의 신상품
                </button>
            </div>





            <script>
                document.getElementById('filterSelect').addEventListener('change', function() {
                    var selectedValue = this.value;
                    console.log('선택된 값:', selectedValue);

                    // 선택된 값에 따라 필터링 로직 추가
                    // 예를 들어 AJAX 요청을 통해 필터링된 결과를 가져올 수 있습니다.
                });
            </script>


        </div>

        <!-- 상품(피규어) 조회 -->
        <div id="productsList" class="row isotope-grid">
            <!-- 초기 40개의 제품이 여기에 렌더링됩니다 -->
            <c:forEach var="products" items="${productsList}">

                <div class="col-sm-6 col-md-4 col-lg-3 p-b-35 isotope-item ${products.category.name}">
                    <!-- Block2 -->
                    <div class="block2">
                        <div class="block2-pic hov-img0">
                            <img src="${products.imageUrl}" alt="IMG-PRODUCT">
                            <a href="productInfo.do?id=${products.id}"
                               class="block2-btn flex-c-m stext-103 cl2 size-102 bg0 bor2 hov-btn1 p-lr-15 trans-04">
                                상품 상세
                            </a>
                        </div>
                        <div class="block2-txt flex-w flex-t p-t-14">
                            <div class="block2-txt-child1 flex-col-l ">
                                <a href="productInfo.do?id=${products.id}"
                                   class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
                                        ${products.name}
                                </a>
                                <span class="stext-105 cl3">
                        상품 가격 : ${products.price}￦
                    </span>
                                <span class="stext-105 cl3">
                                    <fmt:parseDate var="parsedDate" value="${products.createdAt}" pattern="yyyy-MM-dd"/>
                        상품 등록일 : <fmt:formatDate value="${parsedDate}" pattern="yyyy년 MM월 dd일"/>
                    </span>
                            </div>
                            <div class="block2-txt-child2 flex-r p-t-3">
                                <a href="#" class="btn-addwish-b2 dis-block pos-relative js-addwish-b2">
                                    <img class="icon-heart1 dis-block trans-04"
                                         src="/images/icons/icon-heart-01.png"
                                         alt="ICON">
                                    <img class="icon-heart2 dis-block trans-04 ab-t-l"
                                         src="/images/icons/icon-heart-02.png"
                                         alt="ICON">
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Load more -->
        <div class="laedMoreBtn" style="text-align: center">
            <input type="hidden" id="currentPage" value="0">
            <input type="hidden" id="pageSize" value="20">
            <button id="load-more-btn" class="btn btn-info">Load More</button>
        </div>
    </div>
</section>


<!-- Footer -->
<jsp:include page="common/footer.jsp"/>


<script>
    $(document).ready(function () {
        var lastCreatedAt = null; // 마지막 생성일자 저장
        var lastId = null; // 마지막 상품 ID 저장

        // Isotope 초기화
        var $container = $('#productsList').isotope({
            itemSelector: '.isotope-item',
            layoutMode: 'fitRows'
        });

        $('#load-more-btn').click(function () {
            $.ajax({
                url: '/load-more-products',
                method: 'GET',
                data: {
                    lastCreatedAt: lastCreatedAt,
                    lastId: lastId
                },
                success: function (response) {
                    const products = response.products; // API 응답에서 products 배열 추출

                    if (products.length === 0) {
                        $('#load-more-btn').hide(); // 더 이상 데이터가 없으면 버튼 숨김
                    } else {
                        let html = '';
                        products.forEach(function (product) {
                            // JavaScript에서 날짜 문자열을 Date 객체로 변환
                            var createdAt = new Date(product.createdAt);

                            // 날짜를 원하는 형식으로 포맷
                            var options = {year: 'numeric', month: 'long', day: 'numeric'};
                            var formattedDate = createdAt.toLocaleDateString('ko-KR', options);
                            console.log(formattedDate);
                            html += `
                            <div class='col-sm-6 col-md-4 col-lg-3 p-b-35 isotope-item \${product.category.name}' >
                                <div class="block2">
                                    <div class="block2-pic hov-img0">
                                        <img src="\${product.imageUrl}" alt="IMG-PRODUCT">
                                        <a href="productInfo.do?id=\${product.id}"
                                           class="block2-btn flex-c-m stext-103 cl2 size-102 bg0 bor2 hov-btn1 p-lr-15 trans-04">
                                            상품 상세
                                        </a>
                                    </div>
                                    <div class="block2-txt flex-w flex-t p-t-14">
                                        <div class="block2-txt-child1 flex-col-l">
                                            <a href="productInfo.do?id=\${products.id}" class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
                                                \${product.name}
                                            </a>
                                            <span class="stext-105 cl3">
                                                상품 가격 : \${product.price}￦
                                            </span>
                                            <span class="stext-105 cl3">
                                                상품 등록일 : \${formattedDate}
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>`;
                        });

                        // 새 아이템을 추가하고 Isotope 레이아웃을 업데이트합니다.
                        const $newItems = $(html);
                        $('#productsList').append($newItems).isotope('appended', $newItems);

                        // 마지막 생성일자 및 ID 업데이트
                        lastCreatedAt = new Date(products[products.length - 1].createdAt).toISOString();
                        lastId = products[products.length - 1].id;

                        // 다음 페이지가 없으면 버튼 숨김
                        if (!response.hasNext) {
                            $('#load-more-btn').hide();
                        }
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error loading products:', error);
                }
            });
        });
    });
</script>





</body>
</html>