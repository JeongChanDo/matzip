package com.matzip.app.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.matzip.app.djc.domain.ArticleBean;
import com.matzip.app.djc.domain.MemberBean;
import com.matzip.app.djc.service.ArticleService;
import com.matzip.app.djc.service.MemberService;

@Controller
public class MainController {

	String redirectIndex = "redirect:index";
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	ArticleService articleService;
	
	/*

	@RequestMapping("article")
	public ModelAndView article(String no){
		ModelAndView modelAndView = new ModelAndView();
		String viewName = "bbs/article";
		Map<String,Object> modelMap = new HashMap<String,Object>();
		
		modelAndView.setViewName(viewName);
		modelAndView.addAllObjects(modelMap);
		return modelAndView;
	}
	
	*/
	
	
	@RequestMapping({"/","/home","/home1","/index"})
	public String index(){
	
		
		return "home1";
	}
	
	
	@RequestMapping("recommend")
	public String recommend(){
		return "recommend";
	}
	
	@RequestMapping("epilogue")
	public String epilogue(HttpSession session,Model model){
				
		List<ArticleBean> aList1 = articleService.getFiveLatestArticleList(1);
		List<ArticleBean> aList2 = articleService.getFiveLatestArticleList(2);
		List<ArticleBean> aList3 = articleService.getFiveLatestArticleList(3);
		List<ArticleBean> aList4 = articleService.getFiveLatestArticleList(4);

		Map<String,Object> modelMap = new HashMap<String,Object>();
		modelMap.put("aList1",aList1);
		modelMap.put("aList2",aList2);
		modelMap.put("aList3",aList3);
		modelMap.put("aList4",aList4);
		
		
		model.addAllAttributes(modelMap);
		
		return "epilogue";
	}
	
	@RequestMapping("customerCenter")
	public String customerCenter(HttpSession session,Model model){
		
		List<ArticleBean> aList5 = articleService.getFiveLatestArticleList(5);
		List<ArticleBean> aList6 = articleService.getFiveLatestArticleList(6);
		List<ArticleBean> aList7 = articleService.getFiveLatestArticleList(7);
		List<ArticleBean> aList8 = articleService.getFiveLatestArticleList(8);

		Map<String,Object> modelMap = new HashMap<String,Object>();
		modelMap.put("aList5",aList5);
		modelMap.put("aList6",aList6);
		modelMap.put("aList7",aList7);
		modelMap.put("aList8",aList8);
		
		
		model.addAllAttributes(modelMap);
		
		
		return "customerCenter";
	}
	
	@RequestMapping(value="loginProcess",method=RequestMethod.POST)
	public String loginProcess(HttpServletRequest request){
		memberService.loginProcess(request);
		String referer = request.getHeader("referer");

		
		referer = referer.substring(request.getContextPath().length());


		return "redirect:"+referer;
	}
	
	@RequestMapping("myPage")
	public ModelAndView myPage(HttpSession session, HttpServletResponse response) throws IOException{
		ModelAndView modelAndView = new ModelAndView();
		String viewName = "member/myPage";
		Map<String,Object> modelMap = new HashMap<String,Object>();
		
		if(session.getAttribute("loginedMember")==null){

			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 접근 입니다.');");
			out.println("window.location.href('home');");

			out.println("</script>");
			out.flush();
			out.close();
		}
		
		
		MemberBean m = (MemberBean)session.getAttribute("loginedMember");
		System.out.println("id : " + m.getId());
		modelMap.put("m", m);
		List<ArticleBean> aList = articleService.getLatestMemberArticleList(m.getId());
		
		modelMap.put("aList", aList);
		List<ArticleBean> cList = articleService.getLatestMemberCommentList(m.getId());
		
		modelMap.put("cList",cList);
		
		modelAndView.setViewName(viewName);
		modelAndView.addAllObjects(modelMap);
		return modelAndView;
	}
	
	
	@RequestMapping("logout")
	public String logout(HttpServletRequest request){
		String referer = request.getHeader("referer");
	
		
		referer = referer.substring(request.getContextPath().length());
		request.getSession().invalidate();
		request.getSession().setAttribute("adminMenu", false);

		return "redirect:"+referer;
	}
	
	@RequestMapping(value="signinProcess",method = RequestMethod.POST)
	public String signinProcess(MultipartHttpServletRequest request) throws IllegalStateException, IOException{
		memberService.signinProcess(request);
		return "redirect:cong";
	}
	
}
