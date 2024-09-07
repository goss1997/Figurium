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

        .how-itemcart1:hover:after {
            opacity: 0 !important;
        }

        .column-5 {
            width: 100px !important;
            padding-right: 0px !important;
            text-align: center;
            font-size: 16px;
        }

        .table_row > td {
            font-size: 14px !important;
            font-family: 'Pretendard-Regular';
        }

        #bankTransferModal {
            margin-top: 200px;
        }

        .modal-dialog {
            max-width: 500px;
            margin: 1.75rem auto;
        }

        .modal-content {
            border: none;
            border-radius: 18px;
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            background-color: #f9f9f9;
        }

        .modal-header {
            background-color: #3182f6;
            color: white;
            border-bottom: none;
            padding: 20px 24px;
            align-items: center;
        }

        .modal-title {
            font-size: 18px;
            font-weight: bold;
            margin: 0;
        }

        .close {
            color: white;
            opacity: 1;
            font-size: 24px;
            padding: 0;
            margin: -1rem -1rem -1rem auto;
        }

        .modal-body {
            margin: auto;
            text-align: center;
            padding: 24px;
        }

        .row {
            display: flex;
            align-items: flex-start;
        }

        .col-md-3 img {
            width: 100%;
            max-width: 80px;
            margin-right: 20px;
        }

        .col-md-8 {
            margin: auto;
        }

        .col-md-8 h4 {
            color: #0062fa;
            font-size: 38px;
            margin-bottom: 16px;
            font-weight: bold;
        }

        .bank-info {
            background-color: #ffffff;
            border-radius: 12px;
            padding: 16px;
            margin-bottom: 16px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }

        .bank-info h5 {
            color: #3182f6;
            font-size: 15px;
            font-weight: bold;
            margin: 0;
        }

        .info-text p {
            color: #4e5968;
            font-size: 16px;
            font-weight: 500;
            margin-bottom: 8px;
            line-height: 1.5;
        }

        @media (max-width: 576px) {
            .modal-dialog {
                margin: 1rem;
            }

            .row {
                flex-direction: column;
            }

            .col-md-3 img {
                max-width: 60px;
                margin-bottom: 16px;
            }
        }

        #productVbank {
            font-weight: bold;
            color: #0083d7;
            animation: fade 1s infinite alternate;
        }

        @keyframes fade {
            0% {
                opacity: 1; /* 진하게 */
            }
            100% {
                opacity: 0.5; /* 옅어지게 */
            }
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
                            <li class="list-group-item"><a href="/user/myProductLikeList.do">관심 상품</a></li>
                            <li style="font-weight: bold; font-size: 16px;" class="list-group-item"><a
                                    href="/user/order-list.do">내 주문 내역</a></li>
                            <li class="list-group-item"><a href="#">반품 내역</a></li>
                            <li class="list-group-item"><a style="color: red;" href="/user/deleteForm.do">회원 탈퇴</a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div style="float: left; width: 80%; margin-left: 50px;">
                <!-- 주문내역 리스트 -->
                <div class="bg0 p-t-75 p-b-85">

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
                        <c:forEach var="myOrder" items="${ requestScope.myOrdersList }">
                        <div class="container">
                            <div class="row">
                                <div class="col-lg-11 col-xl-11 m-lr-auto m-b-50">
                                    <div class="m-l-25 m-r--38 m-lr-0-xl">
                                        <div class="wrap-table-shopping-cart">
                                            <table class="table-shopping-cart">

                                                <!-- th -->
                                                <tr class="table_head">
                                                    <th class="column-1" style="text-align: center; width: 5%;">상품</th>
                                                    <th class="column-2" style="width: 40%;">상품명</th>
                                                    <th class="column-3">결제금액</th>
                                                    <th class="column-4" style="text-align: center; width: 8%">결제타입</th>
                                                    <th class="column-5" style="text-align: center; width: 15%">결제일자</th>
                                                    <th class="column-6" style="text-align: center; width: 10%">
                                                        <c:if test="${ myOrder.valid == 'y' }">
                                                            배송상황
                                                        </c:if>
                                                        <c:if test="${ myOrder.valid == 'n' }">
                                                            주문상태
                                                        </c:if>
                                                        </th>


                                                </tr>



                                                <!-- td -->

                                                    <tr class="table_row" style="height: 100px;">
                                                        <td class="column-1" style="padding-bottom: 0px;" >
                                                            <div class="how-itemcart1" onclick="location.href='../refund.do?id=${ myOrder.id }'">
                                                                <img src="${ myOrder.imageUrl }"
                                                                     alt="${ myOrder.id }" style="text-align: left;">
                                                            </div>

                                                        </td>
                                                        <c:if test="${ myOrder.productCount <= 0 }">
                                                            <td class="column-2" style="padding-bottom: 0px;">
                                                                <a href="orderDetail.do?myOrderId=${ myOrder.id }">
                                                                    ${ myOrder.productName }
                                                                </a>
                                                            </td>

                                                        </c:if>

                                                        <c:if test="${ myOrder.productCount > 0 }">
                                                            <td class="column-2" style="padding-bottom: 0px;">
                                                                <a href="orderDetail.do?myOrderId=${ myOrder.id }">
                                                                        ${ myOrder.productName } 외 ${ myOrder.productCount }개
                                                                </a>
                                                            </td>

                                                        </c:if>

                                                        <td class="column-3" style="padding-bottom: 0px;">
                                                            <span class="productPrice">
                                                                <c:set var="finalValue"
                                                                       value="${ myOrder.totalValue < 100000 ? myOrder.totalValue + 3000 : myOrder.totalValue }"/>
                                                                <fmt:formatNumber type="currency" value="${finalValue}" currencySymbol=""/>원
                                                            </span>
                                                        </td>
                                                        <td class="column-4" style="text-align: center; padding-bottom: 0px">
                                                            <c:if test="${ myOrder.paymentType != 'vbank' }">
                                                            <span class="productPrice">${ myOrder.paymentType }</span>
                                                            </c:if>
                                                            <c:if test="${ myOrder.paymentType == 'vbank' }">
                                                            <span class="productPrice" id="productVbank" data-toggle="modal" data-target="#bankTransferModal" style="cursor: pointer;">
                                                                무통장입금
                                                            </span>
                                                            </c:if>
                                                        </td>
                                                        <td class="column-5" style="text-align: center; padding-bottom: 0px">
                                                            <span class="productPrice">${ myOrder.createdAt }</span>
                                                        </td>
                                                        <td class="column-6" style="text-align: center; padding-bottom: 0px">
                                                            <c:if test="${ myOrder.valid == 'y' }">
                                                                <span class="productPrice">${ myOrder.status }</span>
                                                            </c:if>
                                                            <c:if test="${ myOrder.valid == 'n' }">
                                                                <span class="productPrice">환불완료</span>
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                            </table>
                                        </div>
                                        <c:if test="${ myOrder.paymentType == 'vbank' }">
                                        <div style="text-align: right; font-size: 0.8em; color: gray; margin-top: 10px;">
                                            무통장입금을 누르시면, 입금계좌를 확인하실 수 있습니다.
                                        </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>

                            <!-- 모달 -->
                            <div class="modal fade" id="bankTransferModal" tabindex="-1" aria-labelledby="bankTransferModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-lg">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="bankTransferModalLabel">무통장입금 안내</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <img src="/images/신태일.png" alt="신태일.png" class="img-fluid">
                                                </div>
                                                <div class="col-md-8">
                                                    <h4>무통장 거래 입금안내</h4>
                                                    <div class="bank-info mt-3">
                                                        <h5>937702-00-363467 국민은행 피규리움</h5>
                                                    </div>
                                                    <div class="info-text mt-3">
                                                        <p>관리자의 입금처리가 순차적으로 진행됩니다.</p>
                                                        <p>승인까지 다소 시간이 소요될 수 있습니다.</p>
                                                        <p>입금자명과 주문자명이 동일해야 정상적인 입금처리가 됨을 알려드립니다.</p>
                                                    </div>
                                                </div>
                                            </div>
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

                            <hr id="list-hr2">
                            </c:forEach>


                        </div>
                    </div>
                </div>

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