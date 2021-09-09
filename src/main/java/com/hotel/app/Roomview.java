package com.hotel.app;

public class Roomview {
	private int roomcode;
	private int typecode;
	private String roomname;
	private String typename;
	private String checkin;
	private String checkout;
	private int person;
	private String name;
	private String mobile;
	private int howmany;
	private int price;
	private int bookcode;
	public Roomview() {
		
	}
	public Roomview(int roomcode, int typecode, String roomname, String typename, String checkin, String checkout, int person, String name,
			String mobile, int howmany, int price, int bookcode) {
		this.roomname = roomname;
		this.typename = typename;
		this.bookcode = bookcode;
		this.checkin = checkin;
		this.checkout = checkout;
		this.person = person;
		this.name = name;
		this.mobile = mobile;
		this.roomcode = roomcode;
		this.typecode = typecode;
		this.howmany = howmany;
		this.price = price;
	}
	public int getBookcode() {
		return bookcode;
	}
	public void setBookcode(int bookcode) {
		this.bookcode = bookcode;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getHowmany() {
		return howmany;
	}
	public void setHowmany(int howmany) {
		this.howmany = howmany;
	}

	public int getRoomcode() {
		return roomcode;
	}
	public void setRoomcode(int roomcode) {
		this.roomcode = roomcode;
	}
	public int getTypecode() {
		return typecode;
	}
	public void setTypecode(int typecode) {
		this.typecode = typecode;
	}
	public String getRoomname() {
		return roomname;
	}
	public void setRoomname(String roomname) {
		this.roomname = roomname;
	}
	public String getTypename() {
		return typename;
	}
	public void setTypename(String typename) {
		this.typename = typename;
	}
	public String getCheckin() {
		return checkin;
	}
	public void setCheckin(String checkin) {
		this.checkin = checkin;
	}
	public String getCheckout() {
		return checkout;
	}
	public void setCheckout(String checkout) {
		this.checkout = checkout;
	}
	public int getPerson() {
		return person;
	}
	public void setPerson(int person) {
		this.person = person;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}  
}
