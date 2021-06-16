package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.DBClose;
import db.DBConnection;
import dto.MemberDto;

public class MemberDao {

	private static MemberDao dao = new MemberDao();
	
	public MemberDao() {
		DBConnection.initConnection();
	}
	
	public static MemberDao getInstance() {		
		return dao;
	}
	
	public boolean addMember(MemberDto dto) {
		
		String sql = " INSERT INTO MEMBER(ID, PWD, NAME, EMAIL, AUTH) "
					+ " VALUES(?, ?, ?, ?, 3) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 addMember success");
				
			psmt = conn.prepareStatement(sql);
			System.out.println("2/3 addMember success");
			
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPwd());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getEmail());
			
			count = psmt.executeUpdate();
			System.out.println("3/3 addMember success");
			
		} catch (SQLException e) {			
			e.printStackTrace();
			System.out.println("addMember fail");
		} finally {
			DBClose.close(conn, psmt, null);			
		}
		
		return count>0?true:false;
	}
	public boolean getId(String id) {
		String sql = " SELECT ID "
					+ "	FROM MEMBER "
					+ " WHERE ID=? ";
	/*	String sql = " SELECT COUNT(*) "
				+ "	FROM MEMBER "
				+ " WHERE ID=? ";
	*/	
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
	//	String findid = null;
		boolean findid = false;
				
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getId success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id.trim());
			System.out.println("2/3 getId success");
			
			rs = psmt.executeQuery();
			System.out.println("3/3 getId success");
			
			if(rs.next()) {
				findid = true;
			}			
			
		} catch (SQLException e) {
			System.out.println("getId fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);			
		}
		
		return findid;
	}
public MemberDto login(MemberDto dto) {
		
		String sql = " SELECT ID, NAME, EMAIL, AUTH "
				+ " FROM MEMBER "
				+ " WHERE ID=? AND PWD=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		MemberDto mem = null;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/6 login suc");
			
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPwd());
			
			System.out.println("2/6 login suc");
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				String id = rs.getString(1);
				String name = rs.getString(2);
				String email = rs.getString(3);
				int auth = rs.getInt(4);
				
				mem = new MemberDto(id, null, name, email, auth);				
			}
			
			System.out.println("3/6 login suc");
			
		} catch (Exception e) {
			System.out.println("login fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);			
		}
				
		return mem;
	}
}





