<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
<form method="POST" action="/signin">
	이름 : <input type=text name=realname required><br>
	아이디 : <input type=text name=userid required><br>
	비밀번호 : <input type=password name=passcode1 id="passcode1" required><br>
	비밀번호 확인 : <input type=password name=passcode2 id="passcode2" required><br>
	<%--모바일 번호 : <input type=text name=mobile><br> --%> 
	<input type=submit value="등록" id="sign_check">
</form>	
	<button value="취소" onclick="location.href='/'">취소</button>
</body>
</html>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(document)
.on('click','#sign_check',function(){
	if($('#passcode1').val()!=$('#passcode2').val()){
		alert("비밀번호가 일치하지 않아요.");
		return false;
	}
});
</script>