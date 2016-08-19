package com.matzip.app.kyj.json;

import java.util.List;

import com.matzip.app.kyj.domain.Matzip;


public class JsonMatzipList {
	
	private List<Matzip> matzipList;
	
	public JsonMatzipList() { }
	
	public JsonMatzipList(List<Matzip> matzipList) {
		this.matzipList = matzipList;
	}
	public List<Matzip> getMatzipList() {
		return matzipList;
	}
	public void setMatzipList(List<Matzip> matzipList) {
		this.matzipList = matzipList;
	}	
}
