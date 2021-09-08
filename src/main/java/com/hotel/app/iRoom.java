package com.hotel.app;

import java.util.ArrayList;

public interface iRoom {
	ArrayList<Roominfo> getRoomList(String checkin, String checkout, int typecode);
//	ArrayList<Roombook> getRoomBook();
	ArrayList<Roomtype> getRoomType();
	ArrayList<Roomview> getRoomView(String checkin, String checkout, int typecode);
	ArrayList<Roominfo> getRoomView1();
	void doDeleteRoom(int roomcode);
	void doDeleteReserved(int roomcode);
	void doAddRoom(String roomname, int roomtype, int howmany, int howmuch);
	void doUpdateRoom(int roomcode, String roomname, int roomtype, int howmany, int howmuch);
	void doSignin(String name, String loginid, String passcode);
	int doCheckUser(String userid, String passcode);
	void doAddBooking(int roomcode, String checkin, String checkout, int person, int price, String name, String mobile);
}
