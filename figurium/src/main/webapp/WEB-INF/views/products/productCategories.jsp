<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>카테고리 별 조회</title>
    <link rel="stylesheet" type="text/css" href="/css/searchAndCategoriesList.css">
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
            max-height: 550px;
        }
    </style>
</head>
<%@ include file="../common/header.jsp" %>
<body>
<div style="height: 90px"></div>
<div id="content-wrap-area">
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

<div class="categories_main_box">
    <div class="categories_title_box" style="text-align: center; margin-top: 100px">
        <h1>★ ${categoryName} ★</h1>
    </div>

    <div class="sort_box">
        <span>현재 조회된 상품의 수 <b>${totalCount}</b>개</span>
        <!-- Filter -->
        <div class="filter_box" style="display: inline-block">
        <form action="/productList.do" method="get">
        <input type="hidden" name="name" value="${categoryName}">
            <select class="select_filter" name="selectFilter" onchange="this.form.submit()">
                <option value="newProducts" ${selectFilter == 'newProducts' ? 'selected' : ''}>신상품</option>
                <option value="bestProducts" ${selectFilter == 'bestProducts' ? 'selected' : ''}>추천★상품</option>
                <option value="highPrice" ${selectFilter == 'highPrice' ? 'selected' : ''}>높은 가격순</option>
                <option value="lowPrice" ${selectFilter == 'lowPrice' ? 'selected' : ''}>낮은 가격순</option>
            </select>
        </form>
        </div>
    </div>
    <!-- 상품(피규어) 조회 -->
        <div id="productsList" class="row isotope-grid">
                <c:forEach var="products" items="${productCategoriesList}">
                <div class="col-sm-6 col-md-4 col-lg-3 p-b-35 isotope-item" style="margin-top: 30px;">
                    <!-- Block2 -->
                    <div class="block2">
                        <div class="block2-pic hov-img0" style="border: 1px solid #dcdcdc">
                            <img src="${products.imageUrl}" alt="IMG-PRODUCT">
                            <img src="/images/soldout1.png" alt="Sold Out" class="sold-out-overlay" style="${products.quantity == 0 ? 'display: block;' : 'display: none;'}">

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
                                    <fmt:parseDate var="parsedDate" value="${products.createdAt}" pattern="yyyy-MM-dd"/>
                        상품 등록일 : <fmt:formatDate value="${parsedDate}" pattern="yyyy년 MM월 dd일"/>
                    </span>
                    <span class="stext-105 cl3">
                        카테고리 : ${products.categoryName}
                    </span>
                    <span class="stext-105 cl3">
                        상품 가격 : ${products.price}￦
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
        <div class="pagination">
            <!-- 이전 버튼 -->
            <a href="?name=${categoryName}&selectFilter=${selectFilter}&page=${prevPage}"
               class="pagination-button ${currentPage <= 5 ? 'disabled' : ''}">
               <<
            </a>

            <!-- 페이지 버튼들 -->
            <c:forEach var="i" begin="${startPage}" end="${endPage}">
                <a href="?name=${categoryName}&selectFilter=${selectFilter}&page=${i}"
                   class="pagination-button ${i == currentPage ? 'active' : ''}">
                   ${i}
                </a>
            </c:forEach>

            <!-- 다음 버튼 -->
            <a href="?name=${categoryName}&selectFilter=${selectFilter}&page=${nextPage}"
               class="pagination-button ${currentPage >= totalPages ? 'disabled' : ''}">
               >>
            </a>
        </div>

</div>






</div>
<jsp:include page="../common/footer.jsp"/>
</body>
</html>
