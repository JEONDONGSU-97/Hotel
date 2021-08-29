<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
      <a href="/logout"><p>로그아웃</p></a>
      <p>객실관리</p>
      <a href="/booking" id="hotel_reservation">예약관리</a>
    </header>

    <main>
      <div id="hotel_room_list_left">
        <section class="room1">
          <h3>객실목록</h3>
          <p>
            <select size=5 name="room_list" id="room_list" style="width: 300px; height: 500px;">
              <option value="">대한민국 Suite Room</option>
              <option value="">프랑스 Suite Room</option>
              <option value="">베트남 Single Room</option>
              <option value="">뉴질랜드 Connection Room</option>
              <option value="">독일 Triple Room</option>
              <option value="">네덜란드 Domitory</option>
              <option value="">미국 Family Room</option>
            </select>
          </p>
        </section>
      </div>

      <div id="hotel_room_list_right">
        <section class="room2" id="hotel_room_list_right2">
          <h3>객실이름</h3>
          <input type="text" id="room_name">
          <h3>객실종류</h3>
          <select name="" id="room_type">
            <option value="">Domitory</option>
            <option value="">Single Room</option>
            <option value="">Double Room</option>
            <option value="">Triple Room</option>
            <option value="">Suite Room</option>
            <option value="">Family Room</option>
            <option value="">Connection Room</option>
          </select>
          <input type="submit" id="" value="선택">
          <h3>숙박가능 인원</h3>
          <select name="" id="number_of_capacity" style="width: 100px;">
            <option value="">1명</option>
            <option value="">2명</option>
            <option value="">3명</option>
            <option value="">4명</option>
            <option value="">5명</option>
            <option value="">6명</option>
            <option value="">7명</option>
            <option value="">8명</option>
          </select>
          <h3>1박 요금</h3>
          <input type="text" id="one_night_rate_room" size="15px">원
          <p>
            <input type="submit" value="등록">
            <input type="submit" value="삭제">
            <input type="submit" value="clear">
          </p>
        </section>
      </div>

    </main>

    <footer>

    </footer>
  </div> 
</body>
</html>