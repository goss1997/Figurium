<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
</head>
<body>
<!-- reviewsList.jsp -->
<table class="review_table">


<c:forEach var="review" items="${reviews}">
    <tr>
        <td class="review_number">${review.number}</td>
        <td>
            <a href="#" class="review-title" data-id="${review.id}">
            </a>
        </td>
        <td class="review_name">${review.userName}</td>
        <td class="review_regdate">${fn:substring(review.createdAt,0,10)} ${fn:substring(review.createdAt,11,16)}</td>
        <td class="review_star">
            <c:forEach var="i" begin="1" end="${review.rating}">
                <span class="star">&#9733;</span>
            </c:forEach>
            <c:forEach var="i" begin="${review.rating + 1}" end="5">
                <span class="star">&#9734;</span>
            </c:forEach>
        </td>
    </tr>

    <!-- 리뷰 내용 표시 영역 -->
    <tr id="reviewContent-${review.id}" class="review-content" style="display:none;">
        <td colspan="5">
            <div id="spinner-${review.id}" class="spinner" style="display:none;">로딩 중...</div>
            <div id="reviewText-${review.id}" class="review-text"></div>

            <div class="review_buttons" id="reviewButtons-${review.id}" style="display:none;">
                <form>
                    <input type="hidden" name="userId" value="${review.userId}">
                    <input type="hidden" name="id" value="${review.id}">
                    <input type="hidden" name="productId" value="${review.productId}">
                    <input type="button" class="edit_button" data-id="${review.id}" value="수정" onclick="update_review(this.form)">
                    <input type="button" class="delete_button" data-id="${review.id}" value="삭제" onclick="delete_review(this.form)">
                </form>
            </div>
        </td>
    </tr>
</c:forEach>
</table>
</body>
</html>
