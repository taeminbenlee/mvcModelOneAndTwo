<%@page import="dao.MemberDao"%>
<%@page import="java.util.List"%>
<%@page import="dao.BbsDao"%>
<%@page import="dto.BbsDto"%>
<%@page import="dto.MemberDto"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
//request로 seq 가져오기
int seq = Integer.parseInt(request.getParameter("seq").trim());
//맴버다오 객체 불러오기
BbsDao dao = BbsDao.getInstance();
//글번호 getBbs seq
BbsDto dto = dao.getBBS(seq);
%> 
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
MemberDto mem = (MemberDto)request.getSession().getAttribute("login");
%>


<h1>상세 글 보기</h1>

<div align="center">

<table border="1">
<colgroup>
	<col style="width: 150">
	<col style="width: 600">
</colgroup>

<tr>
	<th>작성자</th>
	<td><%=dto.getId() %></td>
</tr>

<tr>
	<th>제목</th>
	<td><%=dto.getTitle() %></td>
</tr>

<tr>
	<th>작성일</th>
	<td><%=dto.getWdate() %></td>
</tr>

<tr>
	<th>조회수</th>
	<td><%=dto.getReadcount() %></td>
</tr>

<tr>
	<th>정보</th>
	<td><%=dto.getRef() %>-<%=dto.getStep() %>-<%=dto.getDepth() %></td>
</tr>

<tr>
	<th>내용</th>
	<td align="center">
	<textarea rows="10" cols="90" readonly="readonly"><%=dto.getContent() %></textarea>
	</td>
</tr>
</table>
<% 
if(dto.getId().equals(mem.getId())){
%>
<button type="button" onclick="answerBbs(<%=dto.getSeq() %>)">답글</button>
<button type="button" onclick="updateBbs(<%=dto.getSeq() %>)">수정</button>
<button type="button" onclick="deleteBbs(<%=dto.getSeq() %>)">삭제</button>

<%
}
%>

<form action="answer.jsp" method="get">
	<input type="hidden" name="seq" value="<%=dto.getSeq() %>">
	<input type="submit" value="댓글">
</form>

<button type="button" onclick="location.href='bbslist.jsp'">목록</button>

</div>

<script type="text/javascript">
function updateBbs( seq ) {
	location.href = "bbsupdate.jsp?seq=" + seq;
}
function deleteBbs( seq ) {
	location.href = "bbsdelete.jsp?seq=" + seq;
}
function answerBbs( seq ) {
	location.href = "bbsanswer.jsp?seq=" + seq;
}
</script>

</body>
</html>