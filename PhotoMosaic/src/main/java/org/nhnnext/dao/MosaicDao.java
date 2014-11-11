package org.nhnnext.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import org.nhnnext.domains.Mosaic;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.support.JdbcDaoSupport;

public class MosaicDao extends JdbcDaoSupport {
	public Mosaic findById(int id) {
		String sql = "select * from MOSAICS where id= ?";
		RowMapper<Mosaic> rowMapper = new RowMapper<Mosaic>() {

			public Mosaic mapRow(ResultSet rs, int rowNum) throws SQLException {
				return new Mosaic(
						rs.getInt("id"), 
						rs.getString("title"),
						rs.getString("comment"),
						rs.getString("url"));
			}
		};
		return getJdbcTemplate().queryForObject(sql, rowMapper, id);
	}
	
	public Mosaic findByUrl(String url) {
		String sql = "select * from MOSAICS where url= ?";
		RowMapper<Mosaic> rowMapper = new RowMapper<Mosaic>() {

			public Mosaic mapRow(ResultSet rs, int rowNum) throws SQLException {
				return new Mosaic(
						rs.getInt("id"), 
						rs.getString("title"),
						rs.getString("comment"),
						rs.getString("url"));
			}
		};
		return getJdbcTemplate().queryForObject(sql, rowMapper, url);
	}

	public void upload(Mosaic mosaic) {
		String sql = "INSERT INTO MOSAICS (title, comment, url) VALUES (?, ?, ?)";
		getJdbcTemplate().update(sql, mosaic.getTitle(), mosaic.getComment(), mosaic.getUrl());
	}
	
	public void updateCreatedTime(Mosaic mosaic) {
		String sql ="UPDATE MOSAICS SET created_date = NOW() where id = ?";
		getJdbcTemplate().update(sql, mosaic.getId());
		//TODO if I can get NOW() here, it doesn't need getCreateTime method
	}
	
	public Timestamp getCreatedTime(int mosaicId) {
		String sql = "SELECT created_date from MOSAICS where id = ?";
		return getJdbcTemplate().queryForObject(sql, new Object[]{mosaicId}, Timestamp.class);
	}
}