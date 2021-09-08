package com.hotel.app;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	private HttpSession session;
	@Autowired
	private SqlSession sqlSession;
//	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
//	
//	/**
//	 * Simply selects the home view to render by returning its name.
//	 */
//	@RequestMapping(value = "/", method = RequestMethod.GET)
//	public String home(Locale locale, Model model) {
//		logger.info("Welcome home! The client locale is {}.", locale);
//		
//		Date date = new Date();
//		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
//		
//		String formattedDate = dateFormat.format(date);
//		
//		model.addAttribute("serverTime", formattedDate );
//		
//		return "home";
//	}
	@RequestMapping(value="/info")
	public String doInfo(@RequestParam("userid") String uid,
						 @RequestParam("userpassword") int upassword,
						 Model model) {
		model.addAttribute("loginid",uid);
		model.addAttribute("loginpassword", upassword);
		return "home";
	}
	@RequestMapping(value="/check_user",method=RequestMethod.POST)
	public String check_user(HttpServletRequest hsr) {
		String userid=hsr.getParameter("userid");
		String passcode=hsr.getParameter("userpassword");
		iRoom member=sqlSession.getMapper(iRoom.class);
		int n=member.doCheckUser(userid, passcode);
		if(n>0) {
			session=hsr.getSession();
			session.setAttribute("loginid", userid);
			return "redirect:/booking"; //RequestMapping 경로 이름
		} else {
			return "redirect:/";
		}
	}
	@RequestMapping(value="/booking")
	public String doBooking(HttpServletRequest hrs) {
		session = hrs.getSession();
		String loginid = (String)session.getAttribute("loginid");
		if(loginid==null) {
			return "redirect:/";
		}
		else {
			return "booking";
		}		
	}
		
	@RequestMapping(value="/room")
	public String room(HttpServletRequest hsr,Model model) {
		session=hsr.getSession();
		if(session.getAttribute("loginid")==null) {
			return "redirect:/";
		}
		// 여기서 interface호출하고 결과를 room.jsp에 전달.
		iRoom room = sqlSession.getMapper(iRoom.class);
		ArrayList<Roominfo> roominfo = room.getRoomView1();
		model.addAttribute("list", roominfo);
		ArrayList<Roomtype> roomtype = room.getRoomType();
		model.addAttribute("roomtype", roomtype);
		return "room";			
	}
	@RequestMapping(value="/logout")
	public String logout(HttpServletRequest hsr) {
		session=hsr.getSession();
		session.invalidate();
		return "redirect:/";
	}
	@RequestMapping(value="/getRoomList",method=RequestMethod.POST,
			produces = "application/text; charset=utf8")//이게 있어야 콘솔로그 한글 안깨짐
	@ResponseBody
	public String getRoomList(HttpServletRequest hsr) {
		iRoom room = sqlSession.getMapper(iRoom.class);
		String checkin = hsr.getParameter("checkin");
		String checkout = hsr.getParameter("checkout");
		int typecode = Integer.parseInt(hsr.getParameter("typecode"));
		ArrayList<Roominfo> roominfo = room.getRoomList(checkin,checkout,typecode);
		// 찾아진 데이터로 JSONArray만들기
		JSONArray ja = new JSONArray();
		for(int i=0;i<roominfo.size();i++) {
			JSONObject jo = new JSONObject();
			jo.put("roomcode", roominfo.get(i).getRoomcode());
			jo.put("roomname", roominfo.get(i).getRoomname());
			jo.put("typename", roominfo.get(i).getTypename());
			jo.put("howmany", roominfo.get(i).getHowmany());
			jo.put("howmuch", roominfo.get(i).getHowmuch());
			jo.put("typecode", roominfo.get(i).getTypecode());
			ja.add(jo);
		}
		return ja.toString();
	}
	@RequestMapping(value="/getRoomView",method=RequestMethod.POST,
			produces = "application/text; charset=utf8")//이게 있어야 콘솔로그 한글 안깨짐
	@ResponseBody
	public String getRoomView(HttpServletRequest hsr) {
		iRoom room = sqlSession.getMapper(iRoom.class);
		String checkin = hsr.getParameter("checkin");
		String checkout = hsr.getParameter("checkout");
		int typecode = Integer.parseInt(hsr.getParameter("typecode"));
		ArrayList<Roomview> roomview = room.getRoomView(checkin,checkout,typecode);
		// 찾아진 데이터로 JSONArray만들기
		JSONArray ja = new JSONArray();
		for(int i=0;i<roomview.size();i++) {
			JSONObject jo = new JSONObject();
			jo.put("roomcode", roomview.get(i).getRoomcode());
			jo.put("typecode", roomview.get(i).getTypecode());
			jo.put("roomname", roomview.get(i).getRoomname());
			jo.put("typename", roomview.get(i).getTypename());
			jo.put("checkin", roomview.get(i).getCheckin());
			jo.put("checkout", roomview.get(i).getCheckout());
			jo.put("person", roomview.get(i).getPerson());
			jo.put("name", roomview.get(i).getName());
			jo.put("mobile", roomview.get(i).getMobile());
			ja.add(jo);
		}
		return ja.toString();
	}
	@RequestMapping(value="/getRoomView1",method=RequestMethod.POST,
			produces = "application/text; charset=utf8")//이게 있어야 콘솔로그 한글 안깨짐
	@ResponseBody
	public String getRoomView1() {
		iRoom room = sqlSession.getMapper(iRoom.class);
		ArrayList<Roominfo> roominfo = room.getRoomView1();
		// 찾아진 데이터로 JSONArray만들기
		JSONArray ja = new JSONArray();
		for(int i=0;i<roominfo.size();i++) {
			JSONObject jo = new JSONObject();
			jo.put("roomcode", roominfo.get(i).getRoomcode());
			jo.put("typecode", roominfo.get(i).getTypecode());
			jo.put("roomname", roominfo.get(i).getRoomname());
			jo.put("typename", roominfo.get(i).getTypename());
			jo.put("howmany", roominfo.get(i).getHowmany());
			jo.put("howmuch", roominfo.get(i).getHowmuch());
			ja.add(jo);
		}
		return ja.toString();
	}
	
//	@RequestMapping(value="/getRoomBook",method=RequestMethod.POST,
//			produces = "application/text; charset=utf8")//이게 있어야 콘솔로그 한글 안깨짐
//	@ResponseBody
//	public String getRoomBook(HttpServletRequest hsr) {
//		iRoom room = sqlSession.getMapper(iRoom.class);
//		ArrayList<Roombook> roombook = room.getRoomBook();
//		// 찾아진 데이터로 JSONArray만들기
//		JSONArray ja = new JSONArray();
//		for(int i=0;i<roombook.size();i++) {
//			JSONObject jo = new JSONObject();
//			jo.put("roomcode", roombook.get(i).getRoomcode());
//			jo.put("roomname", roombook.get(i).getRoomname());
//			jo.put("typename", roombook.get(i).getTypename());
//			jo.put("howmany", roombook.get(i).getHowmany());
//			jo.put("howmuch", roombook.get(i).getHowmuch());
//			jo.put("typecode", roombook.get(i).getTypecode());
//			ja.add(jo);
//		}
//		return ja.toString();
//	}
	@RequestMapping(value="/deleteRoom",method=RequestMethod.POST,
			produces = "application/text; charset=utf8")
	@ResponseBody
	public String deleteRoom(HttpServletRequest hsr) {
		int roomcode = Integer.parseInt(hsr.getParameter("roomcode"));
		iRoom room = sqlSession.getMapper(iRoom.class);
		room.doDeleteRoom(roomcode);
		return "ok";
	}
	@RequestMapping(value="/deleteReserved",method=RequestMethod.POST,
			produces = "application/text; charset=utf8")
	@ResponseBody
	public String deleteReserved(HttpServletRequest hsr) {
		int roomcode = Integer.parseInt(hsr.getParameter("roomcode"));
		iRoom room = sqlSession.getMapper(iRoom.class);
		room.doDeleteReserved(roomcode);
		return "ok";
	}
	@RequestMapping(value="/addRoom",method=RequestMethod.POST,
			produces = "application/text; charset=utf8")
	@ResponseBody
	public String addRoom(HttpServletRequest hsr) {
		String rname = hsr.getParameter("roomname");
		int rtype = Integer.parseInt(hsr.getParameter("roomtype"));
		int howmany = Integer.parseInt(hsr.getParameter("howmany"));
		int howmuch = Integer.parseInt(hsr.getParameter("howmuch"));
		iRoom room = sqlSession.getMapper(iRoom.class);
		room.doAddRoom(rname, rtype, howmany, howmuch);
		return "ok";
	}
	@RequestMapping(value="/updateRoom", method=RequestMethod.POST, produces="application/text; charset=utf8")
	@ResponseBody
	public String updateRoom(HttpServletRequest hsr) {
		int roomcode = Integer.parseInt(hsr.getParameter("roomcode"));
		String rname = hsr.getParameter("roomname");
		int rtype = Integer.parseInt(hsr.getParameter("roomtype"));
		int howmany = Integer.parseInt(hsr.getParameter("howmany"));
		int howmuch = Integer.parseInt(hsr.getParameter("howmuch"));
		iRoom room = sqlSession.getMapper(iRoom.class);
		room.doUpdateRoom(roomcode, rname, rtype, howmany, howmuch);
		return "ok";
	}
	@RequestMapping(value="/addBooking", method=RequestMethod.POST, produces="application/text; charset=utf8")
	@ResponseBody
	public String addBooking(HttpServletRequest hsr) {
		int roomcode = Integer.parseInt(hsr.getParameter("roomcode"));
		int price = Integer.parseInt(hsr.getParameter("price"));
		int person = Integer.parseInt(hsr.getParameter("person"));
		String checkin = hsr.getParameter("checkin");
		String checkout = hsr.getParameter("checkout");
		String name = hsr.getParameter("name");
		String mobile = hsr.getParameter("mobile");
		iRoom room = sqlSession.getMapper(iRoom.class);
		room.doAddBooking(roomcode, checkin, checkout, person, price, name, mobile);
		return "ok";
	}
	@RequestMapping(value="/")
	public String doMain() {
		return "home";
	}

	@RequestMapping(value="/login")
	public String doLogin() {
		return "login";
	}
	@RequestMapping(value="/newbie")
	public String doNew() {
		return "newbie";
	}
	@RequestMapping(value="/signin",method=RequestMethod.POST,
			produces = "application/text; charset=utf8")
	public String doSignin(HttpServletRequest hsr) {
		String name = hsr.getParameter("realname");
		String loginid = hsr.getParameter("userid");
		String passcode = hsr.getParameter("passcode1"); 
		iRoom signUser  = sqlSession.getMapper(iRoom.class);		
		signUser.doSignin(name, loginid, passcode);
		return "redirect:/";
	}
	@RequestMapping(value="/newinfo",method=RequestMethod.POST)
	public String doNewInfo(@RequestParam("realname") String name,
							@RequestParam("userid") String uid,
							@RequestParam("passcode1") int pass1,
							@RequestParam("passcode2") int pass2,
							@RequestParam("mobile") String umobile,
							Model model) {
		model.addAttribute("name",name);
		model.addAttribute("id",uid);
		model.addAttribute("mobile",umobile);
		return "newinfo";
	}
	@RequestMapping(value="/viewinfo",method=RequestMethod.POST)
	public String doView() {
		return "viewinfo";
	}
}
