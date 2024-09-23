



// 주소 api 함수
function find_addr(){

    var themeObj = {
        bgColor: "#349fef" //바탕 배경색
    };

    new daum.Postcode({
        theme: themeObj,
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분
            $("#mem_zipcode1").val(data.address);			// 주소 넣기
        }
    }).open();

}// end: find_addr()