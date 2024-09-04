<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%--
  Created by IntelliJ IDEA.
  User: 14A
  Date: 2024-08-26
  Time: 오후 4:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<link rel="stylesheet" type="text/css" href="/css/carts.css">
<head>
    <title>MyPage</title>
    <link rel="icon" type="image/png" href="/images/FiguriumHand.png"/>
    <script src="/js/orderForm.js"></script>
    <link rel="stylesheet" href="/css/orderForm.css">
    <style>
        body {
            background-color: #f8f9fa;
        }

        .profile-header {
            background-color: #343a40;
            color: white;
            padding: 20px;
            text-align: center;
        }

        .profile-header img {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            margin-bottom: 15px;
        }

        .card {
            margin-bottom: 20px;
        }

        /* 기본 input[type="file"] 숨기기 */
        input[type="file"] {
            display: none;
        }

        /* 커스텀 파일 업로드 버튼 스타일 */
        .custom-file-upload {
            width: 70px;
            display: inline-block;
            padding: 5px 10px;
            cursor: pointer;
            background-color: #b4b2b2;
            color: black;
            border-radius: 5px;
        }

        .order_box_both {
            margin-top: 0px;
        }

        .custom-file-upload:hover {
            background-color: #6d6e6f;
        }

        .backbtn {
            margin-top: -75px;
        }

        .list-group-item a {
            color: black;
        }

        .order-table {
            font-size: 15px;
            text-align: center;
            margin: auto;
        }

        .order-table td {
            text-align: center;
            vertical-align: middle;
            height: 100px;
        }

        #list-hr1 {
            margin-top: -30px;
        }

        #list-hr2 {
            margin-bottom: 70px;
        }

        .bread-crumb {
            margin-left: -20px;
        }

        .table_content_img {
            width: 400px !important;
            text-align: left !important;
            font-weight: 100 !important;
            display: flex;
            align-items: center;
            padding: 10px;
        }

        .table_content_img > img {
            width: 90px !important;
        }

        .table-shopping-cart .column-1 {
            width: 133px;
            padding-left: 0px !important;
        }

        .column-5 {
            padding-right: 0px !important;
        }

        .td_content {
            vertical-align: middle !important
        }

        #order_box_detail {
            width: 500px;
            min-height: 800px; /* 최소 높이 설정 */
            background: #f8f8f8;
            border-radius: 5px;

            margin-top: 50px;
            margin-bottom: 150px;
            padding: 30px; /* 내부 여백 */
        }

        .how-itemcart1:hover:after {
            opacity: 0 !important;
        }


    </style>

</head>

<body>
<!-- NOTE : 메뉴바 -->
<jsp:include page="../common/header.jsp"/>
<div style="height: 90px"></div>
<div id="content-wrap-area">

    <!-- Profile Header -->
    <div class="profile-header">
        <div style="display: inline-block; margin-left: 70px;">
            <img src="${loginUser.profileImgUrl}" alt="Profile Picture">
        </div>
        <div style="display:inline-block; width: 50px; margin-left: 10px;">
            <label for="profileImage" class="custom-file-upload">수정</label>
            <input type="file" id="profileImage" name="profileImage" onchange="updateProfileImage(this)"/>
        </div>
        <h2>${loginUser.name}</h2>
        <p>${loginUser.email}</p>
    </div>
    <br><br>

    <div class="container mt-4">
        <div class="row">
            <!-- Sidebar -->
            <div style="margin-left: -150px;" class="col-md-3">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">My Page</h5>
                        <ul class="list-group">
                            <li class="list-group-item"><a href="/user/my-page.do">개인
                                정보 수정</a></li>
                            <li style="font-weight: bold; font-size: 16px;" class="list-group-item"><a
                                    href="/user/order-list.do">내 주문 내역</a></li>
                            <li class="list-group-item"><a href="#">반품 내역</a></li>
                            <li class="list-group-item"><a style="color: red;" href="#">회원 탈퇴</a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div style="float: left; width: 80%; margin-left: 50px;">
                <!-- 주문내역 리스트 -->
                <div class="bg0 p-t-75 p-b-85" style="padding-bottom: 0px">

                    <div class="cart_list" style="margin-left: -50px;">
                        <!-- breadcrumb -->
                        <div class="container">
                            <div class="bread-crumb flex-w p-l-25 p-r-15 p-t-30 p-lr-0-lg backbtn">
                                <a href="../" class="stext-109 cl8 hov-cl1 trans-04">
                                    Home
                                    <i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
                                </a>

                                <span class="stext-109 cl4">
                                    주문내역
                                </span>
                            </div>
                        </div>
                    </div>

                    <div style="width: 1300px; margin-left: -160px">
                        <h1>주문내역</h1>
                        <c:forEach var="myOrder" items="${ requestScope.myOrderDetailList }">
                        <div class="container">
                            <div class="row">
                                <div class="col-lg-11 col-xl-11 m-lr-auto m-b-50">
                                    <div class="m-l-25 m-r--38 m-lr-0-xl">
                                        <div class="wrap-table-shopping-cart">
                                            <table class="table-shopping-cart">

                                                <!-- th -->
                                                <tr class="table_head">
                                                    <th class="column-1" style="text-align: center; width: 40%;">상품</th>
                                                    <th class="column-2" style="width: 7%;">수량</th>
                                                    <th class="column-3" style="width: 10%;">가격</th>
                                                    <th class="column-4" style="text-align: center;">총금액</th>
                                                    <th class="column-5" style="text-align: center; width: 8%;">결제방식</th>
                                                    <th class="column-6" style="text-align: center; ">결제일자</th>
                                                </tr>



                                                <!-- td -->

                                                <tr class="table_row" style="height: 100px;">
                                                    <td class="column-1" style="padding-bottom: 0px;" >
                                                        <div class="how-itemcart1 table_content_img">
                                                            <img src="${ myOrder.imageUrl }"
                                                                 alt="${ myOrder.id }" style="text-align: left">
                                                            <span>${ myOrder.productName }</span>
                                                        </div>

                                                    </td>
                                                        <td class="column-2" style="padding-bottom: 0px;">
                                                            ${ myOrder.quantity }
                                                        </td>


                                                    <td class="column-3" style="padding-bottom: 0px;">
                                                        <span class="productPrice">${ myOrder.price }원</span>
                                                    </td>
                                                    <td class="column-4" style="text-align: center; padding-bottom: 0px">
                                                        <span class="productPrice">${ myOrder.price * myOrder.quantity }원</span>
                                                    </td>
                                                    <td class="column-5" style="text-align: center; padding-bottom: 0px">
                                                        <span class="productPrice">${ myOrder.paymentType }</span>
                                                    </td>
                                                    <td class="column-6" style="text-align: center; padding-bottom: 0px">
                                                        <span class="productPrice">${ myOrder.createdAt }</span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>


                            <hr id="list-hr1">

                            <div class="total-container">
                                <div class="item">
                                    <span class="label">총상품금액</span>
                                    <span class="amount" id="totalAmount">
                                        <fmt:formatNumber type="currency" value="${ myOrder.totalValue }" currencySymbol=""/>원
                                    </span>
                                </div>
                                <div class="item">
                                    <span class="label">+</span>
                                </div>
                                <div class="item">
                                    <span class="label">총배송비</span>
                                    <span class="amount">3,000원</span>
                                </div>
                                <div class="item">
                                    <span class="label">=</span>
                                </div>
                                <div class="item total">
                                    <span class="label">TOTAL</span>
                                    <span class="amount highlight">
                                        <fmt:formatNumber type="currency" value="${ myOrder.totalValue+3000 }" currencySymbol=""/>원
                                    </span>
                                    <span class="extra">FIGU</span>
                                </div>
                            </div>

                            <hr id="list-hr2" style="margin-bottom: 0px">
                            </c:forEach>


                        </div>
                    </div>
                </div>



            </div>
        </div>

        <div class="order_box_both">
            <input type="hidden" value="${ myOrderInfo.id }" id="order_id">

            <%-- 주문 테이블 customers --%>
            <div class="order_box_l mt-3">
                <div class="form_container">
                    <table class="table">
                        <thead>
                        <th>
                            <h2>주문자 입력</h2>
                        </th>
                        </thead>
                        <tbody>
                        <tr>
                            <td class="td_title">주문하시는 분</td>
                            <td class="td_content">
                                <span class="order_name">
                                ${ myOrderInfo.name }
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_title">전화번호</td>
                            <td class="td_content">
                                <span class="order_name">
                                    ${ myOrderInfo.customerPhone }
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_title">이메일</td>
                            <td class="td_content">
                                <span class="order_name">
                                    ${ myOrderInfo.email }
                                </span>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>

                <div id="table_under_box">
                    <span>회원정보가 변경되셨다면 다음 버튼을 누르고 수정해주세요.</span>
                    <input type="button" class="form-control" id="user_change_btn" value="회원정보수정">
                </div>

                <%-- 주문 테이블 shipping_address --%>
                <div class="form_container">
                    <table class="table">
                        <thead>
                        <th>
                            <h2>배송지 정보</h2>
                        </th>
                        </thead>
                        <tbody>
                        <tr>
                            <td class="td_title">받으시는 분</td>
                            <td class="td_content">
                                <span class="order_name">
                                    ${ myOrderInfo.recipientName }
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_title">전화번호</td>
                            <td class="td_content">
                                <span class="order_name">
                                    ${ myOrderInfo.phone }
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_title">주소</td>
                            <td class="td_content">
                                <span class="order_name">
                                    ${ myOrderInfo.address }
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_title">배송시 요청 사항</td>
                            <td class="td_content">
                                <span class="order_name">
                                    ${ myOrderInfo.deliveryRequest }
                                </span>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            </form>
            <%-- form end 지점 --%>

            <div id="order_box_detail">

                <div class="payment-title">결제 정보</div>

                <%-- 상품가격 + 배송비 계산 항목 : 0828 --%>
                    <div class="payment-info">
                        <span>상품 합계</span>
                        <span class="payment-info-price">${ myOrderInfo.totalValue }원</span>
                    </div>

                    <div class="payment-info">
                        <span>배송료</span>
                        <span class="payment-info-price">(+)3,000원</span>
                    </div>

                    <div class="payment-info" id="payment-info-bottom">
                        <span>총 결제 금액</span>
                        <span class="payment-info-price-red">${ myOrderInfo.totalValue + 3000 }원</span>
                    </div>


                <hr id="hr1">

                <button class="order-button" onclick="">주문문의</button>
                <button class="order-button" onclick="">주문변경</button>
                <button class="order-button" onclick="">취소/환불신청</button>
                <button class="order-button" onclick="">반품신청</button>

            </div>

        </div>
    </div>






    <script>
        function updateProfileImage(input) {
            const file = input.files[0];

            // 파일이 잘 가져왔으면
            if (file) {
                var formData = new FormData();
                formData.append('file', file);

                $.ajax({
                    url: "update-profile-image.do",
                    type: 'POST',
                    processData: false, // 필수: jQuery가 데이터를 처리하지 않도록 설정
                    contentType: false, // 필수: contentType을 false로 설정하여 jQuery가 자동으로 처리하지 않도록 설정
                    data: formData,
                    success: function () {
                        location.reload();
                    },
                    error: function (error) {
                        alert(error.responseText);
                    }

                })

            }
        }
    </script>


</div>
<!-- NOTE : 푸터바 -->
<jsp:include page="../common/footer.jsp"/>
</body>
</html>