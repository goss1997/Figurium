<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>상품수정</title>
    <link rel="stylesheet" type="text/css" href="/css/productInsert.css">
    <style>
        .product_imgChange_btn{
            border: 1px #0b0b0b solid;
            background-color: #0b0b0b;
            color: white;
            border-radius: 50px;
            font-size: 15px;
            padding: 5px;
            width: 100%;
        }



        .product_imgChange_btn:hover{
            background-color: #32383e;
        }
        #image {
            display: none;
        }

    </style>
</head>
<jsp:include page="../common/header.jsp"/>
<body>
<div style="height: 90px"></div>


<div class="info_title">
    <div class="bread-crumb flex-w p-l-25 p-r-15 p-t-30 p-lr-0-lg">
        <a href="../" class="stext-109 cl8 hov-cl1 trans-04">
            Home
            <i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
        </a>

        <span class="stext-109 cl4">
                상품수정
            </span>
    </div>
</div>

<div style="min-height: 600px;">
    <form>
        <!-- 상품에 대한 상세 이미지, 이름 등 넣을 곳 -->
        <input type="hidden" name="id" value="${product.id}">
        <div class="product_title">
            <div class="product_img_box">
                <!-- 상품의 이미지가 들어 갈 곳 -->
                <div class="product_img">
                    <img id="preview" src="${product.imageUrl}">
                </div>

            </div>

            <!-- 상품의 이름이나 가격 결제 금액 등 들어 갈 곳 -->

            <div class="product_info">

                <table class="info_table">
                    <tr>
                        <th>사진 :</th>
                        <td><input type="button" class="product_imgChange_btn" name="productImageChange" id="imageChange" value="사진수정"
                                   onclick="toggleButtons();">
                            <input type="file" class="form-control form-control-sm" name="productImage" id="image"
                                   accept="image/*" onchange="previewImage(this)"></td>
                    </tr>
                    <tr>
                        <th>상품명 :</th>
                        <td><input class="form-control form-control" name="name" value="${product.name}"></td>
                    </tr>
                    <tr>
                        <th>가격 :</th>
                        <td><input class="form-control form-control" name="price" value="${product.price}"></td>
                    </tr>
                    <hr>
                    <tr>
                        <th>제조사 :</th>
                        <td>
                            <select class="form-control form-control" id="sel1" name="categoryName"
                                    style="margin: 0px;">
                                <c:forEach var="categori" items="${categoriesList}">
                                    <c:if test="${categori.name == product.category.name }">
                                        <option value="${categori.name }" selected>${categori.name }</option>
                                    </c:if>
                                    <c:if test="${categori.name != product.category.name }">
                                        <option value="${categori.name }">${categori.name }</option>
                                    </c:if>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>


                    <tr>
                        <th>재고</th>
                        <td>
                            <input type="text" class="form-control form-control" name="quantity"
                                   value="${product.quantity}">
                        </td>
                    </tr>
                </table>

                <hr>

                <div class="product_cancel">
                    <input class="product_cancel_btn" type="button" value="취소" onclick="window.history.back();">
                    <input class="product_insert_btn" type="button" value="수정" onclick="send(this.form);">
                </div>

            </div>

        </div>
    </form>
</div>

<jsp:include page="../common/footer.jsp"/>
</body>
<script>
    $(function () {
        if(${loginUser.role ne "1"}) {
            console.log(${loginUser.role});
            alert('관리자만 등록이 가능합니다.');
            location.href = "/";
        }
    });
</script>

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

    function send(f) {

        const regExp = /^[0-9]*$/;

        let id                  = f.id.value;
        let name                = f.name.value.trim();
        let price 	            = f.price.value.trim();
        let category    	    = f.categoryName.value.trim();
        let quantity  	        = f.quantity.value.trim();


        if (regExp.test(price) == false) {
            alert("가격에는 숫자만 기재해주세요.");
            f.price.value="";
            f.price.focus();
            return;
        }

        if (regExp.test(quantity) == false) {
            alert("재고수량은 숫자만 입력가능합니다.");
            f.quantity.value="";
            f.quantity.focus();
            return;
        }

        if (name == '') {
            alert("상품명을 입력하세요");
            f.name.value = "";
            f.name.focus();
            return;
        }
        if (price == '') {
            alert("가격을 입력하세요");
            f.price.value = "";
            f.price.focus();
            return;
        }
        if (category == '선택하세요.') {
            alert("제조사를 선택하세요");
            f.categoryName.value = "";
            f.categoryName.focus();
            return;
        }
        if (quantity == '') {
            alert("재고수량을 입력하세요");
            f.quantity.value = "";
            f.quantity.focus();
            return;
        }


        console.log(name);
        console.log(price);
        console.log(quantity);
        console.log(category);


        f.enctype = 'multipart/form-data';
        f.action = "productModify.do?id=" + id;
        f.method = 'post';
        f.submit(); //전송


    }//end:send()


    function toggleButtons(){

        var imageChangeButton = document.getElementById('imageChange');
        var imageInput = document.getElementById('image');

        // 첫 번째 버튼 숨기기
        imageChangeButton.style.display = 'none';

        // 두 번째 버튼 보이기
        imageInput.style.display = 'block';

    }
</script>

</html>