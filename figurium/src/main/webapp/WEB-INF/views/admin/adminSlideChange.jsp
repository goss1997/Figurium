<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet"
      href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"/>
<html>
<head>
  <title>메인 슬라이드 변경</title>
  <style>
    .thead-light > tr > th {
      text-align: center;
      vertical-align: middle !important;
    }

    tbody > tr > td {
      text-align: center;
      vertical-align: middle !important;
    }

    .nav-link:hover {
      cursor: pointer;
    }

    .card-header > input {
      display: inline-block;
    }
    .navbar-nav > li {
      line-height: 1;
    }
    /* 숨겨진 기본 파일 선택 텍스트 */
    input[type="file"] {
      display: none;
    }

    /* 파일 선택 버튼 커스텀 */
    .custom-file-label {
      width: 150px;
      margin-left: 150px;
      margin-top: 4px;
      padding: 10px 20px;
      background-color: #4CAF50;
      color: white;
      border: none;
      cursor: pointer;
      border-radius: 5px;
    }

    /* 마우스 오버 시 버튼 스타일 */
    .custom-file-label:hover {
      background-color: #45a049;
    }

    .item-slick1 {
      background-size: cover;
      background-position: center;
    }

    .card-body {
      aspect-ratio: 3.8 / 1;
    }

    /* 반응형 스타일 */
    @media (max-width: 768px) {
      .custom-file-label {
        position: relative !important;
        width: 100%; /* 모바일에서 버튼 너비를 100%로 */
        margin-left: 0; /* 모바일에서 왼쪽 여백 제거 */
        margin-top: 10px; /* 버튼 간격 조정 */
      }

      .card-header {
        flex-direction: column; /* 카드 헤더 세로 정렬 */
        align-items: flex-start; /* 왼쪽 정렬 */
      }

      .item-slick1 {
        aspect-ratio: 3 / 1; /* 모바일에서 비율 조정 */
        max-height: 300px; /* 높이 조정 */
      }

      .apply-btn {
        width: 100%; /* 버튼 너비를 100%로 */
        margin-top: 10px; /* 버튼 간격 조정 */
      }
      .card-body {
        aspect-ratio: auto;
      }
    }
  </style>
</head>

<body>
<!-- 메뉴바 -->
<jsp:include page="../common/header.jsp"/>
<div style="height: 90px"></div>
<div id="content-wrap-area">

  <nav class="navbar navbar-expand-sm bg-dark navbar-dark justify-content-center">
    <ul class="navbar-nav">
      <li class="nav-item">
        <div class=" cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti">
          <a class="nav-link" style="font-size: 16px; vertical-align: middle !important; margin-top: 3px;"
             href="adminSlideChange.do">메인 슬라이드 변경</a>
        </div>
      </li>

      <li class="nav-item">
        <div class=" cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti">
          <a class="nav-link" style="font-size: 16px; vertical-align: middle !important; margin-top: 3px;"
             href="productInsertForm.do">상품 등록</a>
        </div>
      </li>

      <li class="nav-item">
        <div class=" cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti">
          <a class="nav-link" style="font-size: 16px; vertical-align: middle !important; margin-top: 3px;"
             href="admin.do">주문조회</a>
        </div>
      </li>

      <li class="nav-item">
        <div class=" cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti">
          <a class="nav-link" style="font-size: 16px; vertical-align: middle !important; margin-top: 3px;"
             id="changeStatus" href="adminRefund.do">배송상태 변경</a>
        </div>
      </li>

      <li class="nav-item">
        <div class="icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti"
             id="quantity-notify"
             data-notify="0">
          <a class="nav-link" style="font-size: 16px; vertical-align: middle !important; margin-top: 3px;"
             href="adminQuantity.do">상품 재고수정</a>
        </div>
      </li>

      <li class="nav-item">
        <div class="icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti"
             id="payment-notify"
             data-notify="0">
          <a class="nav-link" style="font-size: 16px; vertical-align: middle !important; margin-top: 3px;"
             href="adminPayment.do">결제취소</a>
        </div>
      </li>

      <li class="nav-item">
        <div class="icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti"
             id="retrun-notify"
             data-notify="0">
          <a class="nav-link" style="font-size: 16px; vertical-align: middle !important; margin-top: 3px;"
             href="adminReturns.do">반품승인</a>
        </div>
      </li>

      <li class="nav-item">
        <div class="icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti"
             id="qa-notify"
             data-notify="0">
          <a class="nav-link" style="font-size: 16px; vertical-align: middle !important; margin-top: 3px;"
             id="viewQaList" href="adminQaList.do" >Q&A 미답변</a>
        </div>
      </li>
    </ul>
  </nav>

  <br><br>

  <div class="container" style="padding: 0; max-width: 80%; margin: auto;">
    <div id="accordion">
      <div class="card">
        <div class="card-header">
          <a class="card-link" data-toggle="collapse" href="#collapseOne">
            1번 슬라이드
          </a>
          <label class="custom-file-label" for="slideImage1Input">선택</label>
          <input type="file" id="slideImage1Input" name="slideImage" accept="image/*" onchange="previewImage1(this)">
          <button class="apply-btn btn btn-info" onclick="applySlide(1)" style="float: right;">적용</button>
        </div>
        <div id="collapseOne" class="collapse show" data-parent="#accordion">
          <div class="card-body">
            <div class="item-slick1" id="slideImage1"
                 style="max-height: 500px; background-image: url(/images/Slider1.jpg); height: 100%; position: relative; background-size: cover; background-position: center;">
              <div class="container"></div>
            </div>
          </div>
        </div>
      </div>
      <div class="card">
        <div class="card-header">
          <a class="collapsed card-link" data-toggle="collapse" href="#collapseTwo">
            2번 슬라이드
          </a>
          <label class="custom-file-label" for="slideImage2Input">선택</label>
          <input type="file" id="slideImage2Input" name="slideImage" accept="image/*" onchange="previewImage2(this)">
          <button class="apply-btn btn btn-info" onclick="applySlide(2)" style="float: right;">적용</button>
        </div>
        <div id="collapseTwo" class="collapse" data-parent="#accordion">
          <div class="card-body">
            <div class="item-slick1" id="slideImage2"
                 style="max-height: 500px; background-image: url(/images/Slider2.jpg); height: 100%; position: relative; background-size: cover; background-position: center;">
              <div class="container"></div>
            </div>
          </div>
        </div>
      </div>
      <div class="card">
        <div class="card-header">
          <a class="collapsed card-link" data-toggle="collapse" href="#collapseThree">
            3번 슬라이드
          </a>
          <label class="custom-file-label" for="slideImage3Input">선택</label>
          <input type="file" id="slideImage3Input" name="slideImage" accept="image/*" onchange="previewImage3(this)">
          <button class="apply-btn btn btn-info" onclick="applySlide(3)" style="float: right;">적용</button>
        </div>
        <div id="collapseThree" class="collapse" data-parent="#accordion">
          <div class="card-body">
            <div class="item-slick1" id="slideImage3"
                 style="max-height: 500px; background-image: url(/images/Slider3.jpg); height: 100%; position: relative; background-size: cover; background-position: center;">
              <div class="container"></div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>




  <br><br>

</div>
<!-- 푸터 -->
<jsp:include page="../common/footer.jsp"/>
</body>

<script>
  function previewImage1(input) {
    const file = input.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = function (e) {
        document.getElementById('slideImage1').style.backgroundImage = 'url(' + e.target.result + ')';
      }
      reader.readAsDataURL(file);
    }
  }
  function previewImage2(input) {
    const file = input.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = function (e) {
        document.getElementById('slideImage2').style.backgroundImage = 'url(' + e.target.result + ')';
      }
      reader.readAsDataURL(file);
    }
  }
  function previewImage3(input) {
    const file = input.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = function (e) {
        document.getElementById('slideImage3').style.backgroundImage = 'url(' + e.target.result + ')';
      }
      reader.readAsDataURL(file);
    }
  }



  // 적용 버튼을 눌렀을 때 AJAX로 이미지 전송
  function applySlide(slideNumber) {
    const input = document.getElementById(`slideImage` + slideNumber + `Input`);
    const file = input.files[0];

    if (!file) {
      alert('파일을 선택해주세요.');
      return;
    }
    if (!input) {
      alert(`슬라이드 ` + slideNumber + `의 파일 입력 요소를 찾을 수 없습니다.`);
      return;
    }

    const formData = new FormData();
    formData.append('slideImage', file);
    formData.append('slideNumber', slideNumber);

    // AJAX를 사용하여 이미지 업로드
    fetch('/uploadSlideImage.do', {
      method: 'POST',
      body: formData
    })
            .then(response => response.json())
            .then(data => {
              if (data.success) {
                alert('이미지가 성공적으로 적용되었습니다.');
              } else {
                alert('이미지 적용에 실패했습니다.');
              }
              location.reload();
            })
            .catch(error => {
              console.error('오류 발생:', error);
              alert('이미지 적용에 실패했습니다.');
            });
  }
</script>


<script>
  function updateCount() {
    $.ajax({
      url: 'count.do', // 컨트롤러에서 갯수를 가져오는 URL
      type: 'GET',
      dataType: 'json',
      success: function (response) {
        console.log(response);
        if (response.quantityCount !== undefined) {
          $('#quantity-notify').attr('data-notify', response.quantityCount);
          if (response.quantityCount == 0) {
            $('#quantity-notify').removeClass('admin-icon-header-item');
          } else {
            $('#quantity-notify').addClass('admin-icon-header-item');
            $(".admin-icon-header-item").addClass('has-notifications');
          }
        } else {
          $('#quantity-notify').attr('data-notify', '0').removeClass('admin-icon-header-item');
        }

        if (response.paymentCount !== undefined) {
          $('#payment-notify').attr('data-notify', response.paymentCount);
          if (response.paymentCount == 0) {
            $('#payment-notify').removeClass('admin-icon-header-item');
          } else {
            $('#payment-notify').addClass('admin-icon-header-item');
            $(".admin-icon-header-item").addClass('has-notifications');
          }
        } else {
          $('#payment-notify').attr('data-notify', '0').removeClass('admin-icon-header-item');
        }

        if (response.retrunCount !== undefined) {
          $('#retrun-notify').attr('data-notify', response.retrunCount);
          if (response.retrunCount == 0) {
            $('#retrun-notify').removeClass('admin-icon-header-item');
          } else {
            $('#retrun-notify').addClass('admin-icon-header-item');
            $(".admin-icon-header-item").addClass('has-notifications');
          }
        } else {
          $('#retrun-notify').attr('data-notify', '0').removeClass('admin-icon-header-item');
        }

        if (response.qaCount !== undefined) {
          $('#qa-notify').attr('data-notify', response.qaCount);
          if (response.qaCount == 0) {
            $('#qa-notify').removeClass('admin-icon-header-item');
          } else {
            $('#qa-notify').addClass('admin-icon-header-item');
            $(".admin-icon-header-item").addClass('has-notifications');
          }
        } else {
          $('#qa-notify').attr('data-notify', '0').removeClass('admin-icon-header-item');
        }
      },
      error: function (xhr, status, error) {
        console.error('count 가져오는 데 실패했습니다.', error);
        $('#quantity-notify').attr('data-notify', '0').removeClass('admin-icon-header-item'); // 오류 발생 시 0으로 설정
        $('#payment-notify').attr('data-notify', '0').removeClass('admin-icon-header-item'); // 오류 발생 시 0으로 설정
        $('#retrun-notify').attr('data-notify', '0').removeClass('admin-icon-header-item'); // 오류 발생 시 0으로 설정
        $('#qa-notify').attr('data-notify', '0').removeClass('admin-icon-header-item'); // 오류 발생 시 0으로 설정
      }
    });
  }



  $(document).ready(function () {

    updateCount();

  });

</script>

</html>
