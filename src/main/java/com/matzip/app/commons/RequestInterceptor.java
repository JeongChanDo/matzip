package com.matzip.app.commons;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.matzip.app.djc.domain.MemberBean;

@Service
public class RequestInterceptor implements HandlerInterceptor {

	@Autowired
	MongoCommonsDao mongoCommonsDao;
	
	@Override
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object arg2, ModelAndView arg3)
			throws Exception {
	
		mongoCommonsDao.insertRequestLog(request);
		HttpSession session = request.getSession();
		String uri = request.getRequestURI().substring(request.getContextPath().length());
		
		if(request.getQueryString() != null){
			
			uri = uri+"?"+request.getQueryString();
		}
		
		System.out.println("요청된 uri : " + uri);
		
		//관리자 관련 메뉴 요청일때
		if(uri.contains("admin")||uri.startsWith("admin")){
			System.out.println("관리자 관련 요청 입니다.");
			
			if(session.getAttribute("loginedMember") != null
					&&((MemberBean)session.getAttribute("loginedMember")).getGrade().equals("3") ){
				System.out.println("해당 회원은 관리자 입니다.");
			}else{
				System.out.println("잘못된 접근 입니다.");
				
				PrintWriter out = response.getWriter();
				
				out.println("<script>");
				out.println("alert('잘못된 접근 입니다.');");
				out.println("window.location.href('home')");
				out.println("</script>");
				out.flush();
				out.close();
			}
			
			
			
			
		}
		
		//관리자의 요청일떄
		if(session.getAttribute("loginedMember") != null
				&&((MemberBean)session.getAttribute("loginedMember")).getGrade().equals("3") ){
			
			//관리자 요청인데 맛집후기나 고겍센터 갈시  seaTabs 뜨는것 막기
			if(uri.equals("areaSearch")||uri.equals("recommend")){
				session.setAttribute("seaTabsMustNotDisplay", false);
				System.out.println("seaTabs를 해제했습니다.");
			}else{
				session.setAttribute("seaTabsMustNotDisplay", true);
				System.out.println("seaTabs를  막았습니다.");
			}
		}
		
		
	}

	@Override
	public boolean preHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2) throws Exception {
		// TODO Auto-generated method stub
		return true;
	}

}
