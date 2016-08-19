package com.matzip.app.djc.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.matzip.app.djc.dao.ArticleDao;
import com.matzip.app.djc.domain.ArticleBean;

@Service
public class ArticleService {

	
	@Autowired
	ArticleDao articleDao;
	
	public List<ArticleBean> getArticleList(int boardNo, int pageNo){
		return articleDao.getArticleList(boardNo,pageNo);
	}
	
	

	public List<ArticleBean> getMemberArticleList(String id, int pageNo){
		return articleDao.getMemberArticleList(id,pageNo);
	}
	
	public List<ArticleBean> getLatestMemberArticleList(String id){
		return articleDao.getLatestMemberArticleList(id);
	}
	
	public List<ArticleBean> getLatestMemberCommentList(String id){
		return articleDao.getLatestMemberCommentList(id);
	}
	
	
	
	public List<ArticleBean> getMemberArticleList(String id){
		return articleDao.getMemberArticleList(id);
	}
	
	
	public String getMonthlyArticlesCountData(){
		String result = null;
		String before = null;
		
		int y = 0;
		
		for(int i = 1; i <=8; i++){
			String value = null;
			value = "{name:";
			
			y = articleDao.getMonthlyWrittenArticleCount(i);
			if(i==1){
				value += "'지역별 맛집후기";
			}else if(i==2){
				value += "'메뉴별 맛집후기";				
			}else if(i==3){
				value += "'가격별 맛집후기";				
			}else if(i==4){
				value += "'가짜 맛집후기";
			}else if(i==5){
				value += "'공지사항";
			}else if(i==6){
				value += "'Q&A";				
			}else if(i==7){
				value += "'추천레시피";				
			}else if(i==8){
				value += "'자유게시판";
			}
		

			value += "("+y+")',y:"+y+"}";
			
			if(i==8){
				
			}else{
				value += ",";
			}
			System.out.println("value : "+ value);
		
			if(i==1){
				before = value;
			}else{
				before += value;
			}
		}
		result = "["+before+"]";
		System.out.println("result : " + result);
		return result;
	}
	
	public List<ArticleBean> getCommentList(int articleNo){
		return articleDao.getCommentList(articleNo);
	}
	
	public void updateArticle(HttpServletRequest request){
		articleDao.updateArticle(request);
	}
	
	public void articleWriteProcess(MultipartHttpServletRequest request) throws IllegalStateException, IOException{
		articleDao.articleWriteProcess(request);
	}
	
	public List<ArticleBean> getArticleList(HttpServletRequest request){
		return articleDao.getArticleList(request);
	}
	
	public ArticleBean getArticleBean(int no){
		return articleDao.getArticleBean(no);
	}
	
	public boolean checkDuplicate(int no,String id){
		return articleDao.checkDuplicate(no,id);
	}
	
	public void recommend(int no, String id){
		articleDao.recommend(no,id);
	}
	
	public void delete(int no){
		articleDao.delete(no);
	}
	
	public int getCommentNumber(int articleNo){
		return articleDao.getCommentNumber(articleNo);
	}
	
	public void commentWrite(HttpServletRequest request){
		articleDao.commentWrite(request);
	}

	public List<ArticleBean> getFiveLatestArticleList(int boardNo){
		return articleDao.getFiveLatestArticleList(boardNo);
	}
}
