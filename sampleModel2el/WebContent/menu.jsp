<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <link rel="stylesheet" href="./bootstrap/bootstrap.min.css"> -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href='https://fonts.googleapis.com/css?family=Rock+Salt' rel='stylesheet' type='text/css'>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<style type="text/css">
h1{color: white;}
h2{font-family: 'Rock Salt', cursive; color: aqua;}
p{font-family: 'Rock Salt', cursive; color: white;}
.nav-link{font-family: 'Nanum Pen Script', cursive; font-size: 30px;}
.navbar-brand{font-family: 'Nanum Pen Script', cursive; font-size: 30px;}
.welc{font-family: 'Nanum Pen Script', cursive; font-size: 30px;}
html {
  font-family: 'helvetica neue', helvetica, arial, sans-serif;
}
#leftScr{width:62.1%; height:100%; float: left;}
#rightScr{width:37.9%; height:100%; float: left;}
body{background-color: black;}
.texts{margin-left: 200px; margin-right: 200px;}
</style>
</head>
<%Object ologin=session.getAttribute("login"); 
MemberDto mem = null;
if(ologin == null){
	%>	
	<script>
	alert('로그인 해 주십시오');
	location.href = "login.jsp";
	</script>	
	<%
}
mem = (MemberDto)ologin;
%> 
<body>
<!-- 네비게이션바ー -->
<nav class="navbar navbar-expand-md navbar-dark bg-dark sticky-top">
  <div class="container">
    <!-- 서브컴퍼넌트 -->
    <!-- 브렌드 -->
    <a class="navbar-brand" href="mainS.jsp">MY PAGE</a>
    <!-- 전환 버튼 -->
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar-content" aria-controls="navbar-content" aria-expanded="false" aria-label="Toggle navigation"> 
    <span class="navbar-toggler-icon"></span> </button>
    <!-- 네비게이션 -->
    <div class="collapse navbar-collapse" id="navbar-content">
      <!-- 네비게이션메뉴ー -->
      <!-- 왼쪽 메뉴 : 톱 페이지의 각 콘텐츠에 대한 링크 -->
      <ul class="navbar-nav mr-auto">
        <li class="nav-item active">
          <a class="nav-link" href="index.jsp?content=mainS">메인 <span class="sr-only">(current)</span></a>
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
          <a class="nav-link" href="index.jsp?content=login">로그아웃</a>
        </li>  
      </ul>
      <!-- /네비게이션메뉴ー -->
    </div>
    <!-- /서브컴퍼넌트 -->
     <p class="welc" align="right">환영합니다 <%=mem.getId() %>님</h4>
  </div>
</nav>
</body>
</html>