package com.matzip.app.djc.domain;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

@Alias("MemberBean")
public class MemberBean {
	Timestamp day;
	String id;
	String password;
	String nickname;
	String phone;
	String zipCode;
	String address1;
	String address2;
	String photo;
	String grade;
	
	

	public Timestamp getDay() {
		return day;
	}
	public void setDay(Timestamp day) {
		this.day = day;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getZipCode() {
		return zipCode;
	}
	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	
	public void printMemberInfo(){
		System.out.println("\n-----------\n");
		System.out.println("id : "+id);
		System.out.println("nickname : " + nickname);
		System.out.println("phone : " + phone);
		System.out.println("photo : " + photo);
		System.out.println("grade : " + (grade.equals("1")?"�Ϲ� ȸ��":"��Ÿ"));
		System.out.println("\n-----------\n");

	}
	
	
}
