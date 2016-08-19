package com.matzip.app.djc.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Repository;

import com.matzip.app.djc.domain.MemberBean;
import com.matzip.app.djc.etc.AjaxLoginRequest;
import com.matzip.app.djc.etc.AjaxLoginRequestResult;

@Repository
public class MemberDao {
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Autowired
	NamedParameterJdbcTemplate namedParamJdbcTemplate;
	
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	String sql;
	

	public List<MemberBean> getMemberList(){
		List<MemberBean> mList = null;
		
		sql = "select * from matzip_member";
		
		mList = jdbcTemplate.query(sql,new MemberBeanRowMapper());
		
		
		return mList;
		
	}
	
	public List<MemberBean> getMemberListDesc(){
		List<MemberBean> mList = null;
		
		sql = "select * from matzip_member order by day desc";
		
		mList = jdbcTemplate.query(sql,new MemberBeanRowMapper());
		
		
		return mList;
		
	}
	
	//select substr(day,6) as day, count(id) as num from (select substr(day,1,10) as day, id from matzip_member) c group by c.day order by day desc limit 7;
	//select substr(day,6) as day, count(id) as num from (select substr(day,1,10) as day, id from matzip_member) c group by c.day order by day desc limit 30;
	
	public String getWeeklyDay(){
		String result = null;

		sql = "select substr(day,6) as day from (select substr(day,1,10) as day, id from matzip_member) c group by c.day order by day desc limit 7";
	
		List<String> dayList = jdbcTemplate.query(sql, new RowMapper<String>(){
			@Override
			public String mapRow(ResultSet rs, int rowNum) throws SQLException {
				return rs.getString("day");
			}
			
		});
		
		Iterator iter = dayList.iterator();
		
		while(iter.hasNext()){
			result += "'"+(String)iter.next()+"',";
		}

		result = result.substring(4, result.length()-1);
		System.out.println("result : " + result);
		
		return result;
	}
	
	public String getMonthlyDay(){
		String result = null;

		sql = "select substr(day,6) as day from (select substr(day,1,10) as day, id from matzip_member) c group by c.day order by day desc limit 30";
	
		List<String> dayList = jdbcTemplate.query(sql, new RowMapper<String>(){
			@Override
			public String mapRow(ResultSet rs, int rowNum) throws SQLException {
				return rs.getString("day");
			}
			
		});
		
		Iterator iter = dayList.iterator();
		
		while(iter.hasNext()){
			result += "'"+(String)iter.next()+"',";
		}

		result = result.substring(4, result.length()-1);
		System.out.println("result : " + result);
		
		return result;
	}
	
	
	public String getSigninCountWeek(){
		String result = null;

		sql = "select count(id) as num from (select substr(day,1,10) as day, id from matzip_member) c group by c.day order by day desc limit 7";
	
		List<String> dayList = jdbcTemplate.query(sql, new RowMapper<String>(){
			@Override
			public String mapRow(ResultSet rs, int rowNum) throws SQLException {
				return rs.getString("num");
			}
			
		});
		
		Iterator iter = dayList.iterator();
		
		while(iter.hasNext()){
			result += ""+(String)iter.next()+",";
		}

		result = result.substring(4, result.length()-1);
		System.out.println("result : " + result);
		
		return result;
	}
	
	public String getSigninCountMonth(){
		String result = null;

		sql = "select count(id) as num from (select substr(day,1,10) as day, id from matzip_member) c group by c.day order by day desc limit 30";
	
		List<String> dayList = jdbcTemplate.query(sql, new RowMapper<String>(){
			@Override
			public String mapRow(ResultSet rs, int rowNum) throws SQLException {
				return rs.getString("num");
			}
			
		});
		
		Iterator iter = dayList.iterator();
		
		while(iter.hasNext()){
			result += ""+(String)iter.next()+",";
		}

		result = result.substring(4, result.length()-1);
		System.out.println("result : " + result);
		
		return result;
	}
	
	
	public void insertMember(MemberBean m){
		
		sql = "insert into matzip_member values(now(),"
				+ ":id,:password,:nickname,:phone,:zipCode,"
				+ ":address1,:address2,:photo,:grade)";
		SqlParameterSource beanParam = new BeanPropertySqlParameterSource(m);
		
		//zipCode 와 같이 카멜케이싱은 beanPram으로 입력될시 zip_code를 찾아 바인딩 시켜준다.
		
		namedParamJdbcTemplate.update(sql, beanParam);
	}
	
	public MemberBean getMemberBean(String id){
		sql ="select * from matzip_member where id = '"+id+"'";
		
		return jdbcTemplate.query(sql, new MemberBeanResultSetExtractor());
	}
	
	public int idCheck(String id){
		// 1 - 사용가능한 아이디 2- 중복된 아이디
		sql = "select * from matzip_member where id = '"+id+"'";
		MemberBean m = null;
		m = jdbcTemplate.query(sql, new MemberBeanResultSetExtractor());
		
		int i = 2;
		if(m == null){
			System.out.println("입력값 : " + id + " -  사용 가능한 아이디 입니다.");
			i = 1;
		}else{
			System.out.println("입력값 : " + id + " -  사용 할수 없는 아이디 입니다.");
		}
		return i;
	}
	
	
	public int getTotalMemberCount(){
		sql = "select count(*) from matzip_member";
		return jdbcTemplate.queryForObject(sql, Integer.class);
	}
	
	public AjaxLoginRequestResult loginCheck(AjaxLoginRequest request){
		AjaxLoginRequestResult response = new AjaxLoginRequestResult();
		
		String id = request.getId();
		String password = request.getPassword();
		
		sql = "select * from matzip_member where id = '"+id+"'";
		
		MemberBean info = jdbcTemplate.query(sql,new MemberBeanResultSetExtractor());
		String resultPass = null;
		if(info != null){
			resultPass = info.getPassword();
		}
		
		System.out.println("입력한 password : " + password);
		System.out.println("실제 password : " + resultPass);
		
		if(password.equals(resultPass)){
			System.out.println("비밀번호가 일치합니다.");
			response.setResult("1");
			response.setMessage("로그인 성공");
		}else if(resultPass == null){
			System.out.println("해당 하는 아이디가 존재하지 않습니다.");
			response.setResult("2");
			response.setMessage("아이디가 존재하지 않습니다.");
		}else{
			System.out.println("비밀번호를 확인해 주세요.");
			response.setResult("3");
			response.setMessage("비밀번호를 확인해 주세요.");
		}
		return response;
	}
	class MemberBeanResultSetExtractor implements ResultSetExtractor<MemberBean>{

		@Override
		public MemberBean extractData(ResultSet rs) throws SQLException, DataAccessException {
			
			MemberBean m = null;
			if(rs.next()){
				m = new MemberBean();
				m.setDay(rs.getTimestamp("day"));
				m.setId(rs.getString("id"));
				m.setPassword(rs.getString("password"));
				m.setNickname(rs.getString("nickname"));
				m.setPhone(rs.getString("phone"));
				m.setZipCode(rs.getString("zip_code"));
				m.setAddress1(rs.getString("address1"));
				m.setAddress2(rs.getString("address2"));
				m.setGrade(rs.getString("grade"));
				m.setPhoto(rs.getString("photo"));

			}
			
			return m;
		}
		
	}
	
	class MemberBeanRowMapper implements RowMapper<MemberBean>{

		@Override
		public MemberBean mapRow(ResultSet rs, int arg1) throws SQLException {
			
			MemberBean m = new MemberBean();
			m = new MemberBean();
			m.setDay(rs.getTimestamp("day"));
			m.setId(rs.getString("id"));
			m.setPassword(rs.getString("password"));
			m.setNickname(rs.getString("nickname"));
			m.setPhone(rs.getString("phone"));
			m.setZipCode(rs.getString("zip_code"));
			m.setAddress1(rs.getString("address1"));
			m.setAddress2(rs.getString("address2"));
			m.setGrade(rs.getString("grade"));
			m.setPhoto(rs.getString("photo"));
			
			return m;
		}
		
	}
}

