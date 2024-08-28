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