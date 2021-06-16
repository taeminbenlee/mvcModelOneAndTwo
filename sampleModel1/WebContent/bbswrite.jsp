<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bbswrite.jsp</title>
</head>
<body>

<h1>글추가</h1>

<div align="center">

<!-- 글을 작성 -->
<form action="bbswriteAf.jsp" method="post">

<table border="1">
<col width="200"><col width="400">

<tr>
	<th>아이디</th>
	<td>
		<%-- <input type="text" name="id" size="50px" value="<%=mem.getId() %>"> --%>
		<input type="text" name="id" size="50px" value=${login.id } readonly="readonly">
	</td>
</tr>

<tr>
	<th>제목</th>
	<td>
		<input type="text" name="title" size="50px">
	</td>
</tr>

<tr>
	<th>내용</th>
	<td>
		<textarea rows="20" cols="50px" name="content"></textarea>
	</td>
</tr>
<tr>
	<td colspan="2">
		&nbsp;&nbsp;<input type="submit" value="글쓰기">
	</td>
</tr>

</table>
<input type=button value="취소" OnClick="javascript:history.back(-1)">
</form>
</div>

<script type="text/javascript">

</script>


</body>
</html>