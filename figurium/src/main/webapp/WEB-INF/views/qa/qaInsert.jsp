    <%--
      Created by IntelliJ IDEA.
      User: mac
      Date: 8/27/24
      Time: 9:28 AM
      To change this template use File | Settings | File Templates.
    --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <title>Title</title>
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
      <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    </head>
    <jsp:include page="../common/header.jsp"/>
    <div style="height: 90px"></div>
    <body>

    <div class="container pt-5">
        <h1>게시글 작성</h1>
        <hr>
        <form>
            <div class="form-group">
                <input type="text" class="form-control" id="title" placeholder="사용자명을 입력하세요">
            </div>
            <div class="form-group">
                <input type="password" class="form-control" id="author" placeholder="비밀번호를 입력하세요">
            </div>
            <form>
                <select name="cars" class="custom-select">
                    <option selected>:::분류 선택:::</option>
                    <option value="volvo">배송문의</option>
                    <option value="fiat">취소문의</option>
                    <option value="audi">교환</option>
                    <option value="audi">반품문의</option>
                    <option value="audi">배송지변경문의</option>
                    <option value="audi">기타문의</option>
                </select>
            </form>
            <br>
            <div class="form-group">
                <input type="text" class="form-control" id="author1" placeholder="제목을 입력하세요">
            </div>
            <div class="form-group">
                <textarea class="form-control" style="resize: none; height: 180px;" id="content" placeholder="내용을 입력하세요"></textarea>
            </div>
        </form>

        <button type="button" class="btn btn-light" role="button" onclick="location.href='/'" style="margin-bottom: 10px;">취소</button>
        <button type="button" class="btn btn-dark" id="btn-save" style="margin-bottom: 10px;" onclick="location.href='qaList.do'">등록</button>

    </div>


    <!-- NOTE : 푸터바 -->
    <jsp:include page="../common/footer.jsp"/>

    </body>


    </html>
