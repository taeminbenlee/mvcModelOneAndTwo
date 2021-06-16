<%@page import="dto.MemberDto"%>
<%@page import="calendar.CalendarDto"%>
<%@page import="calendar.CalendarDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
//request로 seq 가져오기
int seq = Integer.parseInt(request.getParameter("seq").trim());

CalendarDao dao = CalendarDao.getInstance();

CalendarDto dto = dao.getDetail(seq);
%> 

<%
MemberDto mem = (MemberDto)request.getSession().getAttribute("login");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h4 align="right" style="background-color: #f0f0f0">환영합니다 <%=mem.getId() %>님</h4>


<table border="1">
<col width="200"><col width="500">
 
<tr>
    <td>아이디</td>
    <td><%=dto.getId() %></td>
</tr>
 
<tr>
    <td>제목</td>
    <td>
    <input type="text" name="title" value="<%=dto.getTitle() %>">
    </td>
</tr>
 
<tr>
    <td>일정</td>
    <td><%=dto.getRdate() %></td>
</tr>
 
<tr>
    <td>내용</td>
    <td>
        <textarea rows="20" cols="60" name="content"><%=dto.getContent() %>
        </textarea>
    </td>
</tr>

 
</table>

<% 
if(dto.getId().equals(mem.getId())){
%>
<button type="button" onclick="updateEvent(<%=dto.getSeq() %>)">수정</button>
<button type="button" onclick="deleteEvent(<%=dto.getSeq() %>)">삭제</button>


<%
}
%>


<script type="text/javascript">
function updateEvent( seq ) {
	location.href = "calupdate.jsp?seq=" + seq;
}
function deleteEvent( seq ) {
	location.href = "caldel.jsp?seq=" + seq;
}

</script>


</body>
</html>