<%--
  Created by IntelliJ IDEA.
  User: 14A
  Date: 2024-09-12
  Time: 오후 1:44
  To change this template use File | Settings | File Templates.
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fun" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Q&A게시판</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- TODO : 제목 과 스타일 영역 -->
    <style>


    </style>

    <script>
        function handleSubmit(event) {
            var content = document.getElementById('content').value;
            if (!content.trim()) {
                alert('답변 내용을 입력해 주세요.');
                event.preventDefault();
            }
        }
        // 목록 버튼 클릭 시 productId를 사용해 동적 URL로 이동
        function redirectToProductInfo(productId) {
            location.href = 'http://localhost:8080/productInfo.do?id=' + productId + '#qa';
        }
    </script>

</head>

<body>
<!-- NOTE : 메뉴바 -->
<jsp:include page="../common/header.jsp"/>
<div style="height: 90px"></div>


<div id="content-wrap-area">
    <!-- TODO : 컨텐츠 영역(당신이 사용할 공간) -->
    <div class="container mt-3">
        <h1 style="margin-bottom: 50px;">Q&A게시판</h1>
        <div class="row">
            <div class="col-sm-1">제목</div>
            <div class="col-sm-7">${qa.title}</div>
            <div class="col-sm-2">작성일자</div>
            <div class="col-sm-2">${fun:substring(qa.created,0,10)} ${fun:substring(qa.created,11,16)}</div>
        </div>
        <hr>
        <div class="row">
            <div class="col-sm-1">작성자</div>
            <div class="col-sm-7">${qa.name}</div>
            <div class="col-sm-2">답변여부</div>
            <div class="col-sm-2">${qa.replyStatus}</div>
        </div>
        <hr>
        <div class="row" style="min-height: 300px;">
            <div class="col-sm-1">내용</div>
            <div class="col-sm-11">${qa.content}</div>
        </div>
        <hr>
        <div class="text-right">
            <input type="hidden" name="productId" value="${qa.productId}">
            <button type="button" style="margin-bottom: 30px;" class="btn btn-dark" onclick="redirectToProductInfo('${param.productId}');">목록</button>
            <c:if test="${loginUser.role == '1'}">
                <form action="${pageContext.request.contextPath}/qa/qaDelete.do" method="post" style="display:inline;">
                    <input type="hidden" name="id" value="${qa.productId}">
                    <button type="submit" style="margin-bottom: 30px;" class="btn btn-light" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</button>
                </form>
            </c:if>
        </div>

        <%--관리자 댓글 목록--%>
        <c:forEach var="reply" items="${qa.reply}">
            <form action="${pageContext.request.contextPath}/qa/qaReplyDelete.do" method="post" style="display:inline;">
            <input type="hidden" name="productId" value="${param.productId}">
            <div class="card mt-3" style="margin-bottom: 50px;">
                <div class="card-body" style="height: 180px;">
                        <%--            <h5 class="card-title">${qa.name}</h5>--%>
                    <p class="card-update">${fun:substring(qa.created,0,10)} ${fun:substring(qa.created,11,16)}</p>
                    <p class="card-text">${qa.reply}</p>
                </div>
            </div>
            <c:if test="${loginUser.role == '1'}">

                <button type="submit" value="삭제" style="margin-bottom: 30px; margin-top: 15px; float: right" class="btn btn-light">답변 삭제</button> <%-- 이게 답변 삭제 버튼 --%>
                </form>
            </c:if>
        </c:forEach>
        <c:if test="${loginUser.role == '1'}">

            <form id="replyForm" action="${pageContext.request.contextPath}/qa/qaReplySave.do" method="post" onsubmit="return handleSubmit(event)">
                <input type="hidden" name="id" value="${qa.id}">
                <input type="hidden" name="productId" value="${qa.productId}">
                <div class="form-group">
                    <label for="content" style="margin-top: 30px; font-size: 18px; margin-bottom: 15px;">답변 내용</label>
                    <textarea class="form-control" style="resize: none; height: 150px;" id="content" name="content" rows="4"></textarea>
                </div>
                <button type="submit" style="margin-bottom: 30px; float: right" class="btn btn-dark">등록</button>
                <button type="button" style="margin-bottom: 30px; margin-right: 10px;" class="btn btn-dark"  onclick="redirectToProductInfo(${param.productId});">목록</button>
            </form>
        </c:if>

    </div>





    <!-- NOTE : 푸터바 -->
    <jsp:include page="../common/footer.jsp"/>
</body>
</html>