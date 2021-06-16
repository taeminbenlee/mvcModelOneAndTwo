package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.CalendarDto;

public class CalendarDao {
	
	
	
	private static CalendarDao dao = new CalendarDao();
	
	private CalendarDao() {
		// TODO Auto-generated constructor stub
	}
	
	public static CalendarDao getInstance() {
		return dao;
	}
	
	public List<CalendarDto> getCalendarList(String id, String yyyyMM){
		String sql = " SELECT SEQ, ID, TITLE, CONTENT, RDATE, WDATE " + 
					" FROM " + 
					" (SELECT ROW_NUMBER()OVER(PARTITION BY SUBSTR(RDATE, 1, 8)ORDER BY RDATE ASC) AS RNUM, " + 
					"      SEQ, ID, TITLE, CONTENT, RDATE, WDATE " + 
					" FROM EVENTCALENDAR " + 
					" WHERE ID=? AND SUBSTR(RDATE, 1, 6)=?) " + 
					" WHERE RNUM BETWEEN 1 AND 5 ";
		
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<CalendarDto> list = new ArrayList<CalendarDto>();
		
		try {
			
			conn = DBConnection.getConnection();
			System.out.println("1/4 getCalendarList Success");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, yyyyMM);
			System.out.println("2/4 getCalendarList Success");
			rs = psmt.executeQuery();
			System.out.println("3/4 getCalendarList Success");
			while(rs.next()) {
				int i = 1;
				CalendarDto dto = new CalendarDto(	rs.getInt(i++), 
													rs.getString(i++), 
													rs.getString(i++), 
													rs.getString(i++), 
													rs.getString(i++), 
													rs.getString(i++) );
				list.add(dto);
				System.out.println("4/4 getCalendarList Success");
			}
			
		} catch (SQLException e) {
			System.out.println("getCalendarList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		return list;
		
		
	}
	
	public boolean addCalendar(CalendarDto cal) {
		
		String sql = " INSERT INTO EVENTCALENDAR(SEQ, ID, TITLE, CONTENT, RDATE, WDATE )"
				+ " VALUES(SEQ_CAL.NEXTVAL, ?, ?, ?, ?, SYSDATE ) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 addCalendar Success");
			psmt = conn.prepareStatement(sql);
			System.out.println("2/4 addCalendar Success");
			psmt.setString(1, cal.getId());
			psmt.setString(2, cal.getTitle());
			psmt.setString(3, cal.getContent());
			psmt.setString(4, cal.getRdate());
			System.out.println("3/4 addCalendar Success");
			count = psmt.executeUpdate();
			System.out.println("4/4 addCalendar Success");
		} catch (SQLException e) {
			System.out.println("addCalendar fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		return count>0?true:false;
		
	}
	
	 public CalendarDto getDetail(int seq) {
		 String sql = " SELECT SEQ, ID, TITLE, CONTENT, RDATE, WDATE " + 
					" FROM EVENTCALENDAR " + 
					" WHERE SEQ=? "; 
					
		 Connection conn = null;
		 PreparedStatement psmt = null;
		 ResultSet rs = null;
		 
		 CalendarDto dto = null;
		 
		 
		 
		 try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getDetail Success");
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/4 getDetail Success");
			rs = psmt.executeQuery();
			System.out.println("3/4 getDetail Success");
			while(rs.next()) {
				int i = 1;
				dto = new CalendarDto(	rs.getInt(i++), 
										rs.getString(i++), 
										rs.getString(i++), 
										rs.getString(i++), 
										rs.getString(i++), 
										rs.getString(i++) );
										
			}
			System.out.println("4/4 getDetail Success");
		} catch (SQLException e) {
			System.out.println("getDetail fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		return dto; 
	 }
		 
	 public List<CalendarDto> getEventList(String id, String dates){
		 String sql = " SELECT SEQ, ID, TITLE, CONTENT, RDATE, WDATE " + 
					" FROM EVENTCALENDAR " + 
					" WHERE ID=? "
					+ " AND "
					+ " RDATE LIKE '" + dates + "%' ";
		 
		 Connection conn = null;
		 PreparedStatement psmt = null;
		 ResultSet rs = null;
		 
		 List<CalendarDto> list = new ArrayList<CalendarDto>();
		 
		 
		 
		 try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getEventList Success");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			System.out.println("2/4 getEventList Success");
			rs = psmt.executeQuery();
			System.out.println("3/4 getEventList Success");
			while(rs.next()) {
				int i = 1;
				CalendarDto dto = new CalendarDto(	rs.getInt(i++), 
													rs.getString(i++), 
													rs.getString(i++), 
													rs.getString(i++), 
													rs.getString(i++), 
													rs.getString(i++) );
				list.add(dto);
			}
			System.out.println("4/4 getEventList Success");
		} catch (SQLException e) {
			System.out.println("getEventList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		 return list;
		 
		 
	 }
	 public boolean deleteEvent (int seq) {
			
			String sql = " DELETE FROM EVENTCALENDAR "
							+ " WHERE SEQ=? ";
			Connection conn = null;
			PreparedStatement psmt = null;
			int count = 0;
			
			try {
				conn = DBConnection.getConnection();
				System.out.println("1/3 deleteEvent success");
				
				psmt = conn.prepareStatement(sql);
				psmt.setInt(1, seq);
				System.out.println("2/3 deleteEvent success");
				
				count = psmt.executeUpdate();
				System.out.println("3/3 deleteEvent success");			
				
			} catch (Exception e) {
				System.out.println("deleteEvent fail");			

				e.printStackTrace();
			} finally {
				
				DBClose.close(conn, psmt, null);			
			}
			return count>0?true:false;
		}
	
	 public boolean updateEvent(int seq, String title, String content) {
			String sql = " UPDATE EVENTCALENDAR SET "
					+ " TITLE=?, CONTENT=? "
					+ " WHERE SEQ=? ";
			
			Connection conn = null;
			PreparedStatement psmt = null;
			int count = 0;
			
			try {
				conn = DBConnection.getConnection();
				System.out.println("1/3 updateEvent");
				
				psmt = conn.prepareStatement(sql);
				psmt.setString(1, title);
				psmt.setString(2, content);
				psmt.setInt(3, seq);
				
				System.out.println("2/3 updateEvent");
				
				count = psmt.executeUpdate();
				System.out.println("3/3 updateEvent");
				
			} catch (Exception e) {			
				e.printStackTrace();
			} finally{
				DBClose.close(conn, psmt, null);			
			}		
			
			return count>0?true:false;
		}
	
	
	
}
