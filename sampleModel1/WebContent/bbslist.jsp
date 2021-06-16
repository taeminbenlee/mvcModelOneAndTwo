<%@page import="dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.BbsDao"%>
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
String choice = request.getParameter("choice");
String search = request.getParameter("search");
if(choice == null){
	choice = "";
}
if(search == null){
	search = "";
}
%>
<%
// dao 부터 list
BbsDao dao = BbsDao.getInstance();

String spageNumber = request.getParameter("pageNumber");
int pageNumber = 0; //현재 페이지
if(spageNumber != null && !spageNumber.equals("")){	//페이지번호를 클릭했을때
	pageNumber = Integer.parseInt(spageNumber);
}
System.out.println("pageNumber: "+pageNumber);


//List<BbsDto> list = dao.getBbsList();
List<BbsDto> list = dao.getBbsPagingList(choice, search, pageNumber);

int len = dao.getAllBbs(choice, search);
System.out.println("총글의수" + len);

int bbsPage = len / 10;	// 만약 23개의 글이면 나누면 2가 나오고 나머지 3이 있으니.. bbsPage에 +1을 해주자.
if((len % 10) > 0){
	bbsPage = bbsPage +1;
}

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bbslist(Bulletin Board System) = 전자 게시판</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script type="text/javascript">
$(document).ready(function () {
	let search = "<%=search%>";
	if (search == "") return;
	
	let obj = document.getElementById("choice");
	obj.value="<%=choice%>";
	obj.setAttribute("selected", "selected");
});

</script>

</head>
<body>
<h4 align="right" style="background-color: #f0f0f0">환영합니다<%=mem.getId() %></h4>


<h1 align="center">게시판</h1>
<br>
<a href="calendarlist.jsp">일정관리</a>
<br>
<a href="pdslist.jsp">자료실</a>
<br>

<div align="center">
<table border="1">
<col width="70"><col width="600"><col width="150">
<tr>
	<th>번호</th><th>제목</th><th>작성자</th>
</tr>
<%
if(list == null || list.size() == 0){
	%>
	<tr>
		<td colspan="3">작성된 글이 없습니다</td>
	</tr>
	<%
} else{
	for(int i = 0;i < list.size(); i++){
		BbsDto bbs = list.get(i);
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
<!-- 페이징  [1] [2] [3]-->
<%
for(int i=0;i<bbsPage; i++){
	if(pageNumber == i){ //현재 선택한 페이지 표현
		%>
		<span style="font-size: 15pt; color: blue; font-weight: bold;">
			<%=i + 1 %>
		</span>
		<%
	} 
	else {	//그외 선택안한 페이지
		 %>
		 <a href="#none" title="<%=i+1 %>페이지 " onclick="goPage(<%=i %>)" 
		 style="font-size: 15pt; color: black; font-weight: bold; text-decoration: none;">
		 	[<%=i+1 %>]
		 </a>
		 
		 <%
	}
	
}

%>


<br><br>

	<div class="util">
		<a href="bbswrite.jsp">글쓰기</a><br>

				<select id="choice"> 
					<option value="title">제목</option>
					<option value="content">내용</option>
					<option value="writer">작성자</option>
				</select>
				<input type="text" id="search" value="<%=search%>">
				<button type="button" onclick="searchBbs()">검색</button>
		<br><br>
		<a href="login.jsp">로그아웃</a>
	</div>
</div>

<script type="text/javascript">
function searchBbs() {
	let choice = document.getElementById("choice").value;
	let search = document.getElementById("search").value;
//	alert(choice);
//	alert(search);
	
	location.href = "bbslist.jsp?choice=" + choice + "&search=" + search;
}
function goPage(pageNum) {
	let choice = document.getElementById("choice").value;
	let search = document.getElementById("search").value;
	
	location.href = "bbslist.jsp?choice=" + choice + "&search=" + search + "&pageNumber=" + pageNum;
}
</script>








</body>
</html>