<%@page import="calendar.CalendarDto"%>
<%@page import="calendar.CalendarDao"%>

<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Object ologin = session.getAttribute("login");
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

<%
String seq = request.getParameter("seq").trim();
int sseq = Integer.parseInt(seq);

CalendarDao dao = CalendarDao.getInstance();

CalendarDto dto = dao.getDetail(sseq);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>일정수정</h1>

<div align="center">

<form action="calupdateAf.jsp" method="post">
<input type="hidden" name="seq" value="<%=seq %>">
         
<table border="1">
<col width="200"><col width="500"> 

<tr>
   <th>아이디</th>
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
<tr>
   <td colspan="2">
      <input type="submit" value="일정내역수정">
   </td>
</tr>

</table>

</form>

</div>

</body>
</html>