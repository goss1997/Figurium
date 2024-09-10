<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>카테고리 별 조회</title>
</head>
<%@ include file="../common/header.jsp" %>
<body>
<div style="height: 90px"></div>
<div id="content-wrap-area">
    <div class="categories_title" style="margin-left: 100px; margin-top: 30px">
        <a href="../" class="stext-109 cl8 hov-cl1 trans-04">
            Home
            <i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
        </a>

        <span class="stext-109 cl4">
                카테고리
        </span>
    </div>


    <!-- Filter -->
            <div class="filter_box">
                <select class="select_filter" name="mySelect">
                    <option>::최신상품::</option>
                    <option value="recommendProducts">추천 상품</option>
                    <option value="highPrice">높은 가격순</option>
                    <option value="lowPrice">낮은 가격순</option>
                </select>
            </div>

</div>
<jsp:include page="../common/footer.jsp"/>
</body>
</html>
