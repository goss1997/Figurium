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
    <title>개인 정보 수정</title>
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
            color : black;
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
                            <li style="font-weight: bold; font-size: 16px;" class="list-group-item"><a href="/user/my-page.do">개인 정보 수정</a></li>
                            <li class="list-group-item"><a href="/user/order-list.do">내 주문 내역</a></li>
                            <li class="list-group-item"><a href="#">반품 내역</a></li>
                            <li class="list-group-item"><a style="color: red;" href="/user/deleteForm.do">회원 탈퇴</a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div style="float: left; width: 80%; margin-left: 50px;">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">개인 정보 수정</h5>
                    </div>
                    <div style="width: 80%; margin: auto;">
                        <form method="post" action="update.do">
                            <div class="form-group">
                                <label for="name">Name</label>
                                <input type="text" class="form-control" id="name" name="name" value="${user.name}" minlength="3" required>
                            </div>
                            <div class="form-group">
                                <label for="phone">Phone Number</label>
                                <input type="tel" class="form-control" id="phone" name="phone" value="${user.phone}" maxlength="15" required>
                            </div>
                            <div class="form-group">
                                <label for="address">Address</label>
                                <input type="text" class="form-control" id="address" name="address" value="${user.address}" required>
                            </div>
                            <button type="submit" class="btn btn-secondary">Save Changes</button>
                        </form>
                        <br>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <script>
        $(function () {
            if(${empty loginUser}) {
                alert('로그인 후 이용 가능합니다.');
                location.href = "/";
            }
        });
    </script>

<script>
    function updateProfileImage(input) {
        const file = input.files[0];

        // 파일이 잘 가져왔으면
        if(file) {
            var formData = new FormData();
            formData.append('file',file);

            $.ajax({
                url : "update-profile-image.do",
                type : 'POST',
                processData: false, // 필수: jQuery가 데이터를 처리하지 않도록 설정
                contentType: false, // 필수: contentType을 false로 설정하여 jQuery가 자동으로 처리하지 않도록 설정
                data : formData,
                success : function () {
                    location.reload();
                },
                error : function (error) {
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
