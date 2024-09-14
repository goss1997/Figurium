package com.githrd.figurium.util.page;

public class Paging {

    public static String getPaging(String pageURL,int nowPage, int rowTotal,int blockList, int blockPage){

        int totalPage/*전체페이지수*/,
                startPage/*시작페이지번호*/,
                endPage;/*마지막페이지번호*/

        boolean  isPrevPage,isNextPage;
        StringBuffer sb; //모든 상황을 판단하여 HTML코드를 저장할 곳


        isPrevPage=isNextPage=false;
        //입력된 전체 자원을 통해 전체 페이지 수를 구한다..
        totalPage = rowTotal/blockList;
        if(rowTotal%blockList!=0)totalPage++;


        //만약 잘못된 연산과 움직임으로 인하여 현재 페이지 수가 전체 페이지 수를
        //넘을 경우 강제로 현재페이지 값을 전체 페이지 값으로 변경
        if(nowPage > totalPage)nowPage = totalPage;


        //시작 페이지와 마지막 페이지를 구함.
        startPage = ((nowPage-1)/blockPage) * blockPage + 1;
        endPage   = startPage + blockPage - 1; //


        //마지막 페이지 수가 전체페이지수보다 크면 마지막페이지 값을 변경
        if(endPage > totalPage)endPage = totalPage;

        //마지막페이지가 전체페이지보다 작을 경우 다음 페이징이 적용할 수 있도록
        //boolean형 변수의 값을 설정
        if(endPage < totalPage) isNextPage = true;

        //시작페이지의 값이 1보다 작으면 이전페이징 적용할 수 있도록 값설정
        if(startPage > 1)isPrevPage = true;


        // HTML 코드를 저장할 StringBuffer 생성
        sb = new StringBuffer("<div style='display: flex; justify-content: center; margin: 20px 0;'><nav aria-label='Page navigation'><ul class='pagination' style='margin: 0;'>");

        // 이전 페이지 버튼
        if (isPrevPage) {
            sb.append(String.format("<li class='page-item'><a class='page-link' href='%s?page=%d' aria-label='Previous'><span aria-hidden='true'>◀</span></a></li>", pageURL, startPage - 1));
        } else {
            sb.append("<li class='page-item disabled'><a class='page-link' href='#' aria-label='Previous'><span aria-hidden='true'>◀</span></a></li>");
        }

        // 페이지 목록 출력
        for (int i = startPage; i <= endPage; i++) {
            if (i == nowPage) { // 현재 페이지
                sb.append(String.format("<li class='page-item active'><a class='page-link' href='#'>%d</a></li>", i));
            } else { // 다른 페이지
                sb.append(String.format("<li class='page-item'><a class='page-link' href='%s?page=%d'>%d</a></li>", pageURL, i, i));
            }
        }

        // 다음 페이지 버튼
        if (isNextPage) {
            sb.append(String.format("<li class='page-item'><a class='page-link' href='%s?page=%d' aria-label='Next'><span aria-hidden='true'>▶</span></a></li>", pageURL, endPage + 1));
        } else {
            sb.append("<li class='page-item disabled'><a class='page-link' href='#' aria-label='Next'><span aria-hidden='true'>▶</span></a></li>");
        }

        sb.append("</ul></nav></div>");

        return sb.toString();
    }

    public static String getPaging(String pageURL,String filter,int nowPage, int rowTotal,int blockList, int blockPage){

        int totalPage/*전체페이지수*/,
                startPage/*시작페이지번호*/,
                endPage;/*마지막페이지번호*/

        boolean  isPrevPage,isNextPage;
        StringBuffer sb; //모든 상황을 판단하여 HTML코드를 저장할 곳


        isPrevPage=isNextPage=false;
        //입력된 전체 자원을 통해 전체 페이지 수를 구한다..
        totalPage = rowTotal/blockList;
        if(rowTotal%blockList!=0)totalPage++;


        //만약 잘못된 연산과 움직임으로 인하여 현재 페이지 수가 전체 페이지 수를
        //넘을 경우 강제로 현재페이지 값을 전체 페이지 값으로 변경
        if(nowPage > totalPage)nowPage = totalPage;


        //시작 페이지와 마지막 페이지를 구함.
        startPage = ((nowPage-1)/blockPage) * blockPage + 1;
        endPage   = startPage + blockPage - 1; //


        //마지막 페이지 수가 전체페이지수보다 크면 마지막페이지 값을 변경
        if(endPage > totalPage)endPage = totalPage;

        //마지막페이지가 전체페이지보다 작을 경우 다음 페이징이 적용할 수 있도록
        //boolean형 변수의 값을 설정
        if(endPage < totalPage) isNextPage = true;

        //시작페이지의 값이 1보다 작으면 이전페이징 적용할 수 있도록 값설정
        if(startPage > 1)isPrevPage = true;

        // HTML 코드를 저장할 StringBuffer 생성
        sb = new StringBuffer("<div style='display: flex; justify-content: center; margin: 20px 0;'><nav aria-label='Page navigation'><ul class='pagination' style='margin: 0;'>");

        // 이전 페이지 버튼
        if (isPrevPage) {
            sb.append(String.format("<li class='page-item'><a class='page-link' href='%s?page=%d&%s' aria-label='Previous'><span aria-hidden='true'>◀</span></a></li>", pageURL, startPage - 1, filter));
        } else {
            sb.append("<li class='page-item disabled'><a class='page-link' href='#' aria-label='Previous'><span aria-hidden='true'>◀</span></a></li>");
        }

        // 페이지 목록 출력
        for (int i = startPage; i <= endPage; i++) {
            if (i == nowPage) { // 현재 페이지
                sb.append(String.format("<li class='page-item active'><a class='page-link' href='#'>%d</a></li>", i));
            } else { // 다른 페이지
                sb.append(String.format("<li class='page-item'><a class='page-link' href='%s?page=%d&%s'>%d</a></li>", pageURL, i, filter, i));
            }
        }

        // 다음 페이지 버튼
        if (isNextPage) {
            sb.append(String.format("<li class='page-item'><a class='page-link' href='%s?page=%d&%s' aria-label='Next'><span aria-hidden='true'>▶</span></a></li>", pageURL, endPage + 1, filter));
        } else {
            sb.append("<li class='page-item disabled'><a class='page-link' href='#' aria-label='Next'><span aria-hidden='true'>▶</span></a></li>");
        }

        sb.append("</ul></nav></div>");

        return sb.toString();
    }
}




