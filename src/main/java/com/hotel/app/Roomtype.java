package com.hotel.app;

public class Roomtype {
	private String name;
	private int typecode;
	public Roomtype() {}
	public Roomtype(String name, int typecode) {
//		super();
		this.name = name;
		this.typecode = typecode;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getTypecode() {
		return typecode;
	}
	public void setTypecode(int typecode) {
		this.typecode = typecode;
	}
		
}
