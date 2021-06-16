<%@page import="dto.MemberDto"%>
<%@page import="dto.PdsDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.PdsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
PdsDao dao = PdsDao.getInstance();
List<PdsDto> list = dao.getPdsList();

MemberDto mem = (MemberDto)session.getAttribute("login");
%>    
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</head>
<body>

<h2>자료실</h2>

<div align="center">

<table class="table table-hover" style="width: 1000px">
<col width="70"><col width="100"><col width="400"><col width="100">
<col width="80"><col width="120"><col width="120">
<thead>
<tr>
	<th>번호</th><th>작성자</th><th>제목</th><th>다운로드</th>
	<th>조회수</th><th>다운로드수</th><th>작성일</th>
</tr>
</thead>

<tbody>
<%
if(list.size() == 0){
%>
	<tr>
		<td colspan="7">자료가 없습니다</td>
	</tr>
<%
}else{
	
	for(int i = 0;i < list.size(); i++){
		PdsDto pds = list.get(i);	
		%>
		<tr align="center" height="5">
			<th><%=i+1 %></th>
			<td><%=pds.getId() %></td>
			<td>
				<a href="pdsdetail.jsp?seq=<%=pds.getSeq() %>">
					<%=pds.getTitle() %>
				</a>
			</td>
			<td>
				<input type="button" name="btndown" value="파일"
					onclick="location.href='filedown?filename=<%=pds.getNewFilename() %>&seq=<%=pds.getSeq() %>'">       
			</td>
			<td><%=pds.getReadcount() %></td>
			<td><%=pds.getDowncount() %></td>
			<td><%=pds.getRegdate() %></td>
		</tr>
		<%
	}
}
%>
</tbody>
</table>

<br>

<a href="pdswrite.jsp">자료 올리기</a>

</div>


</body>
</html>













