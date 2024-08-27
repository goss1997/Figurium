// var mem_name = "${sessionScope.user.mem_name}";

var IMP = window.IMP;
IMP.init("imp25608413");

//
function buy_items(mem_point) {

    IMP.request_pay({
        pg: 'html5_inicis',
        pay_method: 'vbank',
        merchant_uid: 'merchant_' + new Date().getTime(),
        name: '피규리움 결제창',
        amount: mem_point,
        buyer_email: "",
        buyer_name: mem_point
    }, function(rsp) {
        console.log(rsp);

        // 결제 성공 시
        if(rsp.success) {
            var msg = "결제가 완료되었습니다.";

            $.ajax({
                type : "GET",
                url : "inicis_pay.do",
                data : {
                    mem_point : mem_point,
                    mem_name : mem_name
                },
                success: function(res_data){
                    location.href="list.do";
                },
                error: function(err){
                    alert(err.responseText);
                }
            });
        }else {
            var msg = "결제에 실패했습니다.";
            msg += '에러내용 : ' + rsp.error_msg;
        }
        alert(msg);
    });
};



// 주소 api 함수
function find_addr(){

    var themeObj = {
        bgColor: "#B51D1D" //바탕 배경색
    };

    new daum.Postcode({
        theme: themeObj,
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분
            $("#address").val(data.zonecode);		// 우편번호 넣기
            $("#mem_zipcode1").val(data.address);			// 주소 넣기
        }
    }).open();

}// end: find_addr()