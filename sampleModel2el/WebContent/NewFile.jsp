<%@page import="dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
System.out.println("NewFile.jsp");
List<BbsDto> list = (List<BbsDto>)session.getAttribute("list");
for(BbsDto bbs : list){
	System.out.println(bbs.toString());
}
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>NewFile.jsp</h3>
</body>
</html>