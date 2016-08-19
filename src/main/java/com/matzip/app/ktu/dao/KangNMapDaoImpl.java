package com.matzip.app.ktu.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Repository;

import com.matzip.app.ktu.domain.MatZipBean;


@Repository
public class KangNMapDaoImpl implements KangNMapDao {
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Autowired
	NamedParameterJdbcTemplate namedParamJdbcTemplate;

	@Override
	public List<MatZipBean> matZipList() {
		
		return jdbcTemplate.query("SELECT * FROM matzip", new BeanRowMapper());
	}
	
	@Override
	public MatZipBean matZipHanSearch() {
		String han = "한식"; 
		SqlParameterSource namedParam = new MapSqlParameterSource().addValue("han", han);
			
		return namedParamJdbcTemplate.query("SELECT uptae_name FROM matzip WHERE uptae_name = :han", namedParam, new BeanResultSetExtractor());
			
	}
	@Override
	public MatZipBean matZipChaSearch() {
		String cha = "중식"; 
		SqlParameterSource namedParam = new MapSqlParameterSource().addValue("cha", cha);
		return namedParamJdbcTemplate.query("SELECT uptae_name FROM matzip WHERE uptae_name = :cha", namedParam, new BeanResultSetExtractor());
	}

	@Override
	public MatZipBean matZipBunSearch() {
		String bun = "분식"; 
		SqlParameterSource namedParam = new MapSqlParameterSource().addValue("bun", bun);
		return namedParamJdbcTemplate.query("SELECT uptae_name FROM matzip WHERE uptae_name = :bun", namedParam, new BeanResultSetExtractor());
	}

	@Override
	public MatZipBean matZipJapSearch() {
		String jap = "일식"; 
		SqlParameterSource namedParam = new MapSqlParameterSource().addValue("jap", jap);
		return namedParamJdbcTemplate.query("SELECT uptae_name FROM matzip WHERE uptae_name = :jap", namedParam, new BeanResultSetExtractor());
	}
	
	@Override
	public MatZipBean matZipWestSearch() {
		String west = "양식";
		SqlParameterSource namedParam = new MapSqlParameterSource().addValue("west", west);
		return namedParamJdbcTemplate.query("SELECT uptae_name FROM matzip WHERE uptae_name = :west", namedParam, new BeanResultSetExtractor());
		
	}
	
	@Override
	public MatZipBean matZipEtcSearch() {
		String etc = "기타"; 
		SqlParameterSource namedParam = new MapSqlParameterSource().addValue("etc", etc);
		return namedParamJdbcTemplate.query("SELECT uptae_name FROM matzip WHERE uptae_name = :etc", namedParam, new BeanResultSetExtractor());
	}
	
	@Override
	public String loadView(String name) {
		
		return jdbcTemplate.queryForObject("SELECT upso_addr FROM matzip WHERE upso_name =?", String.class, name);
	}

	
	
	private class BeanResultSetExtractor implements ResultSetExtractor<MatZipBean>{
		public MatZipBean extractData(ResultSet rs) throws SQLException , DataAccessException {
			
			if(rs.next()){
				
				MatZipBean b = new MatZipBean();
				b.setUptae_name(rs.getString("uptae_name"));
				
				return b;
			}
			
			return null;
		}
	}
	
	
	private class BeanRowMapper implements RowMapper<MatZipBean>{
		public MatZipBean mapRow(ResultSet rs, int rowNum)throws SQLException{
			MatZipBean m = new MatZipBean();
			m.setUpso_code(rs.getString("upso_code"));
			m.setUpso_name(rs.getString("upso_name"));
			m.setUpso_addr(rs.getString("upso_addr"));
			m.setUpso_tel(rs.getString("upso_tel"));
			m.setUptae_name(rs.getString("uptae_name"));
			return m;
		}
	}


	

	


	


	









}
