<%@page import="dao.BbsDao"%>
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
int seq = Integer.parseInt( request.getParameter("seq"));

BbsDao dao = BbsDao.getInstance();
boolean isD = dao.deleteBbs(seq);

if(isD){
	%>
	<script type="text/javascript">
	alert("삭제함");
	location.href = 'bbslist.jsp';
	
	</script>
	<%	
} else {
	%>
	<script type="text/javascript">
	alert("삭제하지 못했습니다.");
	location.href = 'bbslist.jsp';
	</script>
	<%
}
%>
</body>
</html>