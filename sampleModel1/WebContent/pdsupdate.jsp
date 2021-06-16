<%@page import="dao.PdsDao"%>
<%@page import="dto.PdsDto"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
MemberDto mem = (MemberDto)session.getAttribute("login");

String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq);

PdsDto dto = PdsDao.getInstance().getPds(seq);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h2>자료 수정</h2>

<div align="center">

<form action="pdsupdateAf.jsp" method="post" enctype="multipart/form-data">
<input type="hidden" name="seq" value="<%=dto.getSeq() %>">

<table border="1">
<col width="200"><col width="500">

<tr>
	<th>아이디</th>
	<td>
		<%=dto.getId() %>
		<input type="hidden" name="id" value="<%=dto.getId() %>">
	</td>
</tr>
<tr>
	<th>제목</th>
	<td>
		<input type="text" name="title" size="50" value="<%=dto.getTitle() %>">
	</td>
</tr>
<tr>
	<th>업로드파일</th>
	<td>
		<input type="text" name="oldfile" size="50" value="<%=dto.getFilename() %>">
		<input type="hidden" name="oldnewfile" size="50" value="<%=dto.getNewFilename() %>">
	</td>
</tr>
<tr>
	<th>변경할 파일 업로드</th>
	<td>
		<input type="file" name="fileload" style="widows: 400px">
	</td>	
</tr>
<tr>
	<th>내용</th>
	<td>
		<textarea rows="20" cols="50" name="content"><%=dto.getContent() %></textarea>
	</td>
</tr>

<tr align="center">
	<td colspan="2">
		<input type="submit" value="수정완료">
	</td>
</tr>

</table>

</form>
</div>

</body>
</html>






