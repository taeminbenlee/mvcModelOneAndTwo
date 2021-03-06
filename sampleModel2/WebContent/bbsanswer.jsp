<%@page import="dao.BbsDao"%>
<%@page import="dto.BbsDto"%>
<%@page import="dto.MemberDto"%>
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

</style>
</head>

<body>
<%
MemberDto mem = (MemberDto)session.getAttribute("login");
%>
<!-- ????????????????????? -->
<nav class="navbar navbar-expand-md navbar-dark bg-dark sticky-top">
  <div class="container">
    <!-- ?????????????????? -->
    <!-- ????????? -->
    <a class="navbar-brand">?????????<%=dto.getTitle() %></a>
    <!-- ?????? ?????? -->
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar-content" aria-controls="navbar-content" aria-expanded="false" aria-label="Toggle navigation"> 
    <span class="navbar-toggler-icon"></span> </button>
    <!-- ??????????????? -->
    <div class="collapse navbar-collapse" id="navbar-content">
    	
      <!-- ???????????????????????? -->
      <!-- ?????? ?????? : ??? ???????????? ??? ???????????? ?????? ?????? -->
      <ul class="navbar-nav mr-auto">
        <li class="nav-item active">
          <a class="nav-link" href="mainS.jsp">?????? <span class="sr-only">(current)</span></a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#about">??????</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="bbs?param=bbslist">?????????</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#Download">?????????</a>
        </li>  
        <li class="nav-item">
          <a class="nav-link" href="login.jsp">????????????</a>
        </li>  
      </ul>
      <!-- /???????????????????????? -->
      
    </div>
    <!-- /?????????????????? -->
    <p class="welc" align="right">??????????????? <%=mem.getId() %>???</h4>
  </div>
</nav>
<div id="rightScr">
<!-- /????????????????????? -->
<img src="./images/bg-01.jpg" class="rounded float-left" alt="...">
</div>

<div id="leftScr">
	<table class="table table-dark table-hover">
	<caption><h1>?????????</h1></caption>
<colgroup>
	<col style="width: 150">
	<col style="width: 600">
</colgroup>

<tr>
	<th>?????????</th>
	<td><%=dto.getId() %></td>
</tr>

<tr>
	<th>??????</th>
	<td><%=dto.getTitle() %></td>
</tr>

<tr>
	<th>?????????</th>
	<td><%=dto.getWdate() %></td>
</tr>
<tr>
	<td>?????????</td>
	<td><%=dto.getReadcount() %></td>
</tr>

<tr>
	<th>??????</th>
	<td align="center">
	<textarea rows="10" cols="90" readonly="readonly"><%=dto.getContent() %></textarea>
	</td>
</tr>
</table>

<h2>Comment</h2>

<form action="bbs?param=answerAf" method="post">
<input type="hidden" name="seq" value="<%=seq %>">

<table class="table table-dark table-hover">
<col width="200"><col width="500">
<tr>
	<td>?????????</td>
	<td>
		<input type="text" name="id" size="50" readonly="readonly" value="<%=mem.getId() %>">
	</td>
</tr>
<tr>
	<td>??????</td>
	<td>
		<input type="text" name="title" size="50">
	</td>
</tr>
<tr>
	<td>??????</td>
	<td>
		<textarea rows="10" cols="50" name="content"></textarea>
	</td>
</tr>
<tr>
	<td colspan="2">
		<input type="submit" class="btn btn-warning" value="???????????? ??????">
	</td>
</tr>
</table>
<input type=button value="??????" class="btn btn-warning" OnClick="javascript:history.back(-1)">
</form>
</div>


</body>
</html>