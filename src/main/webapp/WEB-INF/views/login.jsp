<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
<body>
<form method="POST" action="/check_user">
	아이디 : <input type=text name=userid><br>
	비밀번호 : <input type=password name=userpassword><br>
	<input type=submit value="로그인">
</form>
	<button value="취소" onclick="location.href='/home'">취소</button>
</body>
</html>