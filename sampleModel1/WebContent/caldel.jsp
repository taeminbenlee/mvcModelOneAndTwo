<%@page import="calendar.CalendarDao"%>
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


CalendarDao dao = CalendarDao.getInstance();
boolean isD = dao.deleteEvent(seq);

if(isD){
	%>
	<script type="text/javascript">
	alert("삭제함");
	location.href = 'calendarlist.jsp';
	
	</script>
	<%	
} else {
	%>
	<script type="text/javascript">
	alert("삭제하지 못했습니다.");
	location.href = 'caldetail.jsp';
	</script>
	<%
}
%>


</body>
</html>