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
#rightScr{width:37.9%; height:100%; float: left}
body{background: black;}
h2{font-family: 'Rock Salt', cursive; color: white;}
.form-check-label{font-family: 'Rock Salt', cursive; color: white; margin-left: 500px;}
.form-group{font-family: 'Rock Salt', cursive; width: 300px; margin-left: 500px;}
.buttons{margin-left: 500px;}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript" ></script>

</head>
<body>

	<div id=fullScr>
		<div id=leftScr>
			<form action="member?param=loginAf" method="post">
				 <div class="form-group" style="padding-top: 100px">
				 	<h2 style="color: white; text-align: center;"><br>LOGIN PAGE<br><br></h2>
				 	<br>
				      <label for="usr" style="color: aqua;">Name:</label>
				      <input type="text" class="form-control" id="_id" name="id">
				 </div>
				 <div class="form-group">
				      <label for="pwd" style="color: aqua;">Password:</label>
				      <input type="password" class="form-control" id="pwd" name="pwd">
				 </div>
				 <div class="form-check">
			      <label class="form-check-label" for="check1">
			        <input type="checkbox" class="form-check-input" id="chk_save_id" name="chk_save_id">Remember Me
			      </label>
			    </div>
				<br><br>
				<div class="buttons">
				<input type="submit" class="btn btn-warning" value="Sign In" >
				<button type="button" class="btn btn-warning" onclick="account()">Sign Up</button>
				</div>
			</form>
		</div>
		<div id=rightScr>
			<img src="./images/bg-01.jpg" class="rounded float-left" alt="...">
		</div>
		
	</div>

<script type="text/javascript">
//mvc2방식에서는 뷰로안간다 콘틀로러를 거쳐야함
function account(){
	location.href="member?param=regi";
}
/*
		session	:	Java에서 쓴다.  web server에 저장됨, 자료형은 object
		cookie	:	Java Script에서 사용, client에서 저장됨, 자료형은 String
 */
 
let user_id = $.cookie("user_id");
if(user_id != null){ //저장된 id가 있음
	alert("쿠키 있음");
	$("#_id").val( user_id ); //id="_id"에 user_id를 넣어주어라..
	$("#chk_save_id").attr("checked", "checked"); //체크박스의 체크를 켜준다.
	//$("#chk_save_id").prop("chceked", true);
}
$("#chk_save_id").click(function () {
	if( $("#chk_save_id").is(":checked") ){	//checked가 된 상태라면...
		alert("체크됨");
		if( $("#_id").val().trim()== ""){
			alert('id를 입력해 주십시오');
			$("#chk_save_id").prop("chceked", false);
		}
		else{
			//쿠키를 저장.
			$.cookie("user_id", $("#_id").val().trim(), { expires:7, path:'./'});
		}
	}
	else {	//checked가 안된 상태라면...
		$.removeCookie("user_id", { path:'./'}); //익스파이어 기한 설정을 안해주면 쿠키가 없어진다.
	}
});

</script>

</body>
</html>