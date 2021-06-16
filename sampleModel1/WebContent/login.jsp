<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.center{
margin: auto;
width: 60%;
border: 3px solid #00BFFF;
padding: 10px;

}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript" ></script>

</head>
<body>

<h2>login page</h2>
<div class="center">

<form action="loginAf.jsp" method="post">


<table border="1">
<tr>
	<th>아이디</th>
	<td>
		<input type="text" id="_id" name="id" size="20"><br>
		<input type="checkbox" id="chk_save_id">save id
	</td>
</tr>
<tr>
	<th>패스워드</th>
	<td>
		<input type="password" name="pwd" size="20">
	</td>
</tr>
<tr>
	<td colspan="2">
		<input type="submit" value="로그인" >
		<button type="button" onclick="account()">회원가입</button>
	</td>
</tr>
</table>


</form>


</div>
<script type="text/javascript">
function account(){
	location.href="regi.jsp";
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