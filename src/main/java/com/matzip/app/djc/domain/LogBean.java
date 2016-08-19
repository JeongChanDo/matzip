package com.matzip.app.djc.domain;

import java.util.Date;
import java.util.Map;

public class LogBean {
	Date time;
	String uri;
	String request;
	String ip;
	String id;
	Map<String,String> parameters;

	
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	
	public String getUri() {
		return uri;
	}
	public void setUri(String uri) {
		this.uri = uri;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void printLog(){
		System.out.println("time : " + time + "    uri : " + uri +"     ip : "+ ip);
	}
	public String getRequest() {
		return request;
	}
	public void setRequest(String request) {
		this.request = request;
	}
	public Map<String, String> getParameters() {
		return parameters;
	}
	public void setParameters(Map<String, String> parameters) {
		this.parameters = parameters;
	}
	
	
}
