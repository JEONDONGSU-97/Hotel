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
            <h3>숙박기간</h3>
            <input type="date" id="period1"> ~ <input type="date" id="period2">
          </p>
          
          <p>
            <h3>객실분류</h3>
            <select name="room_sort" id="room_sort">
              <option value="Korea">대한민국</option>
              <option value="Japan">일본</option>
              <option value="Italy">이탈리아</option>
              <option value="Switzerland">스위스</option>
              <option value="Germany">독일</option>
              <option value="France">프랑스</option>
              <option value="USA">미국</option>
              <option value="UK">영국</option>
              <option value="Brazil">브라질</option>
              <option value="Singapore">싱가포르</option>
              <option value="Spain">스페인</option>
              <option value="Argentina">아르헨티나</option>
              <option value="Mexico">멕시코</option>
            </select>
            <input type="submit" value="찾기" id="room_search">
          </p>
          <h3>예약가능</h3>
          <p>
            <select size=5 name="available_room_list" id="available_room_list" style="width: 300px; height: 300px;">
              <option value="">대한민국 Suite Room 2명</option>
              <option value="">일본 Family Room 5명</option>
              <option value="">이탈리아 Single Room 1명</option>
              <option value="">스위스 Triple Room 3명</option>
              <option value="">독일 Triple Room 3명</option>
              <option value="">프랑스 Family Room 6명</option>
              <option value="">미국 Family Room 5명</option>
              <option value="">영국 Suite Room 1명</option>
              <option value="">브라질 Family Room 8명</option>
              <option value="">싱가포르 Connection Room 4명</option>
              <option value="">스페인 Triple Room 3명</option>
              <option value="">아르헨티나 Single Room 1명</option>
              <option value="">멕시코 Domitory 4명</option>
            </select>
          </p>
        </section>
      </div>

      <div id="hotel_reservation_center">
        <section class="reservation3">
          <h3>객실이름</h3>
          <input type="text" id="customer_room_name">
          <h3>숙박기간</h3>
          <input type="date" id="customer_accommodation_period">  ~  <input type="date" id="customer_accommodation_period">
          <h3>숙박인원</h3>
          <input type="text" id="accommodation_personnel">
          <h3>1박 비용</h3>
          <input type="text" id="one_night_rate_reservation" size="15px">원
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
              <select name="" id="reserved rooms" size="30" style="width: 300px; height: 500px;">
                  <option value="">영국 Family Room</option>
                  <option value="">브라질 Single Room</option>
                  <option value="">스페인 Suite Room</option>
                  <option value="">싱가포르 Domitory</option>
                  <option value="">아르헨티나 Connection Room</option>
                  <option value="">멕시코 Triple Room</option>
              </select>
            </p>
        </section>
      </div>
    </main>
    <footer>
      
    </footer>
  </div>
</body>
</html>