package com.matzip.app.kyj.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

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

import com.matzip.app.kyj.domain.Matzip;


@Repository
public class MatzipDaoImpl implements MatzipDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private NamedParameterJdbcTemplate namedParameterJdbcTemplate;
	
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate){
		this.jdbcTemplate=jdbcTemplate;
	}
	public void setNamedParameterJdbcTemplate(NamedParameterJdbcTemplate namedParameterJdbcTemplate){
		this.namedParameterJdbcTemplate=namedParameterJdbcTemplate;
	}
	
	@Override
	public List<Matzip> getMatzipListAll(int startRow, int num) {
		SqlParameterSource namedparam = new  MapSqlParameterSource().addValue("startRow", startRow).addValue("num", num);
		return namedParameterJdbcTemplate.query("SELECT * FROM matzip order by no DESC "
				+ " limit :startRow, :num", namedparam, new BeanRowMapper());
	}
	
	@Override
	public int getMatzipCount() {
		List<Matzip> matzip = namedParameterJdbcTemplate.query("SELECT * FROM matzip", new BeanRowMapper());
		return matzip.size();
	}
	
	@Override
	public Matzip getMatzip(int no, boolean state) {
		String matzipSql = "SELECT * FROM matzip WHERE no = "+  no;
		Matzip matzip = namedParameterJdbcTemplate.query(matzipSql, new ResultSetExtractor<Matzip>() {

			@Override
			public Matzip extractData(ResultSet rs) throws SQLException, DataAccessException {
				if(rs.next()) {
					Matzip m = new Matzip();
				
					m.setNo(rs.getInt("no"));
					m.setUpso_code(rs.getString("upso_code"));
					m.setUpso_name(rs.getString("upso_name"));
					m.setUpso_addr(rs.getString("upso_addr"));
					m.setUpso_tel(rs.getString("upso_tel"));
					m.setUptae_name(rs.getString("uptae_name"));
				
					return m;	
				}
				return null;
			}					
		});
		return matzip;
	}
	
	@Override
	public void insertMatzipRs(Matzip matzip) {
		String insertSql = "INSERT INTO matzip VALUES (:no, :upso_code, :upso_name, :upso_addr, :upso_tel, :uptae_name)";
		
		SqlParameterSource param = new BeanPropertySqlParameterSource(matzip);
		namedParameterJdbcTemplate.update(insertSql, param);
	}	
	
	@Override
	public void updateMatzipRs(Matzip matzip) {
		String updateSql = "UPDATE matzip set upso_code =:upso_code, upso_name=:upso_name, upso_addr=:upso_addr, "
				+ "upso_tel=:upso_tel, uptae_name=:uptae_name WHERE no = :no";
		
		SqlParameterSource param=new BeanPropertySqlParameterSource(matzip);
		namedParameterJdbcTemplate.update(updateSql, param);
	}
	
	public void deleteMatzipRs(int no) {		
		String deleteSql = "DELETE FROM matzip WHERE no = :no";
		
		SqlParameterSource param = new MapSqlParameterSource("no", no);
		namedParameterJdbcTemplate.update(deleteSql, param);		
	}
	
	@Override
	public List<Matzip> getMatzipByKeyword(String keyword, int startRow, int num) {
		SqlParameterSource namedParam = new MapSqlParameterSource()
				.addValue("per", "%").addValue("keyword", keyword).addValue("startRow", startRow).addValue("num", num);
			return namedParameterJdbcTemplate.query(
					"SELECT * FROM (SELECT * FROM matzip WHERE upso_addr LIKE :per :keyword :per) matzip limit :startRow, :num"
					, namedParam, 
					new BeanRowMapper2());
	}
	
	@Override
	public List<Matzip> getMatzipByKeyword2(String keyword2, int startRow, int num) {
		SqlParameterSource namedParam = new MapSqlParameterSource()
				.addValue("per", "%").addValue("keyword", keyword2).addValue("startRow", startRow).addValue("num", num);
			
			return namedParameterJdbcTemplate.query(
					"SELECT * FROM (SELECT * FROM matzip WHERE uptae_name LIKE :per :keyword :per) matzip limit :startRow, :num", namedParam, 
					new BeanRowMapper2());
	}

	
	private class BeanRowMapper implements RowMapper<Matzip> {
		public Matzip mapRow(ResultSet rs, int rowNum) throws SQLException {
						
			Matzip m = new Matzip();
			
			m.setNo(rs.getInt("no"));
			m.setUpso_code(rs.getString("upso_code"));
			m.setUpso_name(rs.getString("upso_name"));
			m.setUpso_addr(rs.getString("upso_addr"));
			m.setUpso_tel(rs.getString("upso_tel"));
			m.setUptae_name(rs.getString("uptae_name"));
		
			return m;
		}	
	}
	
	private class BeanRowMapper2 implements RowMapper<Matzip> {
		public Matzip mapRow(ResultSet rs, int rowNum) throws SQLException {
						
			Matzip m = new Matzip();
			
			m.setNo(rs.getInt("no"));
			m.setUpso_name(rs.getString("upso_name"));
			m.setUpso_addr(rs.getString("upso_addr"));
			m.setUptae_name(rs.getString("uptae_name"));
		
			return m;
		}	
	}
}
