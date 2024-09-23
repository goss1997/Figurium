<%@ page import="com.githrd.figurium.product.entity.Products, java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>주문/결제</title>
    <link rel="icon" type="image/png" href="/images/FiguriumHand.png"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="/css/orderForm.css">
  <%-- 자바스크립트 경로 --%>
  <script src="/js/orderForm.js"></script>

  <!-- SweetAlert2 -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

  <%-- 결제 API --%>
  <script src="https://code.jquery.com/jquery-latest.min.js"></script>
  <script type="text/javascript"	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
  <%-- 주소 API --%>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

  <style>

    .modal-backdrop {
      display: none; /* 배경을 아예 없애기 */
    }

    .modal-header {
      background: #9acfec;
    }

    /* 모달을 상단에 위치시키기 위한 스타일 */
    .modal-dialog {
      margin-top: 0; /* 상단 여백을 없앰 */
      position: absolute; /* 절대 위치 설정 */
      top: 5%; /* 상단에 고정 */
      left: 0%; /* 중앙 정렬을 위한 왼쪽 위치 */
      transform: translateX(-50%); /* 중앙 정렬 */
    }

    .btn-secondary, #snoozeButton {
      background: #9acfec !important;
      color: white;
      border: 0px !important;
    }

    .modal {
      z-index: 1000;
      margin-right: 500px !important;
      margin-top: 35px;
      width: 600px;  /* 너비 설정 */
      height: 900px; /* 높이 설정 */
    }

    .table {
      max-width: 1400px !important;
    }

    .order_box_l {
      width: 900px !important;
      margin-right: 100px !important;
    }

    #table_under_box {
      margin-right: 63px !important;
    }

    /* 반응형을 위한 미디어 쿼리 */
    @media (min-width: 768px) {

        #form {
            max-width: 100% !important;
            margin: auto;
        }

        #content_title {
            max-width: 1400px;
            margin: auto;
        }

        .text-103 > img {
            max-width: 100% !important;
        }

        .order_box_both {
            max-width: 100% !important;
        }
        .order_box_l {
            max-width: 100% !important;
        }
        .form_container {
            max-width: 100% !important;

        }
        .table {
            margin-left: 10px !important;
            max-width: 100% !important;
            min-width: 0% !important;
        }
        #table_under_box {
            max-width: 100% !important;
            margin: 0;
        }
        .table tr {
            max-width: 100% !important;
            overflow: auto !important;
        }

        .profile-header img {
            margin-right: 20px;
        }

        .item_list_table {
            max-width: 100% !important;
            margin: auto !important;
        }

    }

    @media (max-width: 768px) {

        #form {
            max-width: 100% !important;
            margin: auto;
        }

        .profile-header img {
            width: 100px;
            height: 100px;
        }
        .order_box_both {
            max-width: 100% !important;
            flex-direction: column;
        }
        .order_box_l {
            max-width: 100% !important;
        }

        #order_box {
            margin: auto !important;
        }

        .form_container {
            max-width: 100% !important;

        }
        .table {
            margin-left: 10px !important;
            max-width: 100% !important;
            min-width: 0% !important;
        }
        #table_under_box {
            max-width: 100% !important;
            margin: 0;
        }
        .table tr {
            max-width: 100% !important;
            overflow: auto !important;
        }

        .profile-header h2 {
            font-size: 18px;
        }

        .profile-header p {
            font-size: 14px;
        }

        .item_list_table {
            max-width: 100% !important;
            margin: auto !important;
        }
    }

    @media (max-width: 576px) {
        #form {
            max-width: 100% !important;
            margin: auto;
        }

        .item_list_table {
            overflow: auto !important;
        }

        .profile-header img {
            width: 80px;
            height: 80px;
        }
        .order_box_both {
            max-width: 100% !important;
            flex-direction: column;
        }
        .order_box_l {
            max-width: 100% !important;
        }

        #order_box {
            margin: auto !important;
        }

        .form_container {
            max-width: 100% !important;

        }

        .table {
            margin-left: 10px !important;
            max-width: 100% !important;
            min-width: 0% !important;
        }

        #table_under_box {
            max-width: 100% !important;
            margin: 0;
        }

        .table tr {
            max-width: 100% !important;
        }

        .total-container span{
            font-size: 13px;
        }
        .profile-header h2 {
            font-size: 16px;
        }

        .profile-header p {
            font-size: 12px;
        }

        .form-control {
            font-size: 14px;
        }


    }

    /* 모바일 화면에서 테이블을 스크롤 가능하게 설정 */
    .table-responsive {
      overflow-x: auto;
    }

    /* 테이블 이미지 크기 조정 */
    .table_content_img img {
      width: 50px; /* 이미지 크기 조정 */
      height: auto;
    }

    /* 작은 화면에서 텍스트 크기 조정 */
    @media (max-width: 768px) {
      .table_content_img_text {
        font-size: 12px; /* 텍스트 크기 조정 */
      }
      .table_content td {
        padding: 0.5rem; /* 패딩 조정 */
      }
    }
  </style>

  <script>

    $(function () {

      // 로그인 사용자 확인
      if (${empty loginUser}) {
        Swal.fire({
          icon: 'error',
          title: '로그인 필요',
          text: '로그인 후 이용 가능합니다.',
        }).then(() => {
          location.href = "/";
        });
      }
    });

      function check_name() {

        let order_name = $("#order_name").val();

        if(order_name.length==0) {
          $("#id_msg").html("");
          return;
        }

        if(order_name.length<2 || 5<order_name.length) {
          $("#id_msg").html("주문자명이 올바른 형식이 아닙니다.").css("color","red");
          return;
        } else {
          $("#id_msg").html("주문자명이 올바른 형식입니다.").css("color","blue");
          return;
        }

      }

      const phone_pattern = /^01\d{9}$/;
      function check_phone() {

        let order_phone = $("#order_phone").val();


        if(order_phone.length==0) {
          $("#phone_msg").html("");
          return;
        }

        if(phone_pattern.test(order_phone)) {
          $("#phone_msg").html("전화번호가 올바른 형식입니다.").css("color","blue");
          return;
        } else {
          $("#phone_msg").html("전화번호 형식이 올바르지 않습니다.").css("color","red");
          return;
        }

      }

      const email_pattern = /^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.(com|net)$/;
      function check_email() {

        let order_email = $("#order_email").val();

        if(order_email.length==0) {
          $("#email_msg").html("");
          return;
        }

        if(email_pattern.test(order_email)) {
          $("#email_msg").html("이메일이 올바른 형식입니다.").css("color","blue");
          return;
        } else {
          $("#email_msg").html("이메일 형식이 올바르지 않습니다.").css("color","red");
          return;
        }

      }

      function check_name2() {

        let shipping_name = $("#shipping_name").val();

        if(shipping_name.length==0) {
          $("#shipping_name_msg").html("");
          return;
        }

        if(shipping_name.length<2 || 5<shipping_name.length) {
          $("#shipping_name_msg").html("받는 사람이름이 올바른 형식이 아닙니다.").css("color","red");
          return;
        } else {
          $("#shipping_name_msg").html("받는 사람이름이 올바른 형식입니다.").css("color","blue");
          return;
        }

      }

      function check_phone2() {

        let shipping_phone = $("#shipping_phone").val();

        if(shipping_phone.length==0) {
          $("#shipping_phone_msg").html("");
          return;
        }

        if(phone_pattern.test(shipping_phone)) {
          $("#shipping_phone_msg").html("전화번호가 올바른 형식입니다.").css("color","blue");
          return;
        } else {
          $("#shipping_phone_msg").html("전화번호 형식이 올바르지 않습니다.").css("color","red");
          return;
        }

      }

    window.onload = function() {
      var fullAddress = "${sessionScope.loginUser.address}";
      var remainingAddress = fullAddress.split(", ");

      document.getElementById('shipping_address').value = fullAddress;
      document.getElementById('mem_zipcode1').value = remainingAddress[0].trim();
      document.getElementById('mem_zipcode2').value = remainingAddress[1].trim();
    }




  // 결제 api js 파일로 분리해놓으면 IMP 못읽어오는 현상이 있어서, 부득이하게 jsp 내부에 js 작성
  // 관리자 계정 정보 (결제 api 사용에 필요함)
  var IMP = window.IMP;
  IMP.init("imp25608413");

    const Toast = Swal.mixin({
      toast: true,
      position: 'center-center',
      showConfirmButton: false,
      timer: 3000,
      timerProgressBar: true,
      didOpen: (toast) => {
        toast.addEventListener('mouseenter', Swal.stopTimer)
        toast.addEventListener('mouseleave', Swal.resumeTimer)
      }
    })

  var merchantUid;

    function buyItems() {

      // 결제 주문자, 배송지 정보 유효한지 검증(Test시, 꺼놓는걸 추천)
      let order_name = $("#order_name").val();
      let order_phone = $("#order_phone").val();
      let order_email = $("#order_email").val();
      if(order_name == "" || order_phone == "" || order_email == "" || !phone_pattern.test(order_phone)
              || !email_pattern.test(order_email)) {
        Swal.fire({
          icon: 'error',
          title: '알림',
          text: '주문자 정보는 필수적으로 기입해야 합니다.',
          confirmButtonText: '확인'
        }); // 결제검증이 실패하면 이뤄지는 실패 로직
        return;
      }

      let shipping_name = $("#shipping_name").val();
      let shipping_phone = $("#shipping_phone").val();
      let mem_zipcode1 = $("#mem_zipcode1").val();
      let mem_zipcode2 = $("#mem_zipcode2").val();
      if(shipping_name == "" || shipping_phone == ""
              || mem_zipcode1 == "" || mem_zipcode2 == ""
              || !phone_pattern.test(shipping_phone)) {
        Swal.fire({
          icon: 'error',
          title: '알림',
          text: '배송지 정보는 필수적으로 기입해야 합니다.',
          confirmButtonText: '확인'
        }); // 결제검증이 실패하면 이뤄지는 실패 로직
        return;
      }
      // 결제 주문자, 배송지 정보 유효한지 검증(Test시, 꺼놓는걸 추천)





      // 만약에 결제 방식을 선택하지 않았다면, return되게 한다.
      let paymentType = $("input[name='payment']:checked").val();
      if (paymentType == null) {
        Swal.fire({
          icon: 'info',
          title: '알림',
          text: '결제방식을 선택하고 결제를 진행해주세요.',
          confirmButtonText: '확인'
        }); // 결제검증이 실패하면 이뤄지는 실패 로직
        return;
      }
      // 약관 동의 체크
      let agreementCheckbox = document.getElementById("agreement");
      if(!agreementCheckbox.checked) {
        Swal.fire({
          icon: 'info',
          title: '알림',
          text: '약관에 동의하여야 결제를 진행할 수 있습니다.',
          confirmButtonText: '확인'
        }); // 결제검증이 실패하면 이뤄지는 실패 로직
        return;
      }

      console.log(productIds);
      console.log(itemQuantities);

      $.ajax({
        type : "POST",
        url : "checkProduct.do",
        data : {
          productIds : productIds,
          itemQuantities : itemQuantities
        },
        success: function(res_data){
          if(res_data === "success") {
            Toast.fire({
              icon: 'success',
              title: '' +
                      '<img src="/images/흰둥이.png" alt="흰둥이" style="width: 200px; height: auto;">' +
                      '<br>주문이 정상적으로 요청되었습니다.'
            });
          } else if (res_data ==="error"){
            Toast.fire({
              icon: 'error',
              title: '' +
                      '<div style="text-align: center;">' +
                      '<img src="/images/재고부족.png" alt="재고부족" style="width: 200px; height: auto;">' +
                      '<br style="text-align: center">재고가 부족합니다.' +
                      '</div>'
            });
            return;

          } else if (res_data === "notSession") {
            Toast.fire({
              icon: 'error',
              title: '' +
                      '<div style="text-align: center;">' +
                      '<img src="/images/재고부족.png" alt="로그인 정보 없음" style="width: 200px; height: auto;">' +
                      '<br style="text-align: center">로그인 정보가 없으므로 전 페이지로 돌아갑니다.' +
                      '</div>'
            });
            setTimeout(function() {
              location.href ="/";
            }, 2500);
          }
          setTimeout(function () {

          IMP.request_pay({
            pg: 'kcp', // PG사 코드표에서 선택
            pay_method: paymentType, // 결제 방식
            merchant_uid: 'merchant_' + new Date().getTime(), // 결제 고유 번호
            name: '피규리움 결제창',   // 상품명
            // <c:set var="amount" value="${ totalPrice < 100000 ? totalPrice + 3000 : totalPrice}"/>
            amount: <c:out value="${amount}" />, // 가격
            //amount : 200,
            buyer_email: $("#order_email").val(),
            buyer_name: '피규리움 기술지원팀',
            buyer_tel: $("#order_phone").val(),
            buyer_addr: $("#mem_zipcode1").val() + $("#mem_zipcode2").val(),
            buyer_postcode: '123-456'
          }, function (rsp) { // callback
            console.log(rsp);


            // 결제검증
            $.ajax({
              type : "GET",
              url  : "../api/verifyIamport.do",
              data : {
                imp_uid : rsp.imp_uid,
                merchantUid : rsp.merchant_uid
              },
              success : function (res_data) {
                if (res_data.failReason == null) {
                    // Swal.fire({
                    //   icon: 'success',
                    //   title: '결제 성공',
                    //   text: '결제가 완료되었습니다.',
                    //   confirmButtonText: '확인'
                    // });
                    console.log(res_data);
                    merchantUid = rsp.merchant_uid;
                    sil();
                  } else if (res_data.failReason != null) {
                    // 결제 상태가 'paid'가 아닌 경우
                    Swal.fire({
                      icon: 'warning',
                      title: '결제 상태',
                      text: '결제 상태가 확인되지 않았습니다.',
                      confirmButtonText: '확인'
                    });
                    console.log(res_data);
                    return;
                  }
                },
                error : function (jqXHR) {
                  const errorMessage = jqXHR.responseJSON ? jqXHR.responseJSON.message : '결제에 실패했습니다. 관리자에게 문의해주세요.';
                  Swal.fire({
                    icon: 'error',
                    title: '결제 실패',
                    text: errorMessage,
                    confirmButtonText: '확인'
                  }); // 결제검증이 실패하면 이뤄지는 실패 로직
                  return;
                }
            });
          });
        }, 2500);
        },
      });
    }


    function sil() {

      let paymentType = $("input[name='payment']:checked").val();
      let userId = document.getElementById("order_id").value;    // 보낸 사람 id


      console.log(paymentType);

      //결제 완료된 주문 데이터 저장
      $.ajax({
        type : "POST",
        url  : "/order/inicisPay.do",
        data : {
          price: <c:out value="${totalPrice+3000}" />,
          //price: 200,
          paymentType: paymentType,
          userId: userId,
          merchantUid: merchantUid
        },

        success: function (res_data){
          insertInformation();
        },

        error: function(err){
          alert(err.responseText);
        }
      });

    }


    function insertInformation() {

      // 주문 리스트에 저장될 값들 전부 변수로 저장

      let loginUserId = document.getElementById("order_id").value;    // 보낸 사람 id
      let name = document.getElementById("order_name").value;         // 보낸 사람 이름
      let phone = document.getElementById("order_phone").value;       // 보낸 사람 전화번호
      let email = document.getElementById("order_email").value;       // 이메일


      // 받는 사람 주소
      let memZipcode1 = document.getElementById('mem_zipcode1').value;
      let memZipcode2 = document.getElementById('mem_zipcode2').value;

      let address = memZipcode1 + ' ' + memZipcode2;

      let recipientName = document.getElementById("shipping_name").value;         // 받는 사람 이름
      let shippingPhone = document.getElementById("shipping_phone").value;       // 받는 사람 주소
      let deliveryRequest = document.getElementById("delivery_request").value;   // 배송 요청 사항

      $.ajax({
        type : "POST",
        url : "insertInformation.do",
        data : {
          loginUserId : loginUserId,
          name : name,
          phone : phone,
          email : email,
          address : address,
          recipientName : recipientName,
          shippingPhone : shippingPhone,
          deliveryRequest : deliveryRequest,
          productIds : productIds,
          itemPrices : itemPrices,
          itemQuantities : itemQuantities
        },
        success: function(res_data){
          Toast.fire({
            icon: 'success',
            title: '주문이 정상적으로 처리되었습니다.'
          });
          // 2초 후에 페이지 이동
          setTimeout(function () {
            location.href="../user/order-list.do";
          }, 2500);
        },
        error: function(xhr){
          // 오류 발생 시
          try {
            const response = JSON.parse(xhr.responseText); // JSON 파싱
            if (response.message) {
              alert(response.message); // 메시지 표시
              // 어디로 가야 하오...
            } else {
              alert('알 수 없는 오류가 발생했습니다.');
            }
          } catch (e) {
            alert('응답 형식 오류가 발생했습니다.');
          }
        }
      });


    }

  </script>


</head>
<body class="animsition">
<jsp:include page="../common/header.jsp"/>
<div style="height: 90px"></div>

<div class="modal fade" id="alertModal" tabindex="-1" role="dialog" aria-labelledby="alertModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="alertModalLabel" style="color: white;">알림</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <img src="/images/주문결제창알림.png" width="100%">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-warning" id="snoozeButton">1일간 보지 않기</button>
      </div>
    </div>
  </div>
</div>

<script>
  $(document).ready(function() {
    // 로컬 스토리지에서 'modalDismissed' 값을 확인
    if (!localStorage.getItem('modalDismissed')) {
      setTimeout(function() {
        $('#alertModal').modal('show');
      }, 500); // 0.5초 후에 모달 표시
    }

    // '1일간 보지 않기' 버튼 클릭 시
    $('#snoozeButton').click(function() {
      // 로컬 스토리지에 'modalDismissed' 값을 설정 (1일 후 만료)
      localStorage.setItem('modalDismissed', 'true');
      $('#alertModal').modal('hide');
    });
  });
</script>


<%-- 구글 관리자 이메일로 보내는 로직 --%>




<%-- Content --%>

<div id="content_title">

  <div class="cart_list" style="margin: 20px;">
    <!-- breadcrumb -->
    <div class="container">
      <div class="bread-crumb flex-w p-l-25 p-r-15 p-t-30 p-lr-0-lg">
        <a href="../" class="stext-109 cl8 hov-cl1 trans-04">
          Home
          <i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
        </a>

        <a href="CartList.do?loginUser=${ loginUser.id }" class="stext-109 cl8 hov-cl1 trans-04">
          장바구니
          <i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
        </a>

        <span class="stext-109 cl4">
          주문/결제
        </span>
      </div>
    </div>
  </div>

  <div class="ltext-103 cl5" style="width: 100%; margin: auto;">
    <img src="/images/주문서.png" style="width: 100%;">
  </div>

<%-- 상단 아이템 주문 리스트 --%>
    <%--  장바구니 예시 테이블 : 0828 --%>
  <c:if test="${ cartsList == null }">
  <div class="item_list">
    <table class="table item_list_table table-hover">
      <thead id="thead">
      <tr class="table-light">
        <th class="item_list_table_name">상품명</th>
        <th>가격</th>
        <th>수량</th>
        <th>총 금액</th>
      </tr>
      </thead>
      <tbody>
      <tr class="table_content">
        <td class="table_content_img"><img src="/images/example.jpg" alt="IMG">
        [25년2월입고] 최애의 아이 2기 반프레스토 아쿠아 토우키ver
        </td>
        <td>10,000원</td>
        <td>1</td>
        <td>10,000원</td>
      </tr>
      </tbody>
    </table>
  </c:if>

    <%-- form 시작 지점 --%>
    <form id="form" style="width: 100%;">

    <%-- 만약에 장바구니에 담겼던 item 값이 넘어왔다면 list에 호출 : 0828 --%>
    <%-- itemNames라는 배열을 생성해서 for문안에 넣어 이름을 추가 --%>
    <c:if test="${ requestScope.cartsList != null }">
      <script type="text/javascript">

        let productIds = [];
        let itemPrices = [];
        let itemQuantities = [];

        <c:forEach var="item" items="${ requestScope.cartsList }">
        productIds.push("${ item.productId }");
        itemPrices.push("${ item.price }");
        itemQuantities.push("${ item.quantity }");
        </c:forEach>

      </script>

  <div class="container">
    <div class="table-responsive">
      <table class="table item_list_table" style="width: 100%">
          <thead>
          <tr class="table-light">
            <th class="item_list_table_name">상품명</th>
            <th>가격</th>
            <th>수량</th>
            <th>총 금액</th>
          </tr>
          </thead>

        <tbody>
        <c:forEach var="item" items="${ requestScope.cartsList }">
          <tr class="table_content">
            <td class="table_content_img"><img src="${ item.imageUrl }" alt="IMG">
              <span class="table_content_img_text">${ item.name }</span>
            </td>
            <td><fmt:formatNumber type="currency" value="${ item.price }" currencySymbol="₩"/>원</td>
            <td>${ item.quantity }</td>
            <td><fmt:formatNumber type="currency" value="${ item.price * item.quantity }" currencySymbol="₩"/>원</td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>
  </div>

    </c:if>



<%--    <c:if test="${ requestScope.cartsList.size() < 2 }">--%>
<%--      <script type="text/javascript">--%>
<%--        let productIds = ${ item.productId };--%>
<%--        let itemPrices = ${ item.price };--%>
<%--        let itemQuantities = ${ item.quantity };--%>
<%--      </script>--%>


<%--      <table class="table item_list_table">--%>
<%--        <thead>--%>
<%--        <tr class="table-light">--%>
<%--          <th class="item_list_table_name">상품명</th>--%>
<%--          <th>가격</th>--%>
<%--          <th>수량</th>--%>
<%--          <th>총 금액</th>--%>
<%--        </tr>--%>
<%--        </thead>--%>

<%--        <tbody>--%>
<%--          <tr class="table_content">--%>
<%--            <td class="table_content_img"><img src="${ cartsList.imageUrl }" alt="IMG">--%>
<%--              <span class="table_content_img_text">${ cartsList.name }</span>--%>
<%--            </td>--%>
<%--            <td><fmt:formatNumber type="currency" value="${ cartsList.price }" currencySymbol=""/>원</td>--%>
<%--            <td>${ cartsList.quantity }</td>--%>
<%--            <td><fmt:formatNumber type="currency" value="${ cartsList.price * cartsList.quantity }" currencySymbol=""/>원</td>--%>
<%--          </tr>--%>
<%--        </tbody>--%>
<%--      </table>--%>
<%--    </c:if>--%>



</div>



<div class="order_box_both">
  <input type="hidden" value="${ sessionScope.loginUser.id }" id="order_id">

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
        <td>
          <input type="text" class="form-control" value="${ sessionScope.loginUser.name }"
                   id="order_name" placeholder="주문하시는 분" name="order_name" onkeyup="check_name();">
          <span id="id_msg"></span>
        </td>
      </tr>
      <tr>
        <td class="td_title">전화번호</td>
        <td>
          <input type="text" class="form-control" value="${ sessionScope.loginUser.phone }"
                   id="order_phone" placeholder="전화번호" name="order_phone" onkeyup="check_phone();">
          <span id="phone_msg"></span>
        </td>
      </tr>
      <tr>
        <td class="td_title">이메일</td>
        <td><input type="email" class="form-control" value="${ sessionScope.loginUser.email }"
                   id="order_email" placeholder="이메일" name="order_email" onkeyup="check_email();">
          <span id="email_msg"></span>
        </td>
      </tr>
      </tbody>
    </table>
  </div>

  <div id="table_under_box">
    <span>회원정보가 변경되셨다면 다음 버튼을 누르고 수정해주세요.</span>
    <input type="button" class="form-control" onclick="location.href='/user/my-page.do'"
           id="user_change_btn" value="회원정보수정">
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
        <td class="td_title">기존 배송지</td>
        <td><input type="text" class="form-control" value="${ sessionScope.loginUser.address }"
                   id="shipping_address" placeholder="기본 배송지" name="shipping_address" readonly>
        </td>
      </tr>
      <tr>
        <td class="td_title">받으시는 분</td>
        <td><input type="text" class="form-control" value="${ sessionScope.loginUser.name }"
                   id="shipping_name" placeholder="받으시는 분" name="shipping_name" onkeyup="check_name2();">
          <span id="shipping_name_msg"></span>
        </td>
      </tr>
      <tr>
        <td class="td_title">전화번호</td>
        <td><input type="number" class="form-control" value="${ sessionScope.loginUser.phone }"
                   id="shipping_phone" placeholder="전화번호" name="shipping_phone" onkeyup="check_phone2();">
          <span id="shipping_phone_msg"></span>
        </td>
      </tr>


      <tr>
        <td class="td_title">주소</td>
        <td>
          <div class="address-container">
            <div class="address-inputs">
                <button id="a_search" type="button" onclick="find_addr();">주소 찾기</button>
            </div>
            <div class="zipcode-container">
                <input type="text" class="form-control addr_text" name="mem_zipcode" id="mem_zipcode1" placeholder="주소">
                <input type="text" class="form-control addr_text" name="mem_zipcode" id="mem_zipcode2" placeholder="상세주소">
            </div>
          </div>
        </td>
      </tr>


      <tr>
        <td class="td_title">배송시요청사항</td>
        <td>
          <textarea class="form-control" rows="5" id="delivery_request" placeholder="배송시 요청사항" placeholer="배송시 요청사항을 적어주세요."></textarea>
        </td>
        <%--<td><textarea class="form-control" id="delivery_request" placeholder="배송시 요청사항" name="delivery_request"></td>--%>
      </tr>
      </tbody>
    </table>
  </div>
</div>

  </form>
  <%-- form end 지점 --%>

  <div id="order_box">

      <div class="payment-title">결제 정보</div>

      <%-- 상품가격 + 배송비 계산 항목 : 0828 --%>
      <c:if test="${ cartsList == null }">
      <div class="payment-info">
        <span>상품 합계</span>
        <span class="payment-info-price">0원</span>
      </div>

      <div class="payment-info">
        <span>배송료</span>
        <span class="payment-info-price">(+)0원</span>
      </div>

      <div class="payment-info" id="payment-info-bottom">
        <span>총 결제 금액</span>
        <span class="payment-info-price-red">0원</span>
      </div>
    </c:if>

    <c:if test="${ cartsList != null }">
      <div class="payment-info">
        <span>상품 합계</span>
        <span class="payment-info-price">
          <fmt:formatNumber type="currency" value="${ totalPrice }" currencySymbol=""/>원
        </span>
      </div>

      <div class="payment-info">
        <span>배송료</span>
        <c:if test="${ totalPrice < 100000 }">
          <span class="payment-info-price">(+)3,000원</span>
        </c:if>
        <c:if test="${ totalPrice >= 100000 }">
          <span class="payment-info-price glowing-text">0원 (배송비 무료 이벤트 적용!)</span>
        </c:if>
      </div>

      <div class="payment-info" id="payment-info-bottom">
        <span>총 결제 금액</span>

        <span class="payment-info-price-red" name="totalPrice">
          <c:set var="finalValue" value="${ totalPrice < 100000 ? totalPrice + 3000 : totalPrice}"/>
          <fmt:formatNumber type="currency" value="${finalValue}" currencySymbol=""/>원
        </span>
      </div>
    </c:if>

    <hr id="hr1">

    <%--  결제 수단 정렬  --%>
    <div class="payment-method">
      <div class="payment-method-title">결제 수단</div>

      <div class="payment-option">
        <input type="radio" id="credit_card" name="payment" value="card" checked>
        <label for="credit_card">통합결제</label>
      </div>

      <div class="payment-option">
        <input type="radio" id="bank_transfer" name="payment" value="vbank">
        <label for="bank_transfer">무통장 입금</label>
      </div>


    </div>

    <hr id="hr2" style="margin-top: 30px;">

    <div class="agreement">
      <input type="checkbox" id="agreement">
      <p>결제 정보를 확인하였으며,<br>구매 진행에 동의합니다.</p>
    </div>

    <%--  결제버튼  --%>
    <button class="order-button" onclick="buyItems();">주문하기</button>

    <div class="info-section" style="display: flex; align-items: center; margin-top: 50px;">
      <img src="/images/신태일.png" alt="신태일.png" style="width: 100px; height: auto; margin-left: 20px;">
      <div>
        <h1 style="font-size: 24px; margin: 0; text-align: left">잠깐만요!</h1>
        <p style="padding-top: 10px;">피규리움에서는 10만원 이상 결제시, 택배비가 무료!</p>
        <p>택배비는 저희가 책임질게요!</p>
      </div>
    </div>

  </div>

</div>

<!-- NOTE : 푸터바 -->
<jsp:include page="../common/footer.jsp"/>


</body>
</html>