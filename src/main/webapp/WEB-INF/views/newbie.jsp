<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
<form method="POST" action="home">
	이름 : <input type=text name=realname><br>
	아이디 : <input type=text name=userid><br>
	비밀번호 : <input type=password name=passcode1><br>
	비밀번호 확인 : <input type=password name=passcode2><br>
	모바일 번호 : <input type=text name=mobile><br>
	<input type=submit value="등록">
</form>	
	<button value="취소" onclick="location.href='/home'">취소</button>
</body>
</html>