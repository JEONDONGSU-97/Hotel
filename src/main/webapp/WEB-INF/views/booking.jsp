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
            <select name="room_sort" id="room_sort">
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
            <input type="hidden" id="room_bookcode">
          </p>
        </section>
      </div>

      <div id="hotel_reservation_center">
        <section class="reservation3">
          <h3>객실이름</h3>
          <input type="text" id="customer_room_name" readonly>
          <h3>객실종류</h3>
          <input type="text" id="customer_room_type" readonly>
          <h3>예약기간</h3>
          <input type="date" id="customer_accommodation_period1" readonly>  ~  <input type="date" id="customer_accommodation_period2" readonly>
          <h3>예약인원</h3>
          <input type="number" id="reservation_personnel" required>
          <h3>숙박인원</h3>
          <input type="text" id="accommodation_personnel" readonly>
          <h3>예약자명</h3>
          <input type="text" id="customer_name" size="15px" required>
          <h3>총 숙박비</h3>
          <input type="text" id="all_accommodation_cost" size="15px" readonly>원
          <h3>예약자 모바일</h3>
          <input type="text" id="customer_mobile" required>
          <p>
            <input type="submit" value="예약완료" id="reservation_registration">
            <input type="submit" value="예약취소" id="reservation_cancel">
            <input type="submit" value="예약수정" id="reservation_modify">
            <input type="submit" value="비우기" id="reservation_empty">            
          </p>
        </section>
      </div>  

      <div id="hotel_reservation_right">
        <section class="reservation4">
          <h3>예약된 객실</h3>
            <p>
              <select name="" id="reserved_rooms" size="30" style="width: 300px; height: 500px; overflow: scroll;">

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
	/* $.post("http://localhost:8080/getRoomList",{},function(result){
		console.log(result);//result는 제이슨 데이터를 받기위함.
		$.each(result,function(ndx,value){
			str='<option value="'+value['roomcode']+' '+value['typecode']+'">'+value['roomname']+','+
			value['typename']+','+value['howmany']+','+value['howmuch']+'</option>';
			$('#available_room_list').append(str)
			//str=`<option value="${value['roomcdoe']}">${value['roomname']},${value['typename']},`+
			//`${value['howmany']},${value['howmuch']}</option>`;
			//<option value="2">백두산,Suite Room,8,500000</option>
		});			
	},'json'); */
	/* $.post("http://localhost:8080/getRoomView",{},function(result){
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
	},'json'); */
})
.on('click','#reservation_cancel',function(){
	let bookcode = String($('#room_bookcode').val());
	$.post('http://localhost:8080/deleteReserved',{bookcode:bookcode},
			function(result){
		console.log(result);
		if(result=="ok"){
			$('#reservation_empty').trigger('click'); // 입력란 비우기
			$('#reserved_rooms option:selected').remove(); // room리스트에서 제거.
			$('#room_search').trigger('click'); // 룸서치 누르게 하기
		}
	},'text');
	return false;
})
.on('click','#reservation_modify',function(){
	let bookcode = String($('#room_bookcode').val());
    let roomname = String($('#customer_room_name').val());
	let roomtype = String($('#customer_room_type').val());
	let roomcode = String($('#room_code').val());
	let price = String($('#all_accommodation_cost').val());
	let person = String($('#reservation_personnel').val());
	let howmany = String($('#accommodation_personnel').val());
	let checkin = String($('#customer_accommodation_period1').val());
	let checkout = String($('#customer_accommodation_period2').val());
	let name = String($('#customer_name').val());
	let mobile = String($('#customer_mobile').val());
	// alert(roomname+', '+roomtype+', '+howmany+", "+howmuch)
	// validation (유효성검사)
	if( roomname=='' || roomtype == '' || price == '' || person == '' || howmany == ''
			|| checkin == '' || checkout == '' || name == '' || mobile == '') {
		alert ("누락된값이 있습니다")
		return false;
	}
	/* let roomcode = String($('#room_code').val()); */

	$.post('http://localhost:8080/updateReserved',
			{bookcode:bookcode,person:person,name:name,mobile:mobile},
			function(result){
				if(result=="ok"){				
					$('#room_search').trigger('click');
					$('#reservation_empty').trigger('click');
				}
			},'text');			  
})
.on('click','#reserved_rooms',function(){
	var str = $('#reserved_rooms option:selected').text(); // option 값 가져오기
	var str1 = $('#reserved_rooms').val(); // value에서 typecode 가져오기
	var pk = String(str1).split(" "); // typecode를 가져오기 위해 split
	var typecode = parseInt(pk[1]); // int로 타입변환
	var room = String(str).split(','); // option에서 가져온 값들 배열로 슬라이싱
	
	var roomname = room[0]
	var roomtype = room[1]
	var checkin = room[2]
	var checkout = room[3]
	var person = room[4]
	var name = room[5]
	var mobile = room[6]
	var howmany = room[7]
	var price = room[8]
	$('#customer_room_name').val(roomname); // input은 value로 화면출력
	$('#customer_room_type').val(roomtype);
	$('#customer_accommodation_period1').val(checkin);
	$('#customer_accommodation_period2').val(checkout);
	$('#reservation_personnel').val(person);
	$('#customer_name').val(name);
	$('#customer_mobile').val(mobile);
	$('#accommodation_personnel').val(howmany);
	$('#all_accommodation_cost').val(price);
	$('#customer_accommodation_period1').prop("readonly", true);
	$('#customer_accommodation_period2').prop("readonly", true);
	$('#reservation_registration').prop("disabled", true);
	$('#reservation_modify').prop("disabled", false);
	/* $('#accommodation_personnel').val(); */	
	let code = parseInt(pk[0]);
	let bookcode = parseInt(pk[2])
	$('#room_code').val(code);
	$('#room_bookcode').val(bookcode)
	console.log($('#room_code').val(),$('#room_bookcode').val());
})
.on('click','#room_search',function(){
	$('#customer_accommodation_period1').val($('#checkin1').val());
	$('#customer_accommodation_period2').val($('#checkout1').val());
	var checkin = $('#customer_accommodation_period1').val();
	var checkout = $('#customer_accommodation_period2').val();
	var typecode = $('#room_sort option:selected').val();
	console.log(checkin,checkout,typecode);
	$.post("http://localhost:8080/getRoomList",
			{checkin:checkin,checkout:checkout,typecode:typecode},
			function(result){
		console.log(result);//result는 제이슨 데이터를 받기위함.
		$('#available_room_list').empty();
		$.each(result,function(ndx,value){
			str='<option value="'+value['roomcode']+' '+value['typecode']+'">'+value['roomname']+','+
			value['typename']+','+value['howmany']+','+value['howmuch']+'</option>';
			$('#available_room_list').append(str)
			//str=`<option value="${value['roomcdoe']}">${value['roomname']},${value['typename']},`+
			//`${value['howmany']},${value['howmuch']}</option>`;
			//<option value="2">백두산,Suite Room,8,500000</option>
		});			
	},'json');
	$.post("http://localhost:8080/getRoomView",
			{checkin:checkin,checkout:checkout,typecode:typecode},
			function(result){
		console.log(result);//result는 제이슨 데이터를 받기위함.
		$('#reserved_rooms').empty();
		$.each(result,function(ndx,value){
			str='<option value="'+value['roomcode']+' '+value['typecode']+' '+value['bookcode']+'">'+value['roomname']+','+
			value['typename']+','+value['checkin']+','+value['checkout']+','+
			value['person']+','+value['name']+','+value['mobile']+','+value['howmany']+','+value['price']+'</option>';
			$('#reserved_rooms').append(str)
			//str=`<option value="${value['roomcdoe']}">${value['roomname']},${value['typename']},`+
			//`${value['howmany']},${value['howmuch']}</option>`;
			//<option value="2">백두산,Suite Room,8,500000</option>
		});			
	},'json');
})
.on('click','#reservation_empty',function(){
	$('#roomcode,#customer_room_name,#customer_room_type,#customer_accommodation_period1,#customer_accommodation_period2,#reservation_personnel,#accommodation_personnel,#customer_name,#all_accommodation_cost,#customer_mobile').val('');
})
.on('change','#checkin1,#checkout1',function(){
	let checkin = $('#checkin1').val();
	let checkout = $('#checkout1').val();
	if(checkin == '' || checkout == '' ) return false;
	checkin = new Date(checkin);
	checkout = new Date(checkout);
	if(checkin > checkout){
		alert('체크인날짜가 체크아웃보다 나중일 수 없습니다.');
		return false;
	}

})
.on('click','#available_room_list',function(){
	$('#reservation_empty').trigger('click');
	$('#customer_accommodation_period1').val($('#checkin1').val());
	$('#customer_accommodation_period2').val($('#checkout1').val());
	$('#customer_accommodation_period1').prop("readonly", true);
	$('#customer_accommodation_period2').prop("readonly", true);
	var str = $('#available_room_list option:selected').text(); // option 값 가져오기
	var str1 = $('#available_room_list').val(); // value에서 typecode 가져오기
	var pk = String(str1).split(" "); // typecode를 가져오기 위해 split
	var typecode = parseInt(pk[1]); // int로 타입변환
	var room = String(str).split(','); // option에서 가져온 값들 배열로 슬라이싱
	
	var roomname = room[0]
	var roomtype = room[1]
	var howmany = room[2]
	var howmuch = room[3]
	
/* 	if(typecode==1){
		$('#room_sort').val(1).prop("selected", true);
	}else if(typecode==2){
		$('#room_sort').val(2).prop("selected", true);
	}else if(typecode==3){
		$('#room_sort').val(3).prop("selected", true);
	}else if(typecode==4){
		$('#room_sort').val(4).prop("selected", true);
	} */
	$('#customer_room_name').val(roomname); // input은 value로 화면출력
	$('#customer_room_type').val(roomtype);
	$('#accommodation_personnel').val(howmany);	
	let code = parseInt(pk[0]);
	$('#room_code').val(code);
	let checkin = $('#checkin1').val();
	let checkout = $('#checkout1').val();
	checkin = new Date(checkin);
	checkout = new Date(checkout);
	let ms = Math.abs(checkout-checkin);
	let days = Math.ceil(ms/(1000*60*60*24));
	let total = days*parseInt(room[3]);
	$('#all_accommodation_cost').val(total);
	$('#reservation_registration').prop("disabled", false);
	$('#reservation_modify').prop("disabled", true);
	console.log(room[3]);
})
/* .on('blur','#customer_accommodation_period2',function(){
	var str = $('#available_room_list option:selected').text();
	var checkin = String($('#customer_accommodation_period1').val());
    var checkout = String($('#customer_accommodation_period2').val());
    var room = String(str).split(',');
	var p = checkin.split('-');
    var p1 = checkout.split('-');
    p=parseInt(p[2]);
    p1=parseInt(p1[2]);
    $('#all_accommodation_cost').val((p1-p)*parseInt(room[3]));
}) */
.on('click','#reservation_registration',function(){
	let roomcode = String($('#room_code').val());
	let price = String($('#all_accommodation_cost').val());
	let person = String($('#reservation_personnel').val());
	let checkin = String($('#customer_accommodation_period1').val());
	let checkout = String($('#customer_accommodation_period2').val());
	let name = String($('#customer_name').val());
	let mobile = String($('#customer_mobile').val());
	
	if(person == '' || name == '' || mobile == '') {
		alert('누락된 값이 있습니다.')
		return false;
	} else if(($('#accommodation_personnel').val() < person) || (person < 0)) {
		alert('숙박인원보다 예약인원이 많거나, 유효하지 않는 숫자를 입력하신거 같아요!')
		return false;
	}
	else {
		$.post('http://localhost:8080/addBooking',
				{roomcode:roomcode,price:price,person:person,checkin:checkin,checkout:checkout,name:name,mobile:mobile},function(result){
					if(result=="ok"){
						$('#reservation_empty').trigger('click');
						/* location.reload(); */
						$('#room_search').trigger('click');
						
					}
				},'text');
		console.log(roomcode,price,person,checkin,checkout,name,mobile);
	}
})

</script>
</html>