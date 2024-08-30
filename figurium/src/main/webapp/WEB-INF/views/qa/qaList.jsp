<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: mac
  Date: 8/26/24
  Time: 5:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

    <script type="text/javascript">
        function qaInsert() {
            // 로그인 체크 (안되어 있으면)
            var isUserLoggedIn = "${user != null && !empty user ? 'true' : 'false'}";

            if (isUserLoggedIn === 'false') {
                alert("글쓰기는 로그인 후 가능합니다.");
                // 로그인 폼으로 이동
                location.href = "QaList.do";
            } else {
                // 게시글 작성 폼으로 이동
                location.href = "QaInsert.do";
            }
        }
    </script>



</head>


<jsp:include page="../common/header.jsp"/>
<div style="height: 90px"></div>
<body>

<div class="container pt-5">
    <h1 style="color: black !important;">Q&A게시판</h1>
    <table class="table table-hover">
        <thead class="thead-light">
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>답변여부</th>
            <th>작성자</th>
            <th>작성일</th>
        </tr>
        </thead>
        <tbody style="min-height: 300px;"   >
        <c:forEach var="qa" items="${qaList}">
            <tr>
                <td>${qa.id}</td>
                <td><a href="${pageContext.request.contextPath}/qa/select?id=${qa.id}">${qa.title}</a></td>
                <td>${qa.reply != null ? '답변완료' : '미답변'}</td>
                <td>${qa.userId}</td>
                <td>${qa.created}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <hr>

    <button type="button" class="btn btn-dark float-right" style="color:#FFFFFF !important;"
            onclick="qaInsert()">글쓰기</button>


    <ul class="pagination justify-content-center" style="margin:20px 0;">
    <li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
    <li class="page-item"><a class="page-link" href="#">1</a></li>
    <li class="page-item"><a class="page-link" href="#">2</a></li>
    <li class="page-item"><a class="page-link" href="#">3</a></li>
    <li class="page-item"><a class="page-link" href="#">Next</a></li>
    </ul>

</div>

<!-- NOTE : 푸터바 -->
<jsp:include page="../common/footer.jsp"/>
</body>
</html>