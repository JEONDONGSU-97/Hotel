<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Home</title>
<link rel="stylesheet" href="resources/home/css/home.css">
</head>
<body>
<section class="signin">
<h1>로그인</h1>
<div class="signin__card">
	<h2>
        <strong>Welcome!</strong> DS호텔에 오신 것을 환영합니다.
    </h2>
<form method="POST" action="/check_user" id="frmLogin">
	<input type=text name=userid placeholder="아이디를 입력하세요."><br>
	<input type=password name=userpassword placeholder="비밀번호를 입력하세요."><br>
	<input type=submit value="로그인">
</form>
	<div class="actions">
	<button value="취소" onclick="location.href='/'">취소</button>
	<button value="회원가입" onclick="location.href='/newbie'">회원가입</button>
	</div>
</div>
</section>
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
