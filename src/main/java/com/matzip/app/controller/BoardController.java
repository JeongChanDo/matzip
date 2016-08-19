package com.matzip.app.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.matzip.app.djc.domain.ArticleBean;
import com.matzip.app.djc.domain.MemberBean;
import com.matzip.app.djc.service.ArticleService;

@Controller
public class BoardController {

	
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
	
	@RequestMapping("board")
	public ModelAndView boardList
			(HttpServletRequest request, @RequestParam(value = "boardNo", required=false,defaultValue="1") String boardNo1,
			@RequestParam(value= "pageNo", required=false,defaultValue="1") String pageNo1){
		
		int boardNo = Integer.parseInt(boardNo1);
		int pageNo = Integer.parseInt(pageNo1);
		
		String board = "bbs/main";
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName(board);
		
		
		List<ArticleBean> aList = articleService.getArticleList(request);
		//List<ArticleBean> aList = articleService.getArticleList(boardNo,pageNo);
		
		Map<String,Object> modelMap = new HashMap<String,Object>();
		
		modelMap.put("aList", aList);
		
		modelAndView.addAllObjects(modelMap);
		
		return modelAndView;
	}
	
	@RequestMapping("commentWriteProcess")
	public ModelAndView commentWriteProcess(HttpServletRequest request,
			String boardNo, String pageNo, String no){
		ModelAndView modelAndView = new ModelAndView();
		String viewName = "redirect:article?boardNo="+boardNo+"&pageNo="+pageNo+"&no="+no;
		Map<String,Object> modelMap = new HashMap<String,Object>();
		
		articleService.commentWrite(request);
		
		
		
		modelAndView.setViewName(viewName);
		modelAndView.addAllObjects(modelMap);
		return modelAndView;
	}
	
	@RequestMapping("articleWriteProcess")
	public ModelAndView writeProcess(MultipartHttpServletRequest request) throws IllegalStateException, IOException{
		ModelAndView modelAndView = new ModelAndView();
		
		String boardNo = request.getParameter("boardNo");
		
		articleService.articleWriteProcess(request);
		
		modelAndView.setViewName("redirect:board?boardNo="+boardNo+"&pageNo=1");
		
		
		return modelAndView;
		
	}
	
	
	@RequestMapping("commentDelete")
	public ModelAndView article(String boardNo, String pageNo, String no,String articleNo){
		ModelAndView modelAndView = new ModelAndView();
		String viewName = "redirect:article?boardNo="+boardNo+"&pageNo="+pageNo+"&no="+articleNo;
		Map<String,Object> modelMap = new HashMap<String,Object>();
		
		articleService.delete(Integer.parseInt(no));
		modelAndView.setViewName(viewName);
		modelAndView.addAllObjects(modelMap);
		return modelAndView;
	}
	
	@RequestMapping("article")
	public ModelAndView article(@RequestParam(value="no", required=false) String no2,HttpSession session){
		ModelAndView modelAndView = new ModelAndView();
		boolean duplicated = false;
		String viewName = "bbs/article";
		Map<String,Object> modelMap = new HashMap<String,Object>();
		
		int no = Integer.parseInt(no2);
		
		
		if(session.getAttribute("loginedMember") != null){
			System.out.println("로그인 되어있습니다.");
			String id = ((MemberBean)session.getAttribute("loginedMember")).getId();
			duplicated = articleService.checkDuplicate(no,id);
			System.out.println("duplicated : " + duplicated);
		}
		int commentNumber = articleService.getCommentNumber(no);
		modelMap.put("a",articleService.getArticleBean(no));
		modelMap.put("duplicated", duplicated);
		modelMap.put("commentNumber",commentNumber);
		
		if(commentNumber != 0){
			
			List<ArticleBean> cList = articleService.getCommentList(no);
			
			modelMap.put("cList",cList);
		}
		
		
		modelAndView.setViewName(viewName);
		modelAndView.addAllObjects(modelMap);
		

		return modelAndView;
	}
	
	@RequestMapping("recommendProcess")
	public String recommendProcess(HttpSession session,String boardNo, String pageNo, String no){
		String id = ((MemberBean)session.getAttribute("loginedMember")).getId();
		articleService.recommend(Integer.parseInt(no),id);
		return "redirect:article?boardNo="+boardNo+"&pageNo="+pageNo+"&no="+no;
	}
	
	@RequestMapping("articleDelete")
	public String articleDelete(String boardNo, String no){
		articleService.delete(Integer.parseInt(no));
		
		
		return "redirect:board?boardNo="+boardNo+"&pageNo=1";
	}
	
	
	@RequestMapping("articleUpdate")
	public String articleUpdateForm(String no,HttpServletRequest request){
		request.setAttribute("a",articleService.getArticleBean(Integer.parseInt(no)));
		return "bbs/updateForm";
	}
	
	@RequestMapping("articleUpdateProcess")
	public String articleUpdateProcess(HttpServletRequest request){
		
		String boardNo = request.getParameter("boardNo");
		String pageNo = request.getParameter("pageNo");
		String no = request.getParameter("no");
		
		articleService.updateArticle(request);
		
		return "redirect:article?boardNo="+boardNo+"&pageNo="+pageNo+"&no="+no;
	}
	
}
