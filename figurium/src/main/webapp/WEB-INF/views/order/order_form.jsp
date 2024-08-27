<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>장바구니</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/order_form.css">
  <jsp:include page="../common/header.jsp"/>
</head>
<body class="animsition">

<!-- Header -->
<header class="header-v4">
  <!-- Header desktop -->
  <div class="container-menu-desktop">
    <!-- Topbar -->
    <div class="top-bar">
      <div class="content-topbar flex-sb-m h-full container">
        <div class="left-top-bar">
          Free shipping for standard order over $100
        </div>

        <div class="right-top-bar flex-w h-full">
          <a href="#" class="flex-c-m trans-04 p-lr-25">
            Help & FAQs
          </a>

          <a href="#" class="flex-c-m trans-04 p-lr-25">
            My Account
          </a>

          <a href="#" class="flex-c-m trans-04 p-lr-25">
            EN
          </a>

          <a href="#" class="flex-c-m trans-04 p-lr-25">
            USD
          </a>
        </div>
      </div>
    </div>

    <div class="wrap-menu-desktop how-shadow1">
      <nav class="limiter-menu-desktop container">

        <!-- Logo desktop -->
        <a href="#" class="logo">
          <img src="${pageContext.request.contextPath}/resources/images/icons/logo-01.png" alt="IMG-LOGO">
        </a>

        <!-- Menu desktop -->
        <div class="menu-desktop">
          <ul class="main-menu">
            <li>
              <a href="../">Home</a>
            </li>

            <li>
              <a href="product.html">Shop</a>
            </li>

            <li class="label1" data-label1="hot">
              <a href="shopingCart.do">Features</a>
            </li>

            <li>
              <a href="blog.html">Blog</a>
            </li>

            <li>
              <a href="about.html">About</a>
            </li>

            <li>
              <a href="contact.html">Contact</a>
            </li>
          </ul>
        </div>

        <!-- Icon header -->
        <div class="wrap-icon-header flex-w flex-r-m">
          <div class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 js-show-modal-search">
            <i class="zmdi zmdi-search"></i>
          </div>

          <div class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 icon-header-noti js-show-cart" data-notify="2">
            <i class="zmdi zmdi-shopping-cart"></i>
          </div>

          <a href="#" class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 icon-header-noti" data-notify="0">
            <i class="zmdi zmdi-favorite-outline"></i>
          </a>
        </div>
      </nav>
    </div>
  </div>

  <!-- Header Mobile -->
  <div class="wrap-header-mobile">
    <!-- Logo moblie -->
    <div class="logo-mobile">
      <a href="../"><img src="${pageContext.request.contextPath}/resources/images/icons/logo-01.png" alt="IMG-LOGO"></a>
    </div>

    <!-- Icon header -->
    <div class="wrap-icon-header flex-w flex-r-m m-r-15">
      <div class="icon-header-item cl2 hov-cl1 trans-04 p-r-11 js-show-modal-search">
        <i class="zmdi zmdi-search"></i>
      </div>

      <div class="icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti js-show-cart" data-notify="2">
        <i class="zmdi zmdi-shopping-cart"></i>
      </div>

      <a href="#" class="dis-block icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti" data-notify="0">
        <i class="zmdi zmdi-favorite-outline"></i>
      </a>
    </div>

    <!-- Button show menu -->
    <div class="btn-show-menu-mobile hamburger hamburger--squeeze">
				<span class="hamburger-box">
					<span class="hamburger-inner"></span>
				</span>
    </div>
  </div>


  <!-- Menu Mobile -->
  <div class="menu-mobile">
    <ul class="topbar-mobile">
      <li>
        <div class="left-top-bar">
          Free shipping for standard order over $100
        </div>
      </li>

      <li>
        <div class="right-top-bar flex-w h-full">
          <a href="#" class="flex-c-m p-lr-10 trans-04">
            Help & FAQs
          </a>

          <a href="#" class="flex-c-m p-lr-10 trans-04">
            My Account
          </a>

          <a href="#" class="flex-c-m p-lr-10 trans-04">
            EN
          </a>

          <a href="#" class="flex-c-m p-lr-10 trans-04">
            USD
          </a>
        </div>
      </li>
    </ul>

    <ul class="main-menu-m">
      <li>
        <a href="../">Home</a>
        <span class="arrow-main-menu-m">
						<i class="fa fa-angle-right" aria-hidden="true"></i>
					</span>
      </li>

      <li>
        <a href="product.html">Shop</a>
      </li>

      <li>
        <a href="shopingCart.do" class="label1 rs1" data-label1="hot">Features</a>
      </li>

      <li>
        <a href="blog.html">Blog</a>
      </li>

      <li>
        <a href="about.html">About</a>
      </li>

      <li>
        <a href="contact.html">Contact</a>
      </li>
    </ul>
  </div>

  <!-- 모달 검색 -->
  <div class="modal-search-header flex-c-m trans-04 js-hide-modal-search">
    <div class="container-search-header">
      <button class="flex-c-m btn-hide-modal-search trans-04 js-hide-modal-search">
        <img src="${pageContext.request.contextPath}/resources/images/icons/icon-close2.png" alt="CLOSE">
      </button>

      <form class="wrap-search-header flex-w p-l-15">
        <button class="flex-c-m trans-04">
          <i class="zmdi zmdi-search"></i>
        </button>
        <input class="plh3" type="text" name="search" placeholder="Search...">
      </form>
    </div>
  </div>
</header>









<%-- Content --%>

<div id="content_title">
  <h1>주문서</h1>

<%-- 상단 아이템 주문 리스트 --%>
  <div class="item_list">
    <table class="table item_list_table table-hover">
      <thead>
      <tr class="table-active">
        <th id="item_list_table_name">상품명</th>
        <th>가격</th>
        <th>수량</th>
        <th>총 금액</th>
      </tr>
      </thead>
      <tbody>
      <tr class="table_content">
        <td id="table_content_img"><img src="${pageContext.request.contextPath}/resources/images/example.jpg" alt="IMG">
        [25년2월입고] 최애의 아이 2기 반프레스토 아쿠아 토우키ver
        </td>
        <td>10,000원</td>
        <td>1</td>
        <td>10,000원</td>
      </tr>
      </tbody>
    </table>



</div>



<div class="order_box_both">


<div class="order_box_l mt-3">
  <div class="form_container">
    <table class="table table-hover">
      <thead>
      <th>
        <h2>주문자 입력</h2>
      </th>
      </thead>
      <tbody>
      <tr>
        <td class="td_title">주문하시는 분</td>
        <td><input type="text" class="form-control" id="order_name" placeholder="주문하시는 분" name="order_name"></td>
      </tr>
      <tr>
        <td class="td_title">전화번호</td>
        <td><input type="text" class="form-control" id="order_phone" placeholder="전화번호" name="order_phone"></td>
      </tr>
      <tr>
        <td class="td_title">이메일</td>
        <td><input type="email" class="form-control" id="order_email" placeholder="이메일" name="order_email"></td>
      </tr>
      </tbody>
    </table>
  </div>

  <div class="form_container">
    <table class="table table-hover">
      <thead>
      <th>
        <h2>배송지 정보</h2>
      </th>
      </thead>
      <tbody>
      <tr>
        <td class="td_title">기존 배송지</td>
        <td><input type="text" class="form-control" id="order_name" placeholder="주문하시는 분" name="order_name"></td>
      </tr>
      <tr>
        <td class="td_title">받으시는 분</td>
        <td><input type="text" class="form-control" id="order_phone" placeholder="전화번호" name="order_phone"></td>
      </tr>
      <tr>
        <td class="td_title">전화번호</td>
        <td><input type="email" class="form-control" id="order_email" placeholder="이메일" name="order_email"></td>
      </tr>
      <tr>
        <td class="td_title">주소</td>
        <td><input type="text" class="form-control" id="address" placeholder="주소" name="address"></td>
      </tr>
      <tr>
        <td class="td_title">배송시요청사항</td>
        <td><input type="text" class="form-control" id="delivery_request" placeholder="배송시 요청사항" name="delivery_request"></td>
      </tr>
      </tbody>
    </table>
  </div>
</div>

  <div id="order_box">

      <div class="payment-title">결제 정보</div>

      <div class="payment-info">
        <span>상품 합계</span>
        <span class="payment-info-price">10,000원</span>
      </div>

      <div class="payment-info">
        <span>배송료</span>
        <span class="payment-info-price">(+)3,000원</span>
      </div>

      <div class="payment-info" id="payment-info-bottom">
        <span>총 결제 금액</span>
        <span class="payment-info-price-red">13,000원</span>
      </div>

    <hr id="hr1">


    <div class="payment-method">
      <div class="payment-method-title">결제 수단</div>

      <div class="payment-option">
        <input type="radio" id="paynow" name="payment" value="paynow">
        <label for="paynow">Paynow</label>
      </div>

      <div class="payment-option">
        <input type="radio" id="credit_card" name="payment" value="credit_card">
        <label for="credit_card">신용카드</label>
      </div>

      <div class="payment-option">
        <input type="radio" id="bank_transfer" name="payment" value="bank_transfer">
        <label for="bank_transfer">실시간 계좌이체</label>
      </div>

      <div class="payment-option">
        <input type="radio" id="virtual_account" name="payment" value="bank_transfer">
        <label for="bank_transfer">에스크로 가상계좌</label>
      </div>

      <div class="payment-option">
        <input type="radio" id="depositor" name="payment" value="bank_transfer">
        <label for="bank_transfer">무통장 입금</label>
      </div>

      <div class="payment-option">
        <input type="radio" id="phone_transfer" name="payment" value="bank_transfer">
        <label for="bank_transfer">휴대폰 결제</label>
      </div>

    </div>

    <hr id="hr2">

    <div class="agreement">
      <input type="checkbox" id="agreement" name="agreement">
      <label for="agreement">결제 정보를 확인하였으며, 구매 진행에 동의합니다.</label>
    </div>

    <button class="order-button">주문하기</button>

  </div>

</div>



















<!-- Footer -->
<footer class="bg3 p-t-75 p-b-32">
  <div class="container">
    <div class="row">
      <div class="col-sm-6 col-lg-3 p-b-50">
        <h4 class="stext-301 cl0 p-b-30">
          카테고리
        </h4>

        <ul>
          <li class="p-b-10">
            <a href="#" class="stext-107 cl7 hov-cl1 trans-04">
              Women
            </a>
          </li>

          <li class="p-b-10">
            <a href="#" class="stext-107 cl7 hov-cl1 trans-04">
              Men
            </a>
          </li>

          <li class="p-b-10">
            <a href="#" class="stext-107 cl7 hov-cl1 trans-04">
              Shoes
            </a>
          </li>

          <li class="p-b-10">
            <a href="#" class="stext-107 cl7 hov-cl1 trans-04">
              Watches
            </a>
          </li>
        </ul>
      </div>

      <div class="col-sm-6 col-lg-3 p-b-50">
        <h4 class="stext-301 cl0 p-b-30">
          Help
        </h4>

        <ul>
          <li class="p-b-10">
            <a href="#" class="stext-107 cl7 hov-cl1 trans-04">
              Track Order
            </a>
          </li>

          <li class="p-b-10">
            <a href="#" class="stext-107 cl7 hov-cl1 trans-04">
              Returns
            </a>
          </li>

          <li class="p-b-10">
            <a href="#" class="stext-107 cl7 hov-cl1 trans-04">
              Shipping
            </a>
          </li>

          <li class="p-b-10">
            <a href="#" class="stext-107 cl7 hov-cl1 trans-04">
              FAQs
            </a>
          </li>
        </ul>
      </div>

      <div class="col-sm-6 col-lg-3 p-b-50">
        <h4 class="stext-301 cl0 p-b-30">
          GET IN TOUCH
        </h4>

        <p class="stext-107 cl7 size-201">
          Any questions? Let us know in store at 8th floor, 379 Hudson St, New York, NY 10018 or call us on (+1) 96 716 6879
        </p>

        <div class="p-t-27">
          <a href="#" class="fs-18 cl7 hov-cl1 trans-04 m-r-16">
            <i class="fa fa-facebook"></i>
          </a>

          <a href="#" class="fs-18 cl7 hov-cl1 trans-04 m-r-16">
            <i class="fa fa-instagram"></i>
          </a>

          <a href="#" class="fs-18 cl7 hov-cl1 trans-04 m-r-16">
            <i class="fa fa-pinterest-p"></i>
          </a>
        </div>
      </div>

      <div class="col-sm-6 col-lg-3 p-b-50">
        <h4 class="stext-301 cl0 p-b-30">
          Newsletter
        </h4>

        <form>
          <div class="wrap-input1 w-full p-b-4">
            <input class="input1 bg-none plh1 stext-107 cl7" type="text" name="email" placeholder="email@example.com">
            <div class="focus-input1 trans-04"></div>
          </div>

          <div class="p-t-18">
            <button class="flex-c-m stext-101 cl0 size-103 bg1 bor1 hov-btn2 p-lr-15 trans-04">
              Subscribe
            </button>
          </div>
        </form>
      </div>
    </div>

    <div class="p-t-40">
      <div class="flex-c-m flex-w p-b-18">
        <a href="#" class="m-all-1">
          <img src="${pageContext.request.contextPath}/resources/images/icons/icon-pay-01.png" alt="ICON-PAY">
        </a>

        <a href="#" class="m-all-1">
          <img src="${pageContext.request.contextPath}/resources/images/icons/icon-pay-02.png" alt="ICON-PAY">
        </a>

        <a href="#" class="m-all-1">
          <img src="${pageContext.request.contextPath}/resources/images/icons/icon-pay-03.png" alt="ICON-PAY">
        </a>

        <a href="#" class="m-all-1">
          <img src="${pageContext.request.contextPath}/resources/images/icons/icon-pay-04.png" alt="ICON-PAY">
        </a>

        <a href="#" class="m-all-1">
          <img src="${pageContext.request.contextPath}/resources/images/icons/icon-pay-05.png" alt="ICON-PAY">
        </a>
      </div>

      <p class="stext-107 cl6 txt-center">
        <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
        Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | Made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a> &amp; distributed by <a href="https://themewagon.com" target="_blank">ThemeWagon</a>
        <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->

      </p>
    </div>
  </div>
</footer>


<!-- Back to top -->
<div class="btn-back-to-top" id="myBtn">
		<span class="symbol-btn-back-to-top">
			<i class="zmdi zmdi-chevron-up"></i>
		</span>
</div>

<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/popper.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/select2/select2.min.js"></script>
<script>
  $(".js-select2").each(function(){
    $(this).select2({
      minimumResultsForSearch: 20,
      dropdownParent: $(this).next('.dropDownSelect2')
    });
  })
</script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/MagnificPopup/jquery.magnific-popup.min.js"></script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script>
  $('.js-pscroll').each(function(){
    $(this).css('position','relative');
    $(this).css('overflow','hidden');
    var ps = new PerfectScrollbar(this, {
      wheelSpeed: 1,
      scrollingThreshold: 1000,
      wheelPropagation: false,
    });

    $(window).on('resize', function(){
      ps.update();
    })
  });
</script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>

</body>
</html>