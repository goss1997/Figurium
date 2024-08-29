
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>리뷰작성</title>
    <link rel="stylesheet" type="text/css" href="../../../resources/css/reviewInsertForm.css">
</head>
<body>
<div class="review-form-container">
    <h2 class="review-title">상품 리뷰 작성</h2>

    <form id="reviewForm" class="review-form">
       <%-- <input type="hidden" name="id" value="${vo.id}">--%>
        <div class="form-group">
            <label for="reviewTitle">리뷰 제목</label>
            <input type="text" id="reviewTitle" name="title" placeholder="리뷰 제목을 입력하세요">
        </div>

        <div class="form-group">
            <label for="reviewImage">상품 이미지 업로드</label>
            <input type="file" id="reviewImage" name="image_url" value="사진선택" onchange="imgupload()">
            <div id="imagePreview" class="image-preview"></div>
        </div>


        <div class="form-group">
            <label for="reviewContent">후기 내용</label>
            <textarea id="reviewContent" name="content" rows="6" placeholder="리뷰를 작성하세요"></textarea>
        </div>
        <div class="form-group">
            <div class="star_box">평점</div>
            <div class="rating_box">
            <div class="rating">
                <input type="radio" id="star5" name="rating" value="5">
                <label for="star5" title="5점">★</label>
                <input type="radio" id="star4" name="rating" value="4">
                <label for="star4" title="4점">★</label>
                <input type="radio" id="star3" name="rating" value="3">
                <label for="star3" title="3점">★</label>
                <input type="radio" id="star2" name="rating" value="2">
                <label for="star2" title="2점">★</label>
                <input type="radio" id="star1" name="rating" value="1">
                <label for="star1" title="1점">★</label>
            </div>
            </div>
        </div>

        <div class="form-group">
            <input class="insert_btn" type="button" value="리뷰 작성" onclick="reviewInsert(this.form)">
        </div>
    </form>
</div>


</body>

<script>
    function imgupload() {
        let productImg = document.getElementById("reviewImage").files;

        if (productImg.length > 0) {
            // 이미지 미리보기 처리
            let reader = new FileReader();
            reader.readAsDataURL(productImg[0]);

            reader.onload = function(e) {
                // 기존 이미지 미리보기가 있으면 제거
                let imagePreviewDiv = document.getElementById("imagePreview");
                imagePreviewDiv.innerHTML = ''; // 기존 내용 제거

                // 새 img 태그 생성
                let imgElement = document.createElement("img");
                imgElement.src = e.target.result;
                imgElement.style.maxWidth = "100%";
                imgElement.style.maxHeight = "100%";
                imgElement.style.objectFit = "cover";

                // 이미지 미리보기 영역에 이미지 추가
                imagePreviewDiv.appendChild(imgElement);
            };
        } else {
            // 파일이 선택되지 않은 경우 미리보기 영역 초기화
            document.getElementById("imagePreview").innerHTML = '';
        }
    }
</script>

<script>
    // 리뷰 작성 버튼 클릭 시 검증
    function reviewInsert(f){

//        let id    = f.id.value;
        let title = f.title.value.trim();
        let image_url = f.image_url.value;
        let content = f.content.value.trim();
        let rating = f.rating.value.trim();

        if (title = ""){
            alert("제목을 입력하세요");

        }




    }

</script>



</html>
