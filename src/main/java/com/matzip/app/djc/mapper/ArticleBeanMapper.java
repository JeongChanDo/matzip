package com.matzip.app.djc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.matzip.app.djc.domain.ArticleBean;

public interface ArticleBeanMapper {

	@Select({
		"select * from matzip_article where seq = 0 and board_no = #{boardNo} order by time desc limit 5"
	})
	public List<ArticleBean> getFiveLatestArticleList(int boardNo);
	
	
	@Select({
		"select * from matzip_article where seq != 0 and writer = #{id} order by time desc limit 10"
	})
	public List<ArticleBean> getLatestMemberCommnetList(String id);
	
	@Select({
		"select * from matzip_article where seq !=0 and writer = #{id} order by time desc limit 10"
	})
	public List<ArticleBean> getLatestMemberArticleList(String id);
	
	
	@Select({
		"select * from matzip_article where comment = #{articleNo} order by seq desc"
	})
	public List<ArticleBean> getCommentList(int articleNo);
	
	@Update({
		"update matzip_article set title = #{title}, content = #{content} where article_no = #{articleNo}"
	})
	public void updateArticle(ArticleBean a);
	
	
}
