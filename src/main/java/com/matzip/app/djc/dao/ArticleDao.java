package com.matzip.app.djc.dao;

import java.io.File;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.matzip.app.djc.domain.ArticleBean;
import com.matzip.app.djc.domain.MemberBean;
import com.matzip.app.djc.mapper.ArticleBeanMapper;

@Repository
public class ArticleDao {

	final int PAGE_SIZE = 10;
	final int PAGE_GROUP = 10;
	
	@Autowired
	NamedParameterJdbcTemplate namedParamJdbcTemplate;
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	

	
	String sql;
	
	public int getMonthlyWrittenArticleCount(int boardNo){
		ArticleBeanMapper mapper = sqlSessionTemplate.getMapper(ArticleBeanMapper.class);
		return mapper.getMonthlyWrittenArticleCount(boardNo);
	}
	
	public List<ArticleBean> getLatestMemberArticleList(String id){
		ArticleBeanMapper mapper = sqlSessionTemplate.getMapper(ArticleBeanMapper.class);
		return mapper.getLatestMemberArticleList(id);
	}	
	
	public List<ArticleBean> getLatestMemberCommentList(String id){
		ArticleBeanMapper mapper = sqlSessionTemplate.getMapper(ArticleBeanMapper.class);
		return mapper.getLatestMemberCommnetList(id);
	}
	
	public List<ArticleBean> getFiveLatestArticleList(int boardNo){
		/*sql = "select * from matzip_article where seq = 0 and board_no = "+boardNo + " order by time desc limit 5";
		
		return jdbcTemplate.query(sql, new ArticleBeanRowMapper());
		*/
		
		ArticleBeanMapper mapper = sqlSessionTemplate.getMapper(ArticleBeanMapper.class);
		return mapper.getFiveLatestArticleList(boardNo);
		
	}
	
	public List<ArticleBean> getCommentList(int articleNo){
		ArticleBeanMapper mapper = sqlSessionTemplate.getMapper(ArticleBeanMapper.class);
		return mapper.getCommentList(articleNo);
	}
	
	public int getCommentNumber(int articleNo){
		
		int number = 0;
		
		
		sql = "select count(*) from matzip_article where comment = "+articleNo;
		number = jdbcTemplate.queryForObject(sql,Integer.class );
		
		return number;
	}
	
	public void updateArticle(HttpServletRequest request){
		
		int no = Integer.parseInt(request.getParameter("no"));
		String title = request.getParameter("title");
		
		String content = request.getParameter("editor1");
		
		content = content.replaceAll("\r\n", "<br/>");
		content = content.replaceAll(" ", "&nbsp;");
		
		ArticleBean a = new ArticleBean();
		a.setArticleNo(no);
		a.setTitle(title);
		a.setContent(content);
		
		/*
		sql = "update matzip_article set title = :title, content = :content"
				+ " where article_no = "+no;
		
		SqlParameterSource mapParam = new MapSqlParameterSource()
				.addValue("content",content).addValue("title",title);
		
		namedParamJdbcTemplate.update(sql, mapParam);
		*/
		
		ArticleBeanMapper mapper = sqlSessionTemplate.getMapper(ArticleBeanMapper.class);
		mapper.updateArticle(a);
	}
	
	public int getArticleNumberByBoardNo(int boardNo){
		sql = "select count(*) as abc from matzip_article where board_no = "+boardNo;
		
		sql ="select * from matzip_article";
		sql = "select count(0) from matzip_article where board_no = "+boardNo;

		System.out.println("getArticleNumber   -   boardNo : " + boardNo);
		
		int num = jdbcTemplate.queryForObject(sql, Integer.class);
		return num;
	}
	
	public List<ArticleBean> getArticleList(HttpServletRequest request){
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		int pageNo = Integer.parseInt(request.getParameter("pageNo"));
		
		int startNo = (pageNo == 1 ? 1 : (pageNo-1)*PAGE_SIZE+1);
	
		int endNo = startNo+9;
		
		int totalArticleNumber = getArticleNumberByBoardNo(boardNo);
		System.out.println("totalArticleNumber : " + totalArticleNumber);
		int pageNumber = totalArticleNumber % PAGE_SIZE == 0 ? totalArticleNumber/PAGE_SIZE : totalArticleNumber/PAGE_SIZE +1;
		
		int startPageNumber = pageNo%PAGE_GROUP == 0 ? 10*(pageNo/PAGE_GROUP-1) +1 : 10*(pageNo/PAGE_GROUP) +1;
		// 14 페이지 -> 14/10 1   11페이지부터ㅏ
		//25 페이지 -> 25/10 2  21페이지부터
		//30페이지 -> 30/10 3  21페이지부터
		
		int endPageNumber = (startPageNumber+9 > pageNumber ? pageNumber : startPageNumber +9 );
		// 31+9 >   총페이지 37  -> 마지막 페이지 37
		
		// 31+9  < 43 ->  마지막 페이지는 40
		
		// 40 40 -> 40
		
		//페이징 처리는 나중에
		
		request.setAttribute("startPageNo", startPageNumber);
		request.setAttribute("endPageNo", endPageNumber);
		request.setAttribute("pageNumber",pageNumber);
		
		sql = "select c.* from (select @rownum := @rownum +1 as rownum ,c.* "
				+ "from matzip_article c,(select @rownum := 0) b where c.seq = 0 and c.board_no = "+boardNo
				+ " order by time desc) c where rownum between "+startNo+" and "+endNo;
		
		return jdbcTemplate.query(sql, new RowMapper<ArticleBean>(){

			@Override
			public ArticleBean mapRow(ResultSet rs, int rowNum) throws SQLException {
				ArticleBean a = new ArticleBean();
				a.setTime(rs.getTimestamp(2));
				a.setBoardNo(rs.getInt(3));
				a.setArticleNo(rs.getInt(4));
				a.setTitle(rs.getString(5));
				a.setContent(rs.getString(6));
				a.setWriter(rs.getString(7));
				a.setNickname(rs.getString(8));
				a.setView(rs.getInt(9));
				a.setGood(rs.getInt(10));
			
				if(rs.getString(11) != null){
					
					a.setPhoto(rs.getString(11));
				}
				
				
				return a;
				
			}
			
		});
	}
	

	public List<ArticleBean> getMemberArticleList(String id, int pageNo){
		List<ArticleBean> aList = new ArrayList<ArticleBean>();

		sql = "select * from matzip_article where id = '"+id+"' and seq = 0 order by time desc";
	
		return aList;
	}
	
	public List<ArticleBean> getMemberArticleList(String id){
		List<ArticleBean> aList = null;

		sql = "select * from matzip_article where id = '"+id+"' and seq = 0 order by time desc";
	
		return aList;
	}
	
	
	public List<ArticleBean> getArticleList(int boardNo1, int pageNo1){
		int pageNo = pageNo1;
		
		List<ArticleBean> aList = new ArrayList<ArticleBean>();
		int startNo = (pageNo == 1 ? 1 : (pageNo-1)*PAGE_SIZE)+1;
		// pageNo가 1이면 start No가 1
		//pageNO가 5면 startNo 41  2면 11
		
		int endNo = startNo+9;
		
		//페이징 처리는 나중에
		//sql = "select * from matzip_article where board_no = ? order by time ";
		
		
		sql = "select * from matzip_article where seq = 0 and board_no = "+boardNo1+" order by time desc";
		
		
		return jdbcTemplate.query(sql, new ArticleBeanRowMapper());
	}
	
	
	public void articleWriteProcess(MultipartHttpServletRequest request) throws IllegalStateException, IOException{
		
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		String title = request.getParameter("title");
		String content = request.getParameter("editor1");
		

		content = content.replaceAll("\r\n", "<br/>");
		content = content.replaceAll(" ", "&nbsp;");
		
		
		HttpSession session = request.getSession();
		
		MemberBean m = (MemberBean)session.getAttribute("loginedMember");
		
		
		
		
		
		String sep = File.separator;
		String path = "C:"+sep+"MatZip"+sep+"MatZip"+sep+"src"+sep+"main"+sep
				+"webapp"+sep+"resources"+sep+"uploadImages";
		
		ArticleBean a = new ArticleBean();
	
		a.setWriter(m.getId());
		a.setNickname(m.getNickname());
		a.setBoardNo(boardNo);
		a.setTitle(title);
		a.setContent(content);
		
		
		//time view good 디폴트
		//articleNo는 auto_increment
		
		
		
		MultipartFile multipartFile = null;
		
		
		File file = null;
		String photoCheck = request.getParameter("photoExist");
		Timestamp t = new Timestamp(System.currentTimeMillis());
		
		
		if(photoCheck.equals("yes")){
			multipartFile = request.getFile("photo");
			String fileName = multipartFile.getOriginalFilename();
			fileName = fileName.substring(fileName.indexOf("."));

			
			String n = t.toString().substring(0,19).replace(" ","").replaceAll(":","").replaceAll("-","");

			String imageName = m.getId()+n+fileName;
			System.out.println("imageName : " + imageName);
			
			file = new File(path,imageName);
			multipartFile.transferTo(file);
			a.setPhoto(imageName);
		
			
		}else{
			System.out.println("사진을 등록하지 않았습니다.");
		}
	
		
		
		insertArticle(a);
		
	}
	
	public void updateView(int no){
		sql ="update matzip_article set view = view+1 where article_no="+no;
		jdbcTemplate.update(sql);
	}
	
	public ArticleBean getArticleBean(int no){
		updateView(no);

		sql ="select * from matzip_article where article_no = :no";
		SqlParameterSource param = new MapSqlParameterSource("no",no);
		
		
		
		return namedParamJdbcTemplate.query(sql, param,new ArticleBeanResultSetExtractor());
	}
	
	public void delete(int no){
		sql ="delete from matzip_article where article_no ="+no;
		jdbcTemplate.update(sql);
		sql = "delete from matzip_article where comment ="+no;
		jdbcTemplate.update(sql);
	}
	
	public boolean checkDuplicate(int no,String id){
		boolean isDuplicated = false;
		
		sql = "select count(*) from matzip_recommend where id = '"+id+"' and article_no = "+no;
		
		int result = jdbcTemplate.queryForObject(sql, Integer.class);
		
		if(result == 1){
			isDuplicated = true;
		}
		
		return isDuplicated;
	}
	
	public void recommend(int no,String id){
		sql = "insert into matzip_recommend values("+no+",'"+id+"')";
		jdbcTemplate.update(sql);
		
		sql = "update matzip_article set good = good +1 where article_no ="+no;
		
		jdbcTemplate.update(sql);
	}
	
	public void insertArticle(ArticleBean a2){
		ArticleBean a = a2;
		
		SqlParameterSource beanParam = new BeanPropertySqlParameterSource(a);
		
		sql = "insert into matzip_article(board_no,title,content,writer,nickname,photo)"
				+ " values(:boardNo,:title,:content,:writer,:nickname,:photo)";
		
		namedParamJdbcTemplate.update(sql, beanParam);
	}
	
	public void commentWrite(HttpServletRequest request){
		String content = request.getParameter("commentContent");
		String boardNo = request.getParameter("commentBoardNo");
		int comment = Integer.parseInt(request.getParameter("articleNo"));
		content = content.replaceAll("\r\n", "<br/>");
		content = content.replaceAll(" ", "&nbsp;");
		
		HttpSession session = request.getSession();
		
		MemberBean m = (MemberBean)session.getAttribute("loginedMember");
		
		
		sql="select count(*) from matzip_article where comment = "+comment;
		
		int commentNumber = jdbcTemplate.queryForObject(sql, Integer.class);
		
		
		
		SqlParameterSource paramMap = new MapSqlParameterSource().addValue("boardNo",boardNo)
				.addValue("title","댓글").addValue("content",content).addValue("comment", comment)
				.addValue("writer", m.getId()).addValue("nickname",m.getNickname())
				.addValue("seq", commentNumber+1);
		
		sql = "insert into matzip_article(board_no,title,content,writer,nickname,seq,comment)"
				+ " values(:boardNo,:title,:content,:writer,:nickname,:seq,:comment)";
		
		
		namedParamJdbcTemplate.update(sql, paramMap);
		
		
	}
	
	class ArticleBeanResultSetExtractor implements ResultSetExtractor<ArticleBean>{

		@Override
		public ArticleBean extractData(ResultSet rs) throws SQLException, DataAccessException {
			ArticleBean a = new ArticleBean();
			if(rs.next()){
				a.setTime(rs.getTimestamp(1));
				a.setBoardNo(rs.getInt(2));
				a.setArticleNo(rs.getInt(3));
				a.setTitle(rs.getString(4));
				a.setContent(rs.getString(5));
				a.setWriter(rs.getString(6));
				a.setNickname(rs.getString(7));
				a.setView(rs.getInt(8));
				a.setGood(rs.getInt(9));
			
				if(rs.getString(10) != null){
					
					a.setPhoto(rs.getString(10));
				}
				a.setSeq(rs.getInt(11));
				a.setComment(rs.getInt(12));
			}
			
			return a;
		}
		
	}
	
	class ArticleBeanRowMapper implements RowMapper<ArticleBean>{

		@Override
		public ArticleBean mapRow(ResultSet rs, int rowNum) throws SQLException {
			ArticleBean a = new ArticleBean();
			a.setTime(rs.getTimestamp(1));
			a.setBoardNo(rs.getInt(2));
			a.setArticleNo(rs.getInt(3));
			a.setTitle(rs.getString(4));
			a.setContent(rs.getString(5));
			a.setWriter(rs.getString(6));
			a.setNickname(rs.getString(7));
			a.setView(rs.getInt(8));
			a.setGood(rs.getInt(9));
		
			if(rs.getString(10) != null){
				
				a.setPhoto(rs.getString(10));
			}
			a.setSeq(rs.getInt(11));
			a.setComment(rs.getInt(12));
			return a;
		}
		
	}
}
