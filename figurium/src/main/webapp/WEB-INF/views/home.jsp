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
                <button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5 how-active1" data-filter="*">
                    전체상품
                </button>

                <c:forEach var="categori" items="${categoriesList}">
                    <button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter=".${categori.name}">
                            ${categori.name}
                    </button>
                </c:forEach>
            </div>


            <!-- Filter button -->
            <div class="flex-w flex-c-m m-tb-10">
                <div class="flex-c-m stext-106 cl6 size-104 bor4 pointer hov-btn3 trans-04 m-r-8 m-tb-4 js-show-filter">
                    <i class="icon-filter cl2 m-r-6 fs-15 trans-04 zmdi zmdi-filter-list"></i>
                    <i class="icon-close-filter cl2 m-r-6 fs-15 trans-04 zmdi zmdi-close dis-none"></i>
                    Filter
                </div>
            </div>

            <!-- Filter -->
            <div class="dis-none panel-filter w-full p-t-10">
                <div class="wrap-filter flex-w bg6 w-full p-lr-40 p-t-27 p-lr-15-sm">
                    <div class="filter-col1 p-r-15 p-b-27">
                        <div class="mtext-102 cl2 p-b-15">
                            Sort By
                        </div>

                        <ul>
                            <li class="p-b-6">
                                <a href="#" class="filter-link stext-106 trans-04">
                                    Default
                                </a>
                            </li>

                            <li class="p-b-6">
                                <a href="#" class="filter-link stext-106 trans-04">
                                    Popularity
                                </a>
                            </li>

                            <li class="p-b-6">
                                <a href="#" class="filter-link stext-106 trans-04">
                                    Average rating
                                </a>
                            </li>

                            <li class="p-b-6">
                                <a href="#" class="filter-link stext-106 trans-04 filter-link-active">
                                    Newness
                                </a>
                            </li>

                            <li class="p-b-6">
                                <a href="#" class="filter-link stext-106 trans-04">
                                    Price: Low to High
                                </a>
                            </li>

                            <li class="p-b-6">
                                <a href="#" class="filter-link stext-106 trans-04">
                                    Price: High to Low
                                </a>
                            </li>
                        </ul>
                    </div>

                    <div class="filter-col2 p-r-15 p-b-27">
                        <div class="mtext-102 cl2 p-b-15">
                            Price
                        </div>

                        <ul>
                            <li class="p-b-6">
                                <a href="#" class="filter-link stext-106 trans-04 filter-link-active">
                                    All
                                </a>
                            </li>

                            <li class="p-b-6">
                                <a href="#" class="filter-link stext-106 trans-04">
                                    $0.00 - $50.00
                                </a>
                            </li>

                            <li class="p-b-6">
                                <a href="#" class="filter-link stext-106 trans-04">
                                    $50.00 - $100.00
                                </a>
                            </li>

                            <li class="p-b-6">
                                <a href="#" class="filter-link stext-106 trans-04">
                                    $100.00 - $150.00
                                </a>
                            </li>

                            <li class="p-b-6">
                                <a href="#" class="filter-link stext-106 trans-04">
                                    $150.00 - $200.00
                                </a>
                            </li>

                            <li class="p-b-6">
                                <a href="#" class="filter-link stext-106 trans-04">
                                    $200.00+
                                </a>
                            </li>
                        </ul>
                    </div>

                    <div class="filter-col3 p-r-15 p-b-27">
                        <div class="mtext-102 cl2 p-b-15">
                            Color
                        </div>

                        <ul>
                            <li class="p-b-6">
									<span class="fs-15 lh-12 m-r-6" style="color: #222;">
										<i class="zmdi zmdi-circle"></i>
									</span>

                                <a href="#" class="filter-link stext-106 trans-04">
                                    Black
                                </a>
                            </li>

                            <li class="p-b-6">
									<span class="fs-15 lh-12 m-r-6" style="color: #4272d7;">
										<i class="zmdi zmdi-circle"></i>
									</span>

                                <a href="#" class="filter-link stext-106 trans-04 filter-link-active">
                                    Blue
                                </a>
                            </li>

                            <li class="p-b-6">
									<span class="fs-15 lh-12 m-r-6" style="color: #b3b3b3;">
										<i class="zmdi zmdi-circle"></i>
									</span>

                                <a href="#" class="filter-link stext-106 trans-04">
                                    Grey
                                </a>
                            </li>

                            <li class="p-b-6">
									<span class="fs-15 lh-12 m-r-6" style="color: #00ad5f;">
										<i class="zmdi zmdi-circle"></i>
									</span>

                                <a href="#" class="filter-link stext-106 trans-04">
                                    Green
                                </a>
                            </li>

                            <li class="p-b-6">
									<span class="fs-15 lh-12 m-r-6" style="color: #fa4251;">
										<i class="zmdi zmdi-circle"></i>
									</span>

                                <a href="#" class="filter-link stext-106 trans-04">
                                    Red
                                </a>
                            </li>

                            <li class="p-b-6">
									<span class="fs-15 lh-12 m-r-6" style="color: #aaa;">
										<i class="zmdi zmdi-circle-o"></i>
									</span>

                                <a href="#" class="filter-link stext-106 trans-04">
                                    White
                                </a>
                            </li>
                        </ul>
                    </div>

                    <div class="filter-col4 p-b-27">
                        <div class="mtext-102 cl2 p-b-15">
                            Tags
                        </div>

                        <div class="flex-w p-t-4 m-r--5">
                            <a href="#"
                               class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">
                                Fashion
                            </a>

                            <a href="#"
                               class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">
                                Lifestyle
                            </a>

                            <a href="#"
                               class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">
                                Denim
                            </a>

                            <a href="#"
                               class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">
                                Streetstyle
                            </a>

                            <a href="#"
                               class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">
                                Crafts
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 상품(피규어) 조회 -->
        <div id="productsList" class="row isotope-grid">
            <!-- 초기 40개의 제품이 여기에 렌더링됩니다 -->
            <c:forEach var="products" items="${requestScope.productsList}">

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