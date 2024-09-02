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
<head>
    <title>MyPage</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/FiguriumHand.png"/>
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

    </style>

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
                            <li class="list-group-item"><a href="${pageContext.request.contextPath}/user/my-page.do">개인
                                정보 수정</a></li>
                            <li style="font-weight: bold; font-size: 16px;" class="list-group-item"><a
                                    href="${pageContext.request.contextPath}/user/order-list.do">내 주문 내역</a></li>
                            <li class="list-group-item"><a href="#">반품 내역</a></li>
                            <li class="list-group-item"><a href="#">1대1 문의</a></li>
                            <li class="list-group-item"><a style="color: red;" href="#">회원 탈퇴</a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div style="float: left; width: 80%; margin-left: 50px;">
                <div class="card">
                    <div style="width: 100%; min-height: 500px;" class="card-body">
                        <h5 class="card-title">주문 내역 조회</h5>
                        <br>
                        <table class="table table-hover order-table">
                            <thead style="background-color: #e8e6e6">
                                <th style="width: 12%">주문일자</th>
                                <th>상품명</th>
                                <th style="width: 14%">결제금액</th>
                                <th style="width: 18%">주문상태</th>
                            </thead>
                            <tbody>
                            <c:if test="${ empty myOrdersList}"><tr><td colspan="4">주문 내역이 없습니다.</td></tr></c:if>
                            <c:if test="${ not empty myOrdersList}">
                                <c:forEach var="myOrder" items="${myOrdersList}">
                                    <tr onclick="alert('상세조회(${myOrder.orderId})')">
                                        <fmt:parseDate var="parsedDate" value="${myOrder.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" />
                                        <td><fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd"/></td>
                                        <td>
                                            <img src="${myOrder.imageUrl}" width="15%;"/>
                                            <span style="margin-left: 10px;">${myOrder.productName} 외 ${myOrder.remainCount}</span>
                                        </td>
                                        <td>${myOrder.price}</td>
                                        <td>${myOrder.status}</td>
                                    </tr>
                                </c:forEach>

                            </c:if>
                            </tbody>
                        </table>
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