<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>상품등록</title>
    <link rel="stylesheet" type="text/css" href="../../../resources/css/productInsert.css">
</head>
<jsp:include page="../common/header.jsp"/>
<body>
<div style="height: 90px"></div>



    <div class="info_title">
        <div class="bread-crumb flex-w p-l-25 p-r-15 p-t-30 p-lr-0-lg">
            <a href="../" class="stext-109 cl8 hov-cl1 trans-04">
                Home
                <i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
            </a>

            <span class="stext-109 cl4">
                상품등록
            </span>
        </div>
    </div>

    <div style="min-height: 600px;">
        <form>
            <!-- 상품에 대한 상세 이미지, 이름 등 넣을 곳 -->
            <div class="product_title">
                <div class="product_img_box">
                    <!-- 상품의 이미지가 들어 갈 곳 -->
                    <div class="product_img">
                        <img src="${pageContext.request.contextPath}/resources/images/noImage1.png">
                    </div>

                </div>

                <!-- 상품의 이름이나 가격 결제 금액 등 들어 갈 곳 -->

                <div class="product_info">

                    <table class="info_table">
                        <tr>
                            <th>사진 :</th>
                            <td><input type="file" class="form-control form-control-sm" name="productImage" onclick="insertImage();"></td>
                        </tr>
                        <tr>
                            <th>상품명 :</th>
                            <td><input class="form-control form-control" name="product_name"></td>
                        </tr>
                        <tr>
                            <th>가격 :</th>
                            <td><input class="form-control form-control" name="product_price"></td>
                        </tr>
                        <hr>
                        <tr>
                            <th>제조사 :</th>
                            <td >
                                    <select class="form-control form-control" id="sel1" name="sellist1"
                                    style="margin: 0px;">
                                        <c:forEach var="categori" items="${categoriesList}">
                                        <option>${categori.name}</option>
                                        </c:forEach>
                                    </select>
                            </td>
                        </tr>


                        <tr>
                            <th>재고</th>
                            <td>
                                <input type="text" class="form-control form-control" PLACEHOLDER="재고 수량 입력">
                            </td>
                        </tr>
                    </table>

                    <hr>

                    <div class="product_cancel">
                        <input class="product_cancel_btn" type="button" value="취소">
                        <input class="product_insert_btn" type="button" value="등록">
                    </div>

                </div>

            </div>
        </form>
    </div>

    <jsp:include page="../common/footer.jsp"/>
</body>

<script>

    function insertImage(){

        
    }
</script>

</html>