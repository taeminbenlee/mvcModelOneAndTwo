<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
response.sendRedirect("member?param=login"); //MemberController로 바로 이동. 콘솔에 doProcess가 실행됨, param
%>
</body>
</html>