package com.matzip.app.kyj.json;

import java.util.List;

public class JsonSearchKeywordResultList{

	List<JsonSearchKeywordResult> resultList;

	public JsonSearchKeywordResultList(){}
	
	public JsonSearchKeywordResultList(List<JsonSearchKeywordResult> resultList){
		this.resultList = resultList;
	}
	
	public List<JsonSearchKeywordResult> getResultList() {
		return resultList;
	}

	public void setResultList(List<JsonSearchKeywordResult> resultList) {
		this.resultList = resultList;
	}
	
	
}
