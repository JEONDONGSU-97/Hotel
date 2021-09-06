<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>예약관리</title>
<link rel="stylesheet" href="resources/home/css/booking.css">
</head>
<body>
	<div id="hotel_reservation_all">
    <header>
      <a href="/logout">로그아웃</a>
      <p>예약관리</p>
      <a href="room" id="room_management">객실관리</a>
    </header>
    <main>
      <div id="hotel_reservation_left">
        <section class="reservation1">
          <p>
            <h3>예약기간</h3>
            <input type="date" id="checkin1"> ~ <input type="date" id="checkout1">
          </p>
          
          <p>
            <h3>객실분류</h3>
            <select size=4 name="room_sort" id="room_sort">
            	<option value=1>Suite Room</option>
            	<option value=2>Family Room</option>
            	<option value=3>Double Room</option>
            	<option value=4>Single Room</option>
            </select>
            <input type="submit" value="찾기" id="room_search">
          </p>
          <h3>예약가능</h3>
          <p>
            <select size=5 name="available_room_list" id="available_room_list" style="width: 300px; height: 300px;">

            </select>
            <input type="hidden" id="room_code">
          </p>
        </section>
      </div>

      <div id="hotel_reservation_center">
        <section class="reservation3">
          <h3>객실이름</h3>
          <input type="text" id="customer_room_name">
          <h3>객실종류</h3>
          <input type="text" id="customer_room_type">
          <h3>예약기간</h3>
          <input type="date" id="customer_accommodation_period1">  ~  <input type="date" id="customer_accommodation_period2">
          <h3>예약인원</h3>
          <input type="number" id="reservation_personnel">
          <h3>숙박인원</h3>
          <input type="text" id="accommodation_personnel">
          <h3>예약자명</h3>
          <input type="text" id="customer_name" size="15px">
          <h3>총 숙박비</h3>
          <input type="text" id="all_accommodation_cost" size="15px">원
          <h3>예약자 모바일</h3>
          <input type="text" id="customer_mobile">
          <p>
            <input type="submit" value="등록" id="reservation_registration">
            <input type="submit" value="취소" id="reservation_cancel">
            <input type="submit" value="clear" id="reservation_empty">
          </p>
        </section>
      </div>  

      <div id="hotel_reservation_right">
        <section class="reservation4">
          <h3>예약된 객실</h3>
            <p>
              <select name="" id="reserved_rooms" size="30" style="width: 300px; height: 500px;">

              </select>
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
			$('#available_room_list').append(str)
			//str=`<option value="${value['roomcdoe']}">${value['roomname']},${value['typename']},`+
			//`${value['howmany']},${value['howmuch']}</option>`;
			//<option value="2">백두산,Suite Room,8,500000</option>
		});			
	},'json');
	$.post("http://localhost:8080/getRoomView",{},function(result){
		console.log(result);//result는 제이슨 데이터를 받기위함.
		$.each(result,function(ndx,value){
			str='<option value="'+value['roomcode']+' '+value['typecode']+'">'+value['roomname']+','+
			value['typename']+','+value['checkin']+','+value['checkout']+','+
			value['person']+','+value['name']+','+value['mobile']+'</option>';
			$('#reserved_rooms').append(str)
			//str=`<option value="${value['roomcdoe']}">${value['roomname']},${value['typename']},`+
			//`${value['howmany']},${value['howmuch']}</option>`;
			//<option value="2">백두산,Suite Room,8,500000</option>
		});			
	},'json');
})

.on('click','#available_room_list',function(){
	var str = $('#available_room_list option:selected').text(); // option 값 가져오기
	var str1 = $('#available_room_list').val(); // value에서 typecode 가져오기
	var pk = String(str1).split(" "); // typecode를 가져오기 위해 split
	var typecode = parseInt(pk[1]); // int로 타입변환
	var room = String(str).split(','); // option에서 가져온 값들 배열로 슬라이싱
	
	var roomname = room[0]
	var roomtype = room[1]
	var howmany = room[2]
	var howmuch = room[3]
	
	if(typecode==1){
		$('#room_sort').val(1).prop("selected", true);
	}else if(typecode==2){
		$('#room_sort').val(2).prop("selected", true);
	}else if(typecode==3){
		$('#room_sort').val(3).prop("selected", true);
	}else if(typecode==4){
		$('#room_sort').val(4).prop("selected", true);
	}
	
	$('#customer_room_name').val(roomname); // input은 value로 화면출력
	$('#customer_room_type').val(roomtype);
	$('#accommodation_personnel').val(howmany);	
	
	let code = parseInt(pk[0]);
	$('#room_code').val(code);
	return false;
})
.on('blur','#customer_accommodation_period2',function(){
	var str = $('#available_room_list option:selected').text();
	var checkin = String($('#customer_accommodation_period1').val());
    var checkout = String($('#customer_accommodation_period2').val());
    var room = String(str).split(',');
	var p = checkin.split('-');
    var p1 = checkout.split('-');
    p=parseInt(p[2]);
    p1=parseInt(p1[2]);
    $('#all_accommodation_cost').val((p1-p)*parseInt(room[3]));
})
.on('click','#reservation_registration',function(){
	let roomcode = String($('#room_code').val());
	let price = String($('#all_accommodation_cost').val());
	let person = String($('#reservation_personnel').val());
	let checkin = String($('#customer_accommodation_period1').val());
	let checkout = String($('#customer_accommodation_period2').val());
	let name = String($('#customer_name').val());
	let mobile = String($('#customer_mobile').val());
	
	if(roomcode == '' || price == '' || person == '' || checkin == '' ||
			checkout == '' || name == '' || mobile == '') {
		alert('누락된 값이 있습니다.')
		return false;
	} else {
		$.post('http://localhost:8080/addBooking',
				{roomcode:roomcode,price:price,person:person,checkin:checkin,checkout:checkout,name:name,mobile:mobile},function(result){
					if(result=="ok"){
						location.reload();
					}
				},'text');
		console.log(roomcode,price,person,checkin,checkout,name,mobile);
	}
})

</script>
</html>