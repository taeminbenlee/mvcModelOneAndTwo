<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
MemberDto mem = (MemberDto)request.getSession().getAttribute("login");

%>

<%
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq.trim());

BbsDao dao = BbsDao.getInstance();
BbsDto dto = dao.getBBS(seq);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link href='https://fonts.googleapis.com/css?family=Rock+Salt' rel='stylesheet' type='text/css'>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" 
integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ"
 crossorigin="anonymous">
<style type="text/css">
h1{color: white;}
h2{font-family: 'Rock Salt', cursive; color: aqua;}
p{font-family: 'Rock Salt', cursive; color: white;}
.nav-link{font-family: 'Nanum Pen Script', cursive; font-size: 30px;}
.welc{font-family: 'Nanum Pen Script', cursive; font-size: 30px;}
.navbar-brand{font-family: 'Nanum Pen Script', cursive; font-size: 30px;}
html {
  font-family: 'helvetica neue', helvetica, arial, sans-serif;
}
#leftScr{width:62.1%; height:100%; float: left;}
#rightScr{width:37.9%; height:100%; float: left;}
body{background-color: black;}
.utill2{float: left;}
.utill3{float: left;}
.utill4{float: left;}
</style>
</head>
<body>

<!-- 네비게이션바ー -->
<nav class="navbar navbar-expand-md navbar-dark bg-dark sticky-top">
  <div class="container">
    <!-- 서브컴퍼넌트 -->
    <!-- 브렌드 -->
    <a class="navbar-brand">게시판<%=dto.getTitle() %></a>
    <!-- 전환 버튼 -->
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar-content" aria-controls="navbar-content" aria-expanded="false" aria-label="Toggle navigation"> 
    <span class="navbar-toggler-icon"></span> </button>
    <!-- 네비게이션 -->
    <div class="collapse navbar-collapse" id="navbar-content">
    	
      <!-- 네비게이션메뉴ー -->
      <!-- 왼쪽 메뉴 : 톱 페이지의 각 콘텐츠에 대한 링크 -->
      <ul class="navbar-nav mr-auto">
        <li class="nav-item active">
          <a class="nav-link" href="mainS.jsp">메인 <span class="sr-only">(current)</span></a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#about">정보</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="bbs?param=bbslist">게시판</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#Download">자료실</a>
        </li>  
        <li class="nav-item">
          <a class="nav-link" href="login.jsp">로그아웃</a>
        </li>  
      </ul>
      <!-- /네비게이션메뉴ー -->
      
    </div>
    <!-- /서브컴퍼넌트 -->
    <p class="welc" align="right">환영합니다 <%=mem.getId() %>님</h4>
  </div>
</nav>
<div id="rightScr">
<!-- /네비게이션바ー -->
<img src="./images/bg-01.jpg" class="rounded float-left" alt="...">
</div>






<div id="leftScr">
<form action="bbs?param=updateAf" method="post">
<input type="hidden" name="seq" value="<%=seq %>">
	<table class="table table-dark table-hover">
	<caption><h1>상세 글 보기</h1></caption>
<colgroup>
	<col style="width: 150">
	<col style="width: 600">
</colgroup>

<tr>
	<th>작성자</th>
	<td>
		<input type="text" name="id" readonly="readonly" size="60" 
			value="<%=mem.getId() %>"> 		
	</td>	
</tr>

<tr>
	<th>제목</th>
	<td>
		<input type="text" name="title" size="60" value="<%=dto.getTitle() %>">		
	</td>
</tr>
<tr>
	<th>내용</th>
	<td>
		<textarea rows="10" cols="60" name="content"><%=dto.getContent() %></textarea>		
	</td>
</tr>
</table>
<div class="utill4">
<input type="submit" class="btn btn-warning" value="완료">
</div>
<div class="utill4">
<button type="button" class="btn btn-warning" OnClick="javascript:history.back(-1)">취소</button>
</div>
</form>
</div>



</body>
</html>