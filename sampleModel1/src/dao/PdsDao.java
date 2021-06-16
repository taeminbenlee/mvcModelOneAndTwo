package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.PdsDto;

public class PdsDao {
	private static PdsDao dao = new PdsDao();
	
	private PdsDao() {
	}
	
	public static PdsDao getInstance() {
		return dao;
	}
	
	public List<PdsDto> getPdsList() {
		
		String sql = " SELECT SEQ, ID, TITLE, CONTENT, "
				+ " FILENAME, NEWFILENAME, READCOUNT, DOWNCOUNT, REGDATE "
				+ " FROM PDS "
				+ " ORDER BY SEQ DESC ";	// + " ORDER BY REF DESC, STEP ASC ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<PdsDto> list = new ArrayList<PdsDto>();
		
		conn = DBConnection.getConnection();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 S getPdsList");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/4 S getPdsList");
			
			rs = psmt.executeQuery();
			System.out.println("3/4 S getPdsList");
			
			while(rs.next()) {
				int i = 1;
				PdsDto dto = new PdsDto(rs.getInt(i++), 
										rs.getString(i++), 
										rs.getString(i++), 
										rs.getString(i++), 
										rs.getString(i++), 
										rs.getString(i++),
										rs.getInt(i++), 
										rs.getInt(i++), 
										rs.getString(i++));
				list.add(dto);
			}
			System.out.println("4/4 S getPdsList");
			
		} catch (SQLException e) {	
			System.out.println("Fail getPdsList");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);			
		}
		
		return list;
	}
	
	public boolean writePds(PdsDto pds) {
		String sql = " INSERT INTO PDS(SEQ, ID, TITLE, CONTENT, FILENAME, NEWFILENAME, "
								+ "	READCOUNT, DOWNCOUNT, REGDATE) "
				   + " VALUES(SEQ_PDS.NEXTVAL, ?, ?, ?, ?, ?, "
								+ "	0, 0, SYSDATE)";
		
		Connection conn = null;
		PreparedStatement psmt = null;		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 S writePds");
				
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, pds.getId());
			psmt.setString(2, pds.getTitle());
			psmt.setString(3, pds.getContent());
			psmt.setString(4, pds.getFilename());
			psmt.setString(5, pds.getNewFilename());
			System.out.println("2/3 S writePds");
			
			count = psmt.executeUpdate();	
			System.out.println("3/3 S writePds");
			
		} catch (SQLException e) {
			System.out.println("fail writePds");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}

		return count>0?true:false;
	}
	
	public PdsDto getPds(int seq) {
		
		String sql = " SELECT SEQ, ID, TITLE, CONTENT, "
				+ " FILENAME, NEWFILENAME, READCOUNT, DOWNCOUNT, REGDATE "
				+ " FROM PDS "
				+ " WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		PdsDto pds = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getPds Success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/4 getPds Success");
			
			rs = psmt.executeQuery();
			System.out.println("3/4 getPds Success");
			
			if(rs.next()) {
				int i = 1;				
				pds = new PdsDto(rs.getInt(i++), 
								rs.getString(i++), 
								rs.getString(i++), 
								rs.getString(i++), 
								rs.getString(i++), 
								rs.getString(i++),
								rs.getInt(i++), 
								rs.getInt(i++), 
								rs.getString(i++));				
			}
			System.out.println("4/4 getPds Success");
			
		} catch (Exception e) {		
			System.out.println("getPds Fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);			
		}
				
		return pds;
	}
	
	public boolean pdsReadCount(int seq) {
		int count=0;
		String sql=" UPDATE PDS SET " +
				" READCOUNT=READCOUNT+1 " +
				" WHERE  SEQ=? ";
		
		Connection conn=null;
		PreparedStatement psmt=null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 S  pdsReadCount");
			
			psmt=conn.prepareStatement(sql);
			psmt.setInt(1, seq );
			System.out.println("2/3 S  pdsReadCount");
			
			count=psmt.executeUpdate();
			System.out.println("3/3 S  pdsReadCount");
			
		} catch (Exception e) {
			System.out.println("F pdsReadCount");
		}finally{
			DBClose.close(conn, psmt, null);
		}
		return count>0?true:false;
	}
	
	public boolean updatePds(int seq, PdsDto pds) {
		int count = 0;
		String sql = " UPDATE PDS "
				+ " SET TITLE=?, CONTENT=?, FILENAME=?, REGDATE=SYSDATE "
				+ " WHERE SEQ=? ";
		
		Connection conn= null;
		PreparedStatement psmt = null;
		
		
		
		try {
			
			conn = DBConnection.getConnection();
			System.out.println("1/3 S  updatePds");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, pds.getTitle());
			psmt.setString(2, pds.getContent());
			psmt.setString(3, pds.getFilename());
			psmt.setInt(4, seq);
			System.out.println("2/3 S  updatePds");
			count = psmt.executeUpdate();
			System.out.println("3/3 S  updatePds");
		} catch (SQLException e) {
			System.out.println("fail updatePds");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		
		
		return count>0?true:false;
	}
}









