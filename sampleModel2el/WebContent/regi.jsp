<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href='https://fonts.googleapis.com/css?family=Rock+Salt' rel='stylesheet' type='text/css'>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style type="text/css">
#leftScr{width:62.1%; height:100%; float: left;}
#rightScr{width:37.9%; height:100%; float: left;}
body{background: black;}
h2{font-family: 'Rock Salt', cursive; color: white;}
.form-check-label{font-family: 'Rock Salt', cursive; color: white;}
.form-group{font-family: 'Rock Salt', cursive;}
</style>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<body>

<div id=leftScr>

<p>Welcome</p>
<form action="member?param=accountCompt" method="post">
	<div class="form-group" style="padding-top: 100px">
		<h2 style="color: white; text-align: center;"><br>Sign Up PAGE<br><br></h2>
		<br>
		<label for="usr" style="color: aqua;">ID:</label>
		<input type="text" class="form-control" id="_id" name="id" size="20">
		<!-- id 확인 (ajax) p, button-->
		<button type="button" id="btn" class="btn btn-warning">ID Check</button>
	</div>
	<div class="form-group">
		<label for="pwd" style="color: aqua;">PASSWORD:</label>
		<input type="password" class="form-control" name="pwd" id="_pwd" size="20">
	</div>
	<div class="form-group">
		<label for="name" style="color: aqua;">NAME:</label>
		<input type="text" class="form-control" name="name" size="20">
	</div>	
	<div class="form-group">
		<label for="email" style="color: aqua;">EMAIL:</label>
		<input type="text" class="form-control" name="email" size="20">
	</div>
<br><br>

				<input type="submit" class="btn btn-warning" value="SIGN UP" >
				

	
<span id="available"> 
</span>

</form>
</div>

<div id=rightScr>
			<img src="./images/bg-01.jpg" class="rounded float-left" alt="...">
		</div>
<script type="text/javascript">
$(function () {
	
	$("#btn").click(function () {
		
		$.ajax({
			type: "post",
			url: "member?param=idcheck",
		//	data: "id=" + $("#_id").val(),
			data: { "id":$("#_id").val() },
			success:function( data ){
				alert('success');	
				
			 	if(data.msg == "YES"){
					$("#idcheck").css("color", "#0000ff");
					$("#idcheck").html('사용할 수 있는 id입니다');
				}else{
					$("#idcheck").css("color", "#ff0000");
					$("#idcheck").html('사용할 수 없는 id입니다');
					$("#_id").val("");
				} 
				  
			},
			error:function(){
				alert('error');
			}			
		});
		
	});	
	function regiaf(){
		location.href="member?param=regiAf";
	}
});
</script>
</body>
</html>
