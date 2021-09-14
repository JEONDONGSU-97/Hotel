<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입</title>
<link rel="stylesheet" href="resources/home/css/newbie.css">
</head>
<body>
<section class="signin">
<h1>회원가입</h1>
<div class="signin__card">
	<h2>
        <strong>Welcome!</strong> DS호텔에 오신 것을 환영합니다.
    </h2>
<form method="POST" action="/signin">
	<input type=text name=realname placeholder="이름을 입력하세요." required><br>
	<input type=text name=userid placeholder="아이디를 입력하세요." required><br>
	<input type=password name=passcode1 placeholder="비밀번호를 입력하세요." id="passcode1" required><br>
	<input type=password name=passcode2 placeholder="비밀번호를 확인해주세요." id="passcode2" required><br>
	<%--모바일 번호 : <input type=text name=mobile><br> --%> 
	<input type=submit value="등록" id="sign_check">
</form>
	<div id="button_padding">	
	<button value="취소" onclick="location.href='/'">취소</button>
	</div>
</div>
</section>
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