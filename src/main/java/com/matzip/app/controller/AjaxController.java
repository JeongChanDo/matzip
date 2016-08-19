package com.matzip.app.controller;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.matzip.app.djc.etc.AjaxIdCheckRequest;
import com.matzip.app.djc.etc.AjaxIdCheckRequestResult;
import com.matzip.app.djc.etc.AjaxLoginRequest;
import com.matzip.app.djc.etc.AjaxLoginRequestResult;
import com.matzip.app.djc.service.MemberService;

@RequestMapping("/ajax")
@Controller
public class AjaxController {

	@Autowired
	MemberService memberService;
	

	@RequestMapping("/loginCheck")	//ResponseBody 응답본문에다 자바객체를 Json 또는 xml로 만들어 넣는다.
	@ResponseBody	//RequestBody 요청본문 json 또는 xml 을 자바객체로 만들어준다.  
	public AjaxLoginRequestResult loginCheck(@RequestBody AjaxLoginRequest request){
				
		/*
			1  - 로그인성공
			2  - 아이디가 없음
			3  - 비밀번호 틀림
		
		*/
		
		return memberService.loginCheck(request);
	}
	
	
	@RequestMapping("/idCheck")
	@ResponseBody
	public AjaxIdCheckRequestResult idCheck(@RequestBody AjaxIdCheckRequest request){
		AjaxIdCheckRequestResult response = new AjaxIdCheckRequestResult();
		
		int i = memberService.idCheck(request.getId());
		response.setResult(i);
		
		return response;
	}
	
	@RequestMapping("/adminMenu")
	@ResponseBody
	public String adminMenuStatusChange(HttpServletRequest request){
		HttpSession session = request.getSession();
		boolean adminMenu = (boolean)session.getAttribute("adminMenu");
		System.out.println("현재 adminMenuStatus : " + adminMenu);
		
		session.setAttribute("adminMenu", !adminMenu);
		
		return "adminMenuStatusChanged";
	}
	
	
}
