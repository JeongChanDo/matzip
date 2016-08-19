package com.matzip.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.matzip.app.djc.domain.ArticleBean;
import com.matzip.app.djc.domain.LogBean;
import com.matzip.app.djc.domain.MemberBean;
import com.matzip.app.djc.etc.RTest;
import com.matzip.app.djc.service.AdminService;
import com.matzip.app.djc.service.ArticleService;
import com.matzip.app.djc.service.MemberService;


@Controller
public class AdminController {

	
	@Autowired
	MemberService memberService;
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	ArticleService articleService;
	
	@Autowired
	RTest rTest;
	
	//요청이 admin인데 인자로 no가 있다.
	@RequestMapping("admin")
	public ModelAndView admin
			(HttpServletRequest request, @RequestParam(value="pageNo",required=false,defaultValue="1") String no1,
					@RequestParam(value="no",required=false) String no2){
		
		ModelAndView modelAndView = new ModelAndView();
		Map<String,Object> modelMap = new HashMap<String,Object>();
		String destination = "admin/main";
		int no = Integer.parseInt(no1);
		
		if(no == 1){
			destination = "admin/main";
			
			//회원수 , 최근 가입한 회원 목록
			//로그 그래프
			int size = memberService.getTotalMemberCount();
			modelMap.put("latestMember",memberService.getMemberBeanListDesc().subList(0,5));
			modelMap.put("totalMemberCount",memberService.getTotalMemberCount());
			
			adminService.adminPageNo1RequestProcess(request);
			String cityCount = rTest.result();

			modelMap.put("cityCount",cityCount);
			
			
			String weeklyDay = memberService.getWeeklyDay();
			String monthlyDay = memberService.getMonthlyDay();
			
			String signinCountWeek = memberService.getSinginCountWeek();
			String signinCountMonth = memberService.getSinginCountMonth();
			
			
			modelMap.put("weeklyDay",weeklyDay);
			modelMap.put("monthlyDay",monthlyDay);
			modelMap.put("signinCountWeek",signinCountWeek);
			modelMap.put("signinCountMonth",signinCountMonth);
			
		}else if(no == 2){
			destination = "admin/memberManagement";
			
			List<MemberBean> mList = memberService.getMemberBeanList();
		
			modelMap.put("mList", mList);
			
			//pageNo가 3
		}else if(no == 3){
			//로그는 pageNo가 3
			
			destination = "admin/log";
			int number = 1;
			
			//no가 없으면 디폴트 값은 1 있으면 가져온 번호를 사용
			if(no2 != null){
				number = Integer.parseInt(no2);
			}
			
			List<LogBean> logList = adminService.getThirtyLogs(number);

			if(request.getParameter("keyword") != null){
				String keyword = request.getParameter("keyword");
				int search = Integer.parseInt(request.getParameter("search"));
				logList = adminService.getThirtySearchedLogs(keyword,search,number);
			}
			
			modelMap.put("logList", logList);
			
			System.out.println("가져올 로그 갯수 : " +logList.size());
			
			
			
			
			
			
			
			
			

		}
		modelAndView.addAllObjects(modelMap);
		modelAndView.setViewName(destination);
		System.out.println("destination : " + destination +"    no : " + no);
		return modelAndView;
	}
	//요청이 admin인데 인자로 id가 있다.
	
	@RequestMapping("adminMemberInfo")
	public ModelAndView memberManagement(String id){
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("admin/memberInfo");
		Map<String,Object> modelMap = new HashMap<String,Object>();
		
		modelMap.put("m",memberService.getMemberBean(id));
		List<LogBean> logList = adminService.getLogAboutId(id);
		modelMap.put("logList",logList);
		
		System.out.println("가져올 로그 갯수 : " +logList.size());
		
		List<ArticleBean> aList = articleService.getLatestMemberArticleList(id);
		
		modelMap.put("aList", aList);
		List<ArticleBean> cList = articleService.getLatestMemberCommentList(id);
		
		modelMap.put("cList",cList);
		
		modelAndView.addAllObjects(modelMap);
		return modelAndView;
	}
}
