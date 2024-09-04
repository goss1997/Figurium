<%--
  Created by IntelliJ IDEA.
  User: 14A
  Date: 2024-08-26
  Time: 오후 6:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Title</title>
    <style>
        .shopinfo {padding-bottom:40px; background: #151515; text-align:center;}
        .shopinfo .menu {padding:53px 0 21px; font-size:0;}
        .shopinfo .menu li {display:inline-block; *display:inline; *zoom:1;}
        .shopinfo .menu li a {display:block; position:relative; padding:0 15px; color:#666; font-size:15px;}
        .shopinfo .menu li a:after {display:block; position:absolute; left:0; top:50%; width:1px; height:12px; margin-top:-6px; background:#515151; content:'';}
        .shopinfo .menu li:first-child a:after {display:none;}
        .shopinfo .info,
        .shopinfo .info * {color:#999; font-size:14px; font-style:normal; line-height:22px;}
        .shopinfo .info span {padding-right:5px;}
        .shopinfo .info span.last {padding-right:0;}
        .shopinfo .escrow,
        .shopinfo .escrow *,
        .shopinfo .copyright,
        .shopinfo .copyright * {color:#737373; font-size:13px;}
        .shopinfo .copyright a:hover,
        .shopinfo .copyright a .wisa {color:#3fc0e5;}
    </style>
</head>
<body>
<div class="shopinfo">
    <div class="wrap_inner">
        <ul class="menu">
            <li><a>서비스이용약관</a></li>
            <li><a class="p_color">개인정보처리방침</a></li>
            <li><a>회사소개</a></li>
        </ul>
        <!-- 쇼핑몰정보 및 에스크로 -->
        <address class="info">
            <span>상호명 : 주식회사 피규리움</span>
            <span>주소 : 서울특별시 관악구 남부순환로 1820 (봉천동) 에그엘로우 7층</span> <br>
            <span>사업자등록번호 : 202-20-20241</span> <span>대표자 : 차선일</span>  <br>
            <span class="last">개인정보보호책임자 : 이지훈 ㅣ </span> <span>고객상담담당자 : 류순철</span> <br>
            <span>통신판매업신고번호 : 제2024-서울강남구-2024</span><span>이메일 : <a href="https://github.com/goss1997/git_final">https://github.com/goss1997/git_final</a></span><span class="last">호스팅 제공자 : (주) 고성수</span><br><br>
        </address>
        <!-- //쇼핑몰정보 및 에스크로 -->
        <p class="escrow">고객님은 안전거래를 위해 현금으로 결제 시 저희 쇼핑몰에 가입한 구매안전서비스를 이용하실 수 있습니다.</p>
        <p class="copyright">Copyright © 2024 주식회사 피규리움. All Rights Reserved. designed &amp; managed by saehim.</p>
    </div>
</div>
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
    $(".js-select2").each(function () {
        $(this).select2({
            minimumResultsForSearch: 20,
            dropdownParent: $(this).next('.dropDownSelect2')
        });
    })
</script>


<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/daterangepicker/moment.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/slick/slick.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/slick-custom.js"></script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/parallax100/parallax100.js"></script>
<script>
    $('.parallax100').parallax100();
</script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/MagnificPopup/jquery.magnific-popup.min.js"></script>
<script>
    $('.gallery-lb').each(function () { // the containers for all your galleries
        $(this).magnificPopup({
            delegate: 'a', // the selector for gallery item
            type: 'image',
            gallery: {
                enabled: true
            },
            mainClass: 'mfp-fade'
        });
    });
</script>

<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/isotope/isotope.pkgd.min.js"></script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/sweetalert/sweetalert.min.js"></script>
<script>
    $('.js-addwish-b2').on('click', function (e) {
        e.preventDefault();
    });

    $('.js-addwish-b2').each(function () {
        var nameProduct = $(this).parent().parent().find('.js-name-b2').html();
        $(this).on('click', function () {
            swal(nameProduct, "is added to wishlist !", "success");

            $(this).addClass('js-addedwish-b2');
            $(this).off('click');
        });
    });

    $('.js-addwish-detail').each(function () {
        var nameProduct = $(this).parent().parent().parent().find('.js-name-detail').html();

        $(this).on('click', function () {
            swal(nameProduct, "is added to wishlist !", "success");

            $(this).addClass('js-addedwish-detail');
            $(this).off('click');
        });
    });

    /*---------------------------------------------*/

    $('.js-addcart-detail').each(function () {
        var nameProduct = $(this).parent().parent().parent().parent().find('.js-name-detail').html();
        $(this).on('click', function () {
            swal(nameProduct, "is added to cart !", "success");
        });
    });

</script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script>
    $('.js-pscroll').each(function () {
        $(this).css('position', 'relative');
        $(this).css('overflow', 'hidden');
        var ps = new PerfectScrollbar(this, {
            wheelSpeed: 1,
            scrollingThreshold: 1000,
            wheelPropagation: false,
        });

        $(window).on('resize', function () {
            ps.update();
        })
    });
</script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>



</body>
</html>