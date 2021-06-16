<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String content = (String)request.getAttribute("content");
	if (content==null){
		content="main";
	}
%>
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
<body>
<jsp:include page="menu.jsp" flush="false"></jsp:include>



<div id="rightScr">
<!-- /네비게이션바ー -->
<img src="./images/bg-01.jpg" class="rounded float-left" alt="...">
</div>




<div id="leftScr">
<jsp:include page='<%=content + ".jsp" %>' flush="false"></jsp:include>
</div>






</body>
</html>