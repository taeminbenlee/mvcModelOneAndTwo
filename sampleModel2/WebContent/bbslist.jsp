<%@page import="dto.MemberDto"%>
<%@page import="dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bbslist(Bulletin Board System) = 전자 게시판</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href='https://fonts.googleapis.com/css?family=Rock+Salt' rel='stylesheet' type='text/css'>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" 
integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ"
 crossorigin="anonymous">
<style type="text/css">
h1{color: white;}
h2{font-family: 'Rock Salt', cursive; color: aqua;}
p{font-family: 'Rock Salt', cursive; color: white;}
.nav-link{font-family: 'Nanum Pen Script', cursive; font-size: 30px;}
.welc{font-family: 'Nanum Pen Script', cursive; font-size: 30px;}
.navbar-brand{font-family: 'Nanum Pen Script', cursive; font-size: 30px;}
html {
  font-family: 'helvetica neue', helvetica, arial, sans-serif;
}
#leftScr{width:62.1%; height:100%; float: left;}
#rightScr{width:37.9%; height:100%; float: left;}
body{background-color: black;}
.utill2{float: left;}
.utill3{float: left;}
.utill4{float: left;}

#choice{width: 100px; height: 60px;}
#search{width: 800px; height: 60px;}
</style>
</head>
<%
request.setCharacterEncoding("utf-8");
Object ologin = request.getSession().getAttribute("login");
MemberDto mem = null;

if(ologin == null){
	
	response.sendRedirect("login.jsp");
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
//Conroller부터 list
List<BbsDto> list = (List<BbsDto>)request.getAttribute("list");
int bbsPage = Integer.parseInt((String)request.getAttribute("bbsPage"));
System.out.println("bbsPage:" + bbsPage);

int pageNumber = Integer.parseInt((String)request.getAttribute("pageNumber"));
System.out.println("pageNumber:" + pageNumber);
%>
<script type="text/javascript">
$(document).ready(function() {
	// 검색어 있는 경우
	let search = "<%=search %>";
	if(search == "") return;
	
	// select
	let obj = document.getElementById("choice");
	obj.value = "<%=choice %>";
	obj.setAttribute("selected", "selected");
});
</script>
<body>

<!-- 네비게이션바ー -->
<nav class="navbar navbar-expand-md navbar-dark bg-dark sticky-top">
  <div class="container">
    <!-- 서브컴퍼넌트 -->
    <!-- 브렌드 -->
    <a class="navbar-brand">게시판</a>
    <!-- 전환 버튼 -->
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar-content" aria-controls="navbar-content" aria-expanded="false" aria-label="Toggle navigation"> 
    <span class="navbar-toggler-icon"></span> </button>
    <!-- 네비게이션 -->
    <div class="collapse navbar-collapse" id="navbar-content">
    	
      <!-- 네비게이션메뉴ー -->
      <!-- 왼쪽 메뉴 : 톱 페이지의 각 콘텐츠에 대한 링크 -->
      <ul class="navbar-nav mr-auto">
        <li class="nav-item active">
          <a class="nav-link" href="mainS.jsp">메인 <span class="sr-only">(current)</span></a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#about">정보</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="bbs?param=bbslist">게시판</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#Download">자료실</a>
        </li>  
        <li class="nav-item">
          <a class="nav-link" href="login.jsp">로그아웃</a>
        </li>  
      </ul>
      <!-- /네비게이션메뉴ー -->
      
    </div>
    <!-- /서브컴퍼넌트 -->
    <p class="welc" align="right">환영합니다 <%=mem.getId() %>님</h4>
  </div>
</nav>
<div id="rightScr">
<!-- /네비게이션바ー -->
<img src="./images/bg-01.jpg" class="rounded float-left" alt="...">
</div>

<div id="leftScr">
	<table class="table table-dark table-hover">
	<col width="70"><col width="600"><col width="150">
    <thead>
      <tr>
        <th>번호</th>
        <th>제목</th>
        <th>작성자</th>
      </tr>
    </thead>
    <tbody>

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
					<a href="bbs?param=detail&seq=<%=bbs.getSeq() %>">
						<%=bbs.getTitle() %>
					</a>	
					<%
				}else{
					%>		
					<font color="#ff0000">*** 이 글은 작성자에 의해서 삭제되었습니다</font> 
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
    </tbody>
  </table>
	<br><br>
<div align="center">
<!-- 페이징 	[1] 2 [3] -->
<%
for(int i = 0;i < bbsPage; i++){
	if(pageNumber == i){	// 현재 페이지		[1] 2 [3] 
		%>
		<span style="font-size: 15pt; color: aqua; font-weight: bold;">
			<%=i + 1 %><i class="fas fa-cloud"></i>
		</span>&nbsp;
		<%
	}
	else{
		%>		
		<a href="#none" title="<%=i+1 %>페이지" onclick="goPage(<%=i %>)"
			style="font-size: 15pt; color: blue; font-weight: bold; text-decoration: none">
			[<%=i + 1 %>]<i class="fas fa-bars"></i>
		</a>&nbsp;	
		<%
	}	
}
%>
</div><br>
	<div class="util1" align="center">
		<a href="bbswrite.jsp"><p class="text-info"><b>Write</b><i class="fas fa-thumbs-up"></i></p></a><br>
	</div>
	<div class="utill2">
				<select id="choice" class="form-control" name="sellist1"> 
					<option value="title">제목</option>
					<option value="content">내용</option>
					<option value="writer">작성자</option>
				</select>
	</div>
	<div class="utill3">
				<input type="text" id="search" class="form-control" value="">
	</div>	
	<div class="utill4">		
				<button type="button" class="btn btn-warning" onclick="searchBbs()"><p class="text-info">Search</p></button><br>
	</div>
	<br>
	<div class="utill5">
		<br>
		<a href="login.jsp"><p class="text-info" style="font-size: 20pt; text-align: center;"><b>Sign Out</b></p></a>
	</div>
</div>

<script type="text/javascript">
function searchBbs() {
	let choice = document.getElementById("choice").value;
	let search = document.getElementById("search").value;
//	alert(choice);
//	alert(search);
	
	location.href = "bbs?param=bbslist&choice=" + choice + "&search=" + search;
}

function goPage( pageNum ) {
	let choice = document.getElementById("choice").value;
	let search = document.getElementById("search").value;
	
	location.href = "bbs?param=bbslist&choice=" + choice + "&search=" + search + "&pageNumber=" + pageNum;	
}

</script>


</body>
</html>