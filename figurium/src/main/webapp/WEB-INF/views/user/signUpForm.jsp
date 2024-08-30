<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/FiguriumHand.png"/>
    <!-- 주소검색 API  -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <title>회원가입</title>
    <style>
        #content-wrap-area{
            margin-top: 30px;
            margin-bottom: 30px;
        }

        #box{
            width: 800px;
            margin: 50px auto auto;

        }

        th{
            vertical-align: middle !important;
            text-align: right;
            font-size: 18px;
        }

        #id_msg{
            display: inline-block;
            width: 300px;
            height: 20px;
            margin-left: 10px;
            /*  border : 1px solid red; */
        }
        .preview-img {
            width: 150px;
            height: 150px;
            display: block;
            margin: 10px auto;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #ddd;
        }
    </style>
    <!-- bootstrap4 & jquery -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function previewImage(input) {
            const file = input.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    document.getElementById('preview').src = e.target.result;
                }
                reader.readAsDataURL(file);
            }
        }
    </script>

</head>

<body>
<!-- NOTE : 메뉴바 -->
<jsp:include page="../common/header.jsp"/>

<div style="height: 90px"></div>
<div id="content-wrap-area">
    <form class="form-inline" enctype="multipart/form-data">
        <div id="box">
            <div class="panel panel-primary">
                <div class="panel-heading" style="text-align: center; margin-bottom: 20px;"><h2>회원가입</h2></div>
                    <div style="margin-bottom: 10px;">
                        <span style="text-align: left; font-weight: bold; font-size: 13px; color: #b4b2b2; margin-left: 10px;">* 는 필수 입력 사항입니다.</span> <br>
                        <span style="text-align: left; font-size: 13px; color: #b4b2b2; margin-left: 10px;">휴대폰 번호와 주소를 입력하시면 주문을 원활하게 진행하실 수 있습니다.</span>
                    </div>
                <div class="card" style="width: 50%;">
                    <div class="card-body">
                        <h4 class="card-title text-center">프로필 이미지 업로드</h4>
                        <img id="preview" class="preview-img" src="#" alt="이미지 미리보기" style="display:none;">
                    </div>
                        <label for="image" style="width: 30%;" class="btn btn-primary btn-block">
                            이미지 선택
                            <input type="file" name="profileImage" id="image" accept="image/*" onchange="previewImage(this)" style="display:none;" required>
                        </label>
                    <script>
                        document.getElementById('image').addEventListener('change', function() {
                            document.getElementById('preview').style.display = 'block';
                        });
                    </script>
                </div>
                <hr>
                <div class="panel-body">
                    <table class="table">
                        <tr>
                            <th>이메일*</th>
                            <td>
                                <input style="width:50%;"  class="form-control" type="text" name="email"  id="signup-email">
                                <input class="btn  btn-secondary"  type="button"  value="중복 확인" onclick="check_email();">
                                <span style="font-size: 13px;"  id="check_email_msg"></span>
                            </td>
                        </tr>

                        <tr>
                            <th>비밀번호*</th>
                            <td><input style="width:50%;" class="form-control"  type="password" name="password"></td>
                        </tr>

                        <tr>
                            <th>이름*</th>
                            <td><input style="width:50%;" class="form-control" name="name"></td>
                        </tr>

                        <tr>
                            <th>휴대폰 번호</th>
                            <td><input style="width:50%;" class="form-control" name="phone"></td>
                        </tr>

                        <tr>
                            <th>주소</th>
                            <td>
                                <input style="width:70%;" class="form-control" name="address" id="address">
                                <input class="btn  btn-secondary"  type="button"  value="주소검색"  onclick="find_addr();">
                            </td>
                        </tr>

                        <tr>
                            <th>상세 주소</th>
                            <td><input style="width:70%;"  class="form-control" id="detail-address"></td>
                        </tr>

                        <tr>
                            <td colspan="2" align="center">
                                <input class="btn btn-secondary" type="button"  value="홈으로"
                                       onclick="location.href='/'" >
                                <input id="btn_register"  class="btn btn-secondary" type="button"  value="가입하기"
                                       onclick="send(this.form);" >
                            </td>
                        </tr>

                    </table>
                </div>
            </div>
        </div>
    </form>
</div>

<script>
    $(function () {
        if(${not empty user}) {
            alert('메인페이지로 이동합니다.');
            location.href = "/";
        }
    });
</script>

<script>

    // 이메일 중복 체크
    function check_email() {

        let email = $("#signup-email").val().trim();

        if(email == ''){
            alert('이메일을 입력해주세요');
            $("#signup-email").focus();
            return;
        }

        // header.jsp에 있는 이메일 유효성 체크 함수
        if(!emailCheck(email)) {
            alert('유효하지 않은 이메일 주소입니다.\n 다시 입력해주세요!');
            $("#signup-email").focus();
            return;
        }

        // 이메일 확인
        $.ajax({11
            url		:	"check_email.do",
            data	:	{"email":email},
            dataType:	"json",
            success	:	function(res_data){
                if(res_data.isUsed){
                    $("#check_email_msg").html("이미 사용중입니다").css("color","red");

                }else{
                    if(confirm('사용가능한 이메일입니다. \n 사용하시겠습니까?')) {
                        $("#signup-email").attr('readonly',true);
                        $("#check_email_msg").html("사용가능").css("color","blue");
                    }
                }
            },
            error	:	function(err){
                alert(err.responseText);
                return false;
            }
        });
    }//end:check_id()

    // 주소 api
    function find_addr(){

        var themeObj = {
            bgColor: "#B51D1D" //바탕 배경색
        };

        new daum.Postcode({
            theme: themeObj,
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
                // 예제를 참고하여 다양한 활용법을 확인해 보세요.
                $("#address").val(data.address);     //주소넣기

            }
        }).open();

    }//end:find_addr()


    function send(f){
        let email = f.email.value.trim();
        let name 	= f.name.value.trim();
        let password  	= f.password.value.trim();
        let address = f.address.value.trim() + " , " + $("#detail-address").val();

        if(email==''){
            alert("이메일을 입력하세요");
            f.email.value="";
            f.email.focus();
            return;
        }

        let isReadonly = $("#signup-email").attr("readonly") !== undefined;

        // 이메일 확인 안 한 경우
        if(!isReadonly) {
            alert('이메일을 다시 확인해주세요!');
            f.email.focus();
            return;
        }

        if(name==''){
            alert("이름을 입력하세요");
            f.name.value="";
            f.name.focus();
            return;
        }

        if(password==''){
            alert("비밀번호를 입력하세요");
            f.password.value="";
            f.password.focus();
            return;
        }

        // 주소 합치기
        if(f.address.value != '') {
            f.address.value = address;

        }

        f.action = "sign-up.do";
        f.method = 'post'
        f.submit(); //전송

    }//end:send()

</script>

<script src="${pageContext.request.contextPath}/resources/vendor/sweetalert/sweetalert.min.js"></script>
<!-- NOTE : 푸터바 -->
<jsp:include page="../common/footer.jsp"/>
</body>
</html>