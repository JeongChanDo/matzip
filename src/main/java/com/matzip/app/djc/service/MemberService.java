package com.matzip.app.djc.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.matzip.app.djc.dao.ArticleDao;
import com.matzip.app.djc.dao.MemberDao;
import com.matzip.app.djc.domain.ArticleBean;
import com.matzip.app.djc.domain.MemberBean;
import com.matzip.app.djc.etc.AjaxLoginRequest;
import com.matzip.app.djc.etc.AjaxLoginRequestResult;

@Service
public class MemberService {

	@Autowired
	MemberDao memberDao;
	
	
	public void loginProcess(HttpServletRequest request){
		String id = request.getParameter("id");
		MemberBean m = memberDao.getMemberBean(id);
		boolean adminMenu = false;
		if(m.getGrade().equals("3")){
			request.getSession().setAttribute("adminMenu", adminMenu);
		}
		
		request.getSession().setAttribute("loginedMember",m );
	}
	
	public AjaxLoginRequestResult loginCheck(AjaxLoginRequest request){
		return memberDao.loginCheck(request);
	}
	
	public int idCheck(String id){
		return memberDao.idCheck(id);
	}
	
	
	public String getWeeklyDay(){
		return memberDao.getWeeklyDay();
	}
	public String getMonthlyDay(){
		return memberDao.getMonthlyDay();
	}
	
	public String getSinginCountWeek(){
		return memberDao.getSigninCountWeek();
	}
	

	public String getSinginCountMonth(){
		return memberDao.getSigninCountMonth();
	}
	
	
	
	public List<MemberBean> getMemberBeanList(){
		return memberDao.getMemberList();
	}
	
	public List<MemberBean> getMemberBeanListDesc(){
		return memberDao.getMemberListDesc();
	}
	
	
	public MemberBean getMemberBean(String id){
		return memberDao.getMemberBean(id);
	}
	
	
	public int getTotalMemberCount(){
		return memberDao.getTotalMemberCount();
	}
	
	public void signinProcess(MultipartHttpServletRequest request) throws IllegalStateException, IOException{
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String nickname = request.getParameter("nickname");
		String phone1 = request.getParameter("phone1");
		String phone2 = request.getParameter("phone2");
		String phone3 = request.getParameter("phone3");
		String phone = phone1 +phone2 + phone3;
		String zipCode = request.getParameter("zipCode");
		String address1 = request.getParameter("address1");
		String address2 = request.getParameter("address2");
		
		String sep = File.separator;
		String path = "C:"+sep+"MatZip"+sep+"MatZip"+sep+"src"+sep+"main"+sep
				+"webapp"+sep+"resources"+sep+"memberImages";
		
		MemberBean m = new MemberBean();
		
		m.setId(id);
		m.setPassword(password);
		m.setNickname(nickname);
		m.setPhone(phone);
		m.setZipCode(zipCode);
		m.setAddress1(address1);
		m.setAddress2(address2);
		m.setGrade("1");
		
		MultipartFile multipartFile = null;
		
		
		File file = null;
		String photoCheck = request.getParameter("photoExist");
		if(photoCheck.equals("yes")){
			multipartFile = request.getFile("photo");
			String fileName = multipartFile.getOriginalFilename();
			fileName = fileName.substring(fileName.indexOf("."));
			String imageName = id+fileName;
			System.out.println("imageName");
			file = new File(path,imageName);
			multipartFile.transferTo(file);
			m.setPhoto(imageName);
		}else{
			System.out.println("사진을 등록하지 않았습니다. 디폴트로 합니다.");
			m.setPhoto("default.jpg");
		}
		
		
	
		m.printMemberInfo();
		memberDao.insertMember(m);
	}
}
