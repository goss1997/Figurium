<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet"
      href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"/>
<html>
<head>
  <title>메인 슬라이드 변경</title>
  <style>
    .thead-light>tr>th{
      text-align: center;
      vertical-align: middle !important;
    }
    tbody>tr>td{
      text-align: center;
      vertical-align: middle !important;
    }
    .nav-link:hover{
      cursor: pointer;
    }

    .card-header > input {
      display: inline-block;
    }

    /* 숨겨진 기본 파일 선택 텍스트 */
    input[type="file"] {
      display: none;
    }

    /* 파일 선택 버튼 커스텀 */
    .custom-file-label {
      width: 200px;
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



  </style>
</head>

<body>
<!-- 메뉴바 -->
<jsp:include page="../common/header.jsp"/>
<div style="height: 90px"></div>
<div id="content-wrap-area">

  <div class="container" style="padding: 0;width: 80%;">
    <div id="accordion">
      <div class="card">
        <div class="card-header">
          <a class="card-link" data-toggle="collapse" href="#collapseOne">
            1번 슬라이드
          </a>
          <label class="custom-file-label" for="slideImage1Input">파일 선택</label>
          <input type="file" id="slideImage1Input" name="slideImage" accept="image/*" onchange="previewImage1(this)">
          <button class="apply-btn btn btn-info" onclick="applySlide(1)" style="float: right;">적용</button>
        </div>
        <div id="collapseOne" class="collapse show" data-parent="#accordion">
          <div class="card-body">
            <div class="item-slick1" id="slideImage1"
                 style="max-height: 500px; background-image: url(/images/Slider1.jpg);">
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
          <label class="custom-file-label" for="slideImage2Input">파일 선택</label>
          <input type="file" id="slideImage2Input" name="slideImage" accept="image/*" onchange="previewImage2(this)">
          <button class="apply-btn btn btn-info" onclick="applySlide(2)" style="float: right;">적용</button>
        </div>
        <div id="collapseTwo" class="collapse" data-parent="#accordion">
          <div class="card-body">
            <div class="item-slick1" id="slideImage2"
                 style="max-height: 500px; background-image: url(/images/Slider2.jpg);">
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
          <label class="custom-file-label" for="slideImage3Input">파일 선택</label>
          <input type="file" id="slideImage3Input" name="slideImage" accept="image/*" onchange="previewImage3(this)">
          <button class="apply-btn btn btn-info" onclick="applySlide(3)" style="float: right;">적용</button>
        </div>
        <div id="collapseThree" class="collapse" data-parent="#accordion">
          <div class="card-body">
            <div class="item-slick1" id="slideImage3"
                 style="max-height: 500px; background-image: url(/images/Slider3.jpg);">
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
            })
            .catch(error => {
              console.error('오류 발생:', error);
              alert('이미지 적용에 실패했습니다.');
            });
  }
</script>

</html>
