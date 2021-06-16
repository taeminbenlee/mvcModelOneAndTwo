
<%@page import="dto.BbsDto"%>
<%@page import="java.util.List"%>
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
<%!
// 댓글의 depth와 image를 추가하는 함수
// depth = 1	'	'->
// depth = 2	'	'	->
public String arrow(int depth){
	String rs = "<img src='./image/arrow.png' width='20px' height='20px'/>";
	String nbsp =  "&nbsp;&nbsp;&nbsp;&nbsp;";
	
	String ts = "";
	for(int i =0; i<depth; i++){
		ts += nbsp;
	}
	return depth==0 ? "":ts + rs;
}

%>   
<%
// dao 부터 list



String col = request.getParameter("col");
String keyword = request.getParameter("keyword");

BbsDao dao = BbsDao.getInstance();
List<BbsDto> slist = dao.searchBbsList(col, keyword);

%>    

<h1 style="text-align: center">게시판 검색 결과</h1>

<div align="center">
<table border="1">
<col width="70"><col width="600"><col width="150">
<tr>
	<th>번호</th><th>제목</th><th>작성자</th>
</tr>
<%
if(slist == null || slist.size() == 0){
	%>
	<tr>
		<td colspan="3">검색된 글이 없습니다</td>
	</tr>
	<%
} else{
	for(int i = 0;i < slist.size(); i++){
		BbsDto bbs = slist.get(i);
		%>
		<tr>
			<th><%=i + 1 %></th>
			<td>
				<%
				if(bbs.getDel() == 0){
					%>
					<%=arrow( bbs.getDepth() ) %>			
					<a href="bbsdetail.jsp?seq=<%=bbs.getSeq() %>">
						<%=bbs.getTitle() %>
					</a>	
					<%
				}else{
					%>		
					<font color="#ff0000">********* 이 글은 작성자에 의해서 삭제되었습니다</font> 
					<%
				}
				%>
			</td>
			<td align="center"><%=bbs.getId() %></td>
		</tr>
		<%
	}
}
%>
</table>
<br><br>
	<div class="util">
		<a href="bbswrite.jsp">글쓰기</a><br>
			<form name="searchfrm" method="get" action="bbssearch.jsp">
				<select name="col">
					<option value="id">아이디</option>
					<option value="title">글제목</option>
				</select>
				<input type="text" name="keyword" placeholder="입력">
				<button type="submit">재검색</button>
			</form>
			<button type="button" onclick="location.href='bbslist.jsp'">목록</button>
		<a href="login.jsp">로그아웃</a>
	</div>
</div>










</body>
</html>