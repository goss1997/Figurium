<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<head>
    <title>상품 검색</title>
    <link rel="stylesheet" type="text/css" href="/css/searchAndCategoriesList.css">
    <style>
        .error-body {
            margin-top: 150px;
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            color: #333;
            text-align: center;
            padding: 50px;
        }

        .error-container {
            max-width: 1000px;
            min-height: 300px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .error-body h1 {
            color: #e74c3c;
        }

        .error-body a {
            color: #3498db;
            text-decoration: none;
        }

        .error-body a:hover {
            text-decoration: underline;
        }
    </style>

</head>
<%@ include file="../common/header.jsp" %>
<body>
<div style="height: 90px"></div>
<div id="content-wrap-area">

    <c:if test="${!not_search}">
        <div class="Search_title_box" style="text-align: center; margin-top: 100px">
            <h1>★ 검색결과 : ${search} ★</h1>
        </div>
    </c:if>



    <div class="categories_main_box">

    <c:if test="${not_search}">
        <div class="error-body">
            <div class="error-container">
                <img src="/images/훈이.png" alt="훈이.png" style="width: 200px; height: auto; margin-right: 20px;">
                <div>
                    <h2>검색 결과가 없습니다.</h2>
                    <p>죄송합니다. 현재 검색된 상품은 존재하지 않습니다.</p>
                    <p>다른 상품 검색을 해 주시거나, 아래의 링크를 통해 다른 페이지로 이동해 주세요.</p>
                    <a href="<c:url value='/' />">홈으로 돌아가기</a>
                </div>
            </div>
        </div>
    </c:if>



    <c:if test="${!not_search}">
    <div class="sort_box">
        <span>현재 검색된 상품의 수 <b>${totalCount}</b>개</span>
        <!-- Filter -->
        <div class="filter_box" style="display: inline-block">
        <form action="/searchProductsList.do" method="get">
            <input type="hidden" name="search" value="${search}">
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
                <c:forEach var="products" items="${productsSearchList}">
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
                                   ${products.name} ${products.quantity}
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
            <a href="?search=${search}&selectFilter=${selectFilter}&page=${prevPage}"
               class="pagination-button ${currentPage <= 5 ? 'disabled' : ''}">
               <<
            </a>

            <!-- 페이지 버튼들 -->
            <c:forEach var="i" begin="${startPage}" end="${endPage}">
                <a href="?search=${search}&selectFilter=${selectFilter}&page=${i}"
                   class="pagination-button ${i == currentPage ? 'active' : ''}">
                   ${i}
                </a>
            </c:forEach>

            <!-- 다음 버튼 -->
            <a href="?search=${search}&selectFilter=${selectFilter}&page=${nextPage}"
               class="pagination-button ${currentPage >= totalPages ? 'disabled' : ''}">
               >>
            </a>
        </div>
        </c:if>
    </div>

</div>
<jsp:include page="../common/footer.jsp"/>
</body>
</html>
