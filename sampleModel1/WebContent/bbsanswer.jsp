<%@page import="dto.MemberDto"%>
<%@page import="dao.BbsDao"%>
<%@page import="dto.BbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
int seq = Integer.parseInt(request.getParameter("seq").trim());
BbsDto dto = BbsDao.getInstance().getBBS(seq);
System.out.println(dto.toString());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div align="center">

<h2>부모글</h2>

<table border="2">
<col width="200"><col width="500">
<tr>
	<td>작성자</td>
	<td><%=dto.getId() %></td>
</tr>
<tr>
	<td>제목</td>
	<td><%=dto.getTitle() %></td>
</tr>
<tr>
	<td>작성일</td>
	<td><%=dto.getWdate() %></td>
</tr>
<tr>
	<td>조회수</td>
	<td><%=dto.getReadcount() %></td>
</tr>
<tr>
	<td>내용</td>
	<td>
		<textarea rows="10" cols ="50" readonly="readonly"><%=dto.getContent() %></textarea>
	</td>
</tr>


</table>

<%
MemberDto mem = (MemberDto)session.getAttribute("login");
%>

<h2>답글</h2>

<form action="bbsanswerAf.jsp" method="post">
<input type="hidden" name="seq" value="<%=dto.getSeq() %>">

<table border="1">
<col width="200"><col width="500">
<tr>
	<td>아이디</td>
	<td>
		<input type="text" name="id" size="50" readonly="readonly" value="<%=mem.getId() %>">
	</td>
</tr>
<tr>
	<td>제목</td>
	<td>
		<input type="text" name="title" size="50">
	</td>
</tr>
<tr>
	<td>내용</td>
	<td>
		<textarea rows="10" cols="50" name="content"></textarea>
	</td>
</tr>
<tr>
	<td colspan="2">
		<input type="submit" value="답글작성 완료">
	</td>
</tr>
</table>
<input type=button value="취소" OnClick="javascript:history.back(-1)">
</form>
</div>

</body>
</html>