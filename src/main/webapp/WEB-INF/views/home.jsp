<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<form method="POST" action="/check_user" id="frmLogin">
	아이디 : <input type=text name=userid placeholder="아이디를 입력하세요."><br>
	비밀번호 : <input type=password name=userpassword placeholder="비밀번호를 입력하세요."><br>
	<input type=submit value="로그인">
</form>
	<button value="취소" onclick="location.href='/'">취소</button>
	<button value="회원가입" onclick="location.href='/newbie'">회원가입</button>
</body>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(document)
.on('submit','#frmLogin',function(){
	let pstr = $.trim($('input[name=userid]').val());
	$('input[name=userid]').val(pstr);
	pstr = $.trim($('input[name=userpassword]').val());
	$('input[name=userpassword]').val(pstr);
	if($('input[name=userid]').val()==''){
		alert('로그인 아이디를 입력하시오.')
		return false;
	}
	if($('input[name=userpassword]').val()==''){
		alert('비밀번호를 입력하시오.')
		return false;
	}
	return true;
})
</script>
</html>
