<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>객실관리</title>
<link rel="stylesheet" href="resources/home/css/room.css">
</head>
<body>
	<div id="hotel_room_all">

    <header>
      <a href="/logout">로그아웃</a>
      <p>객실관리</p>
      <a href="/booking" id="hotel_reservation">예약관리</a>
     
    </header>

	

    <main>
      <div id="hotel_room_list_left">
        <section class="room1">
          <h3>객실목록</h3>
          <p>
            <select size=5 name="room_list" id="room_list" style="width: 300px; height: 500px;">
	           	<%-- <c:forEach items="${list}" var="room">
		      	<option value="${room.roomcode}">${room.roomname},${room.typename},${room.howmany},${room.howmuch}</option>	      	
	    		</c:forEach> --%> 
            </select>
          </p>
        </section>
      </div>

      <div id="hotel_room_list_right">
        <section class="room2" id="hotel_room_list_right2">
          <h3>객실이름</h3>
          <input type="text" id="room_name"><input type="hidden" id="room_code">
          <h3>객실종류</h3>
		  <p>
            <select size=5 name="room_list" id="room_type" style="width: 300px; height: 120px;">
	           	<c:forEach items="${roomtype}" var="type">
		      	<option value="${type.typecode}">${type.name}</option>
	    		</c:forEach>  
            </select>
          </p>

          <h3>숙박가능 인원</h3>
		  <input type="text" id="number_of_capacity">
          <h3>1박 요금</h3>
          <input type="text" id="one_night_rate_room" size="15px">원
          <p>
            <input type="button" value="등록" id="btnAdd">&nbsp;
            <input type="button" value="삭제" id="btnDelete">&nbsp;
            <input type="button" value="취소" id="btnEmpty">
          </p>
        </section>
      </div>

    </main>

    <footer>

    </footer>
  </div> 
</body>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(document)
.ready(function(){
	$.post("http://localhost:8080/getRoomList",{},function(result){
		console.log(result);//result는 제이슨 데이터를 받기위함.
		$.each(result,function(ndx,value){
			str='<option value="'+value['roomcode']+' '+value['typecode']+'">'+value['roomname']+','+
			value['typename']+','+value['howmany']+','+value['howmuch']+'</option>';
			$('#room_list').append(str)
			//str=`<option value="${value['roomcdoe']}">${value['roomname']},${value['typename']},`+
			//`${value['howmany']},${value['howmuch']}</option>`;
			//<option value="2">백두산,Suite Room,8,500000</option>
		});			
	},'json');
})
.on('click','#room_list',function(){
	var str = $('#room_list option:selected').text(); // option 값 가져오기
	var str1 = $('#room_list').val(); // value에서 typecode 가져오기
	var pk = String(str1).split(" "); // typecode를 가져오기 위해 split
	var typecode = parseInt(pk[1]); // int로 타입변환
	var room = String(str).split(','); // option에서 가져온 값들 배열로 슬라이싱
	
	var roomname = room[0]
	var roomtype = room[1]
	var howmany = room[2]
	var howmuch = room[3]
	
	$('#room_name').val(roomname); // input은 value로 화면출력
	$('#number_of_capacity').val(howmany);
	$('#one_night_rate_room').val(howmuch);
	
	if(typecode==1){
		$('#room_type').val(1).prop("selected", true);
	}else if(typecode==2){
		$('#room_type').val(2).prop("selected", true);
	}else if(typecode==3){
		$('#room_type').val(3).prop("selected", true);
	}else if(typecode==4){
		$('#room_type').val(4).prop("selected", true);
	}
	let code = parseInt(pk[0]);
	$('#room_code').val(code);
	return false;
})
.on('click','#btnEmpty',function(){
	$('#room_name,#number_of_capacity,#one_night_rate_room,#room_code').val('');
	$('#room_type option:selected').prop("selected", false);
})
.on('click','#btnDelete',function(){
	$.post('http://localhost:8080/deleteRoom',{roomcode:$('#room_code').val()},
			function(result){
		console.log(result);
		if(result=="ok"){
			$('#btnEmpty').trigger('click'); // 입력란 비우기
			$('#room_list option:selected').remove(); // room리스트에서 제거.
		}
	},'text');
	return false;
})
.on('click','#btnAdd',function(){
	let roomname = String($('#room_name').val());
	let roomtype = String($('#room_type').val());
	let howmany = String($('#number_of_capacity').val());
	let howmuch = String($('#one_night_rate_room').val());
	// alert(roomname+', '+roomtype+', '+howmany+", "+howmuch)
	// validation (유효성검사)
	if( roomname=='' || roomtype == '' || howmany == '' || howmuch == '') {
		alert ("누락된값이 있습니다")
		return false;
	}
	let roomcode = String($('#room_code').val());
	if(roomcode==''){ // insert
		$.post('http://localhost:8080/addRoom',
				{roomname:roomname,roomtype:roomtype,howmany:howmany,howmuch:howmuch},
				function(result){
					if(result=="ok"){
						location.reload();
					}
				},'text');	
	} else { // update
		console.log('roomname ['+roomname+']');
		console.log('roomtype ['+roomtype+']');
		console.log('howmany ['+howmany+']');
		console.log('howmuch ['+howmuch+']');
		console.log('roomcode ['+roomcode+']');
		$.post('http://localhost:8080/updateRoom',
				{roomcode:roomcode,roomname:roomname,
				roomtype:roomtype,howmany:howmany,howmuch:howmuch},
				function(result){
					if(result=="ok"){
						location.reload(); 
					}
				},'text');
	}

})
</script>
</html>