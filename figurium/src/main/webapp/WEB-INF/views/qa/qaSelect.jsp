<%--
Created by IntelliJ IDEA.
User: 14A
Date: 2024-08-26
Time: 오후 4:45
To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fun" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<title>Title</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- TODO : 제목 과 스타일 영역 -->
<style>

</style>
</head>

<body>
<!-- NOTE : 메뉴바 -->
<jsp:include page="../common/header.jsp"/>
<div style="height: 90px"></div>


<div id="content-wrap-area">
<!-- TODO : 컨텐츠 영역(당신이 사용할 공간) -->
<div class="container mt-5">
    <h1 style="text-align: center; margin-bottom: 50px;">Q&A게시판</h1>
    <div class="row">
        <div class="col-sm-1">제목</div>
        <div class="col-sm-7">${qa.title}</div>
        <div class="col-sm-2">작성일자</div>
        <div class="col-sm-2">${fun:substring(qa.created,0,10)} ${fun:substring(qa.created,11,16)}</div>
    </div>
    <hr>
    <div class="row">
        <div class="col-sm-1">작성자</div>
        <div class="col-sm-7">${qa.userId}</div>
        <div class="col-sm-2">답변여부</div>
        <div class="col-sm-2">${qa.replyStatus}</div>
    </div>
    <hr>
    <div class="row" style="min-height: 380px;">
        <div class="col-sm-1">내용</div>
        <div class="col-sm-11">${qa.content}</div>
    </div>
    <hr>
    <div class="text-right">
        <button type="button" style="margin-bottom: 30px;" class="btn btn-dark" onclick="location.href='${pageContext.request.contextPath}/qa/qaList.do'">목록</button>
        <c:if test="${loginUser.role == '1'}">
            <input type="button" style="margin-bottom: 30px;" class="btn btn-danger" value="삭제" onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='${pageContext.request.contextPath}/qa/qaDelete.do?id=${qa.id}'">
        </c:if>
    </div>

    <%--관리자 댓글 목록--%>
    <c:forEach var="reply" items="${qa.reply}">
        <div class="card mt-3">
            <div class="card-body">
                <h5 class="card-title">${qa.userId}</h5>
                <p class="card-text">${qa.reply}</p>
            </div>
        </div>
    </c:forEach>

    <c:if test="${loginUser.role == '1'}">

        <form action="${pageContext.request.contextPath}/qa/qaReplySave.do" method="post">
            <input type="hidden" name="id" value="${qa.id}">
            <div class="form-group">
                <label for="content">답변 내용:</label>
                <textarea class="form-control" id="content" name="content" rows="4" required></textarea>
            </div>
            <button type="submit" style="margin-bottom: 30px;" class="btn btn-dark">등록</button>

            <button type="button" style="margin-bottom: 30px; float: right;" class="btn btn-dark" onclick="location.href='${pageContext.request.contextPath}/qa/qaList.do'">목록</button>
            <c:if test="${loginUser.role == '1'}">
                <input type="button" style="margin-bottom: 30px; float: right;" class="btn btn-danger" value="삭제" onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='${pageContext.request.contextPath}/qa/qaDelete.do?id=${qa.id}'">
            </c:if>

        </form>
    </c:if>


</div>





<!-- NOTE : 푸터바 -->
<jsp:include page="../common/footer.jsp"/>
</body>
</html>