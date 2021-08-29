package com.hotel.app;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	private HttpSession session;
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
	public String check_user(HttpServletRequest hsr, Model model) {
		String userid=hsr.getParameter("userid");
		String passcode=hsr.getParameter("userpassword");
		
		session=hsr.getSession(); // session을 사용가능하게 만든다.(메소드 쓸때마다 1번씩 사용해야한다.)
		session.setAttribute("loginid", userid);
		session.setAttribute("loginpw", passcode);
		
		return "redirect:/booking"; // RequestMapping의 경로이름
	}
	@RequestMapping(value="/booking",method=RequestMethod.GET)
	public String booking(HttpServletRequest hsr) {
		session=hsr.getSession();
		String loginid=(String)session.getAttribute("loginid");
		String loginpw=(String)session.getAttribute("loginpw");
		if(loginid.equals("jds")&&loginpw.equals("1234")) {
			return "booking"; // JSP 파일 이름
		} else {
			return "redirect:/home";
		}
		
	}
	@RequestMapping(value="/room")
	public String room(HttpServletRequest hsr) {
		session=hsr.getSession();
		if(session.getAttribute("loginid")==null) {
			return "redirect:/home";
		}
		return "room";
	}
	@RequestMapping(value="/logout")
	public String logout(HttpServletRequest hsr) {
		session=hsr.getSession();
		session.invalidate();
		return "redirect:/home";
	}
	@RequestMapping(value="/")
	public String doMain() {
		return "home";
	}
	@RequestMapping(value="/home")
	public String doHome() {
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
