<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>회원 탈퇴</title>
    <link rel="icon" type="image/png" href="/images/FiguriumHand.png"/>
    <style>
        @font-face {
            font-family: 'Pretendard-Regular';
            src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
            font-weight: 400;
            font-style: normal;
        }

        body {
            background-color: #f8f9fa;
            font-family: Pretendard-Regular !important;
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
        <div style="display: inline-block;">
            <img src="${loginUser.profileImgUrl}" alt="Profile Picture">
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
                            <li class="list-group-item"><a href="/user/my-page.do">개인 정보 수정</a></li>
                            <li class="list-group-item"><a href="/user/myProductLikeList.do">관심 상품</a></li>
                            <li class="list-group-item"><a href="/user/order-list.do">주문 내역</a></li>
                            <li class="list-group-item"><a href="#">반품 내역</a></li>
                            <li style="font-weight: bold; font-size: 16px;" class="list-group-item"><a
                                    style="color: red;" href="/user/deleteForm.do">회원 탈퇴</a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div style="float: left; width: 80%; margin-left: 50px;">
                <div class="card">
                    <div style="width: 80%; margin: auto;">
                        <br>
                        <h2 class="card-title">회원 탈퇴</h2>
                        <br>
                        <c:if test="${loginUser.password != null}">
                        <div class="form-group">
                            <div style="font-size: 13px; color: #878787;">* 회원 탈퇴를 진행하시면 소중한 회원님의 연동된 소셜 계정 정보도 함께
                                삭제됩니다.
                            </div>
                            <div style="font-size: 13px; color: #878787;">* 개인 및 활동 정보는 1개월 이후 자동 삭제됩니다.</div>
                        </div>
                        <div class="form-group">
                            <label style="font-weight: bold;" for="userPwd">비밀번호를 입력해주세요!</label>
                            <input style="width: 400px;" type="password" class="form-control" id="userPwd"
                                   name="userPwd" required>
                        </div>
                        <button type="button" class="btn btn-secondary" onclick="deleteByUserPwd();">탈퇴</button>
                        <br>
                        <br>
                        </c:if>
                        <c:if test="${loginUser.password == null}">
                            <form action="deleteSocial.do" method="post">
                                <div class="form-group">
                                    <div style="font-size: 13px; color: #878787;">* 회원 탈퇴를 진행하시면 소중한 계정 정보도 함께
                                        삭제됩니다.
                                    </div>
                                </div>
                                <button type="button" class="btn btn-secondary" onclick="deleteSocialAccount();">탈퇴</button>
                                <br><br>
                            </form>
                        </c:if>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <script>
        $(function () {
            if (${empty loginUser}) {
                alert('로그인 후 이용 가능합니다.');
                location.href = "/";
            }
        });

        // 회원 탈퇴
        function deleteByUserPwd() {

            let userPwd = $("#userPwd").val().trim();

            // 비밀번호를 입력하지 않았을 경우
            if (userPwd === '') {
                alert("비밀번호를 입력해주세요!");
                return;
            }

            $.ajax({
                url : "delete.do",
                method : "POST",
                data : {"password" : userPwd},
                success : function (res) {
                    alert(res);
                    location.href = "/";
                },
                error : function (error) {
                    alert(error.responseText);  // 서버에서 전송한 에러 메시지를 alert로 출력
                }
            });

        }

        function deleteSocialAccount() {
            $.ajax({
                url : "deleteSocial.do",
                method : "POST",
                success : function (res) {
                    alert(res);
                    location.href = "/";
                },
                error : function (error) {
                    alert(error.responseText);  // 서버에서 전송한 에러 메시지를 alert로 출력
                }
            });
        }

    </script>

</div>
<!-- NOTE : 푸터바 -->
<jsp:include page="../common/footer.jsp"/>
</body>
</html>
