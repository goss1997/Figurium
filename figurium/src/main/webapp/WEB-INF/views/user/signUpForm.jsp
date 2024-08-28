
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 주소검색 API  -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <title>회원가입</title>
    <style>
        #content-wrap-area{
            height: 100%;
            margin-top: 30px;
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
    </style>
    <!-- bootstrap4 & jquery -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body>
<!-- NOTE : 메뉴바 -->
<jsp:include page="../common/header.jsp"/>

<div style="height: 90px"></div>
<div id="content-wrap-area">
    <form class="form-inline">
        <div id="box">
            <div class="panel panel-primary">
                <div class="panel-heading" style="text-align: center"><h2>회원가입</h2></div>
                <span style="text-align: left; font-size: 12px; color: #b4b2b2; margin-left: 10px;">* 는 필수 입력 사항입니다.</span>
                <br>
                <div class="panel-body">
                    <table class="table">
                        <tr>
                            <th>이메일*</th>
                            <td>
                                <input style="width:50%;"  class="form-control" type="text" name="email"  id="signup-email">
                                <input class="btn  btn-secondary"  type="button"  value="이메일확인" onclick="check_email();">
                                <span  id="check_email_msg"></span>
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
                                       onclick="location.href='../photo/list.do'" >
                                <input id="btn_register"  class="btn btn-secondary" type="button"  value="가입하기" disabled="disabled"
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

    function check_email() {

        let email = $("#signup-email").val();

        // 이메일 확인
        $.ajax({
            url		:	"check_email.do",
            data	:	{"email":email},
            dataType:	"json",
            success	:	function(res_data){
                if(res_data.isUsed){
                    $("#check_email_msg").html("이미 사용중인 이메일 입니다").css("color","red");

                }else{
                    $("#check_email_msg").html("사용가능한 이메일 입니다").css("color","blue");
                    return true;

                }
            },
            error	:	function(err){
                alert(err.responseText);
            }
        });
    }//end:check_id()


    function find_addr(){

        var themeObj = {
            bgColor: "#B51D1D" //바탕 배경색
        };

        new daum.Postcode({
            theme: themeObj,
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
                // 예제를 참고하여 다양한 활용법을 확인해 보세요.
                $("#addr").val(data.address);     //주소넣기

            }
        }).open();

    }//end:find_addr()


    function send(f){

        let name 	= f.name.value.trim();
        let password  	= f.password.value.trim();
        let address 	= f.address.value.trim() + $("#detail-address").val();

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


        if(address==''){
            alert("주소를 입력하세요");
            f.address.value="";
            f.address.focus();
            return;
        }

        f.action = "sing-up.do";  //MemberInsertAction
        f.submit(); //전송

    }//end:send()

</script>

<script src="${pageContext.request.contextPath}/resources/vendor/sweetalert/sweetalert.min.js"></script>
<!-- NOTE : 푸터바 -->
<jsp:include page="../common/footer.jsp"/>
</body>
</html>