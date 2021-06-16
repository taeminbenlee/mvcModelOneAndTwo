package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.BbsDto;

public class BbsDao {

	private static BbsDao dao = new BbsDao();
	
	private BbsDao() {
	}
	
	public static BbsDao getInstance() {
		return dao;
	}
	
	public List<BbsDto> getBbsList() {
		
		String sql = " SELECT SEQ, ID, REF, STEP, DEPTH, "
						+ " TITLE, CONTENT, WDATE, "
						+ " DEL, READCOUNT "
					+ " FROM BBS "
					+ " ORDER BY REF DESC, STEP ASC ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<BbsDto> list = new ArrayList<BbsDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getBbsList success");
				
			psmt = conn.prepareStatement(sql);
			System.out.println("2/4 getBbsList success");
			
			rs = psmt.executeQuery();
			System.out.println("3/4 getBbsList success");
			
			while(rs.next()) {
				BbsDto dto = new BbsDto(rs.getInt(1), 
										rs.getString(2), 
										rs.getInt(3), 
										rs.getInt(4), 
										rs.getInt(5), 
										rs.getString(6), 
										rs.getString(7), 
										rs.getString(8), 
										rs.getInt(9), 
										rs.getInt(10));
				list.add(dto);
			}			
			System.out.println("4/4 getBbsList success");
			
		} catch (SQLException e) {	
			System.out.println("getBbsList fail");
			e.printStackTrace();
		} finally {			
			DBClose.close(conn, psmt, rs);			
		}
		
		return list;
	}
	public BbsDto getBBS(int seq) {
		String sql = " SELECT SEQ, ID, REF, STEP, DEPTH, TITLE, CONTENT, "
				+ " WDATE, DEL, READCOUNT "
				+ " FROM BBS "
				+ " WHERE SEQ = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		BbsDto dto = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/5 getBBS success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/5 getBBS success");
			psmt.setInt(1, seq);
			System.out.println("3/5 getBBS success");
			rs=psmt.executeQuery();
			System.out.println("4/5 getBBS success");
			
			while (rs.next()) {
				dto = new BbsDto(rs.getInt(1), 
						rs.getString(2), 
						rs.getInt(3), 
						rs.getInt(4), 
						rs.getInt(5), 
						rs.getString(6), 
						rs.getString(7), 
						rs.getString(8), 
						rs.getInt(9), 
						rs.getInt(10));
				readcount(dto.getSeq());
				
			}
			System.out.println("5/5 getBBS success");

		} catch (SQLException e) {
			System.out.println("getBBS fail");

			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return dto;
		
	}
	public boolean writeBbs(BbsDto dto) {
		
		String sql = " INSERT INTO BBS "
					+ " (SEQ, ID, REF, STEP, DEPTH, "
					+ " TITLE, CONTENT, WDATE, "
					+ " DEL, READCOUNT) "
					+ " VALUES( SEQ_BBS.NEXTVAL, ?, "
							+ "	(SELECT NVL(MAX(REF), 0)+1 FROM BBS), 0, 0, "
							+ " ?, ?, SYSDATE, "
							+ " 0, 0) "; 
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 writeBbs success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			System.out.println("2/3 writeBbs success");
			
			count = psmt.executeUpdate();
			System.out.println("3/3 writeBbs success");			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			
			DBClose.close(conn, psmt, null);			
		}
		return count>0?true:false;
	}

	public void readcount(int seq) {
		String sql = " UPDATE BBS "
				+ " SET READCOUNT=READCOUNT+1 "
				+ " WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		
		
		try {
			
			conn = DBConnection.getConnection();
			System.out.println("1/3 readcount success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/3 readcount success");

			psmt.executeUpdate();
			System.out.println("3/3 readcount success");

			
			
		} catch (SQLException e) {
			System.out.println("readcount fail");
			e.printStackTrace();
			
		}
		finally {
			DBClose.close(conn, psmt, null);
		}
	}
	public boolean deleteBbs (int seq) {
		
		String sql = " UPDATE BBS "
				+ " SET DEL=1 "
				+ " WHERE SEQ=? ";
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 deleteBbs success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/3 deleteBbs success");
			
			count = psmt.executeUpdate();
			System.out.println("3/3 deleteBbs success");			
			
		} catch (Exception e) {
			System.out.println("deleteBbs fail");			

			e.printStackTrace();
		} finally {
			
			DBClose.close(conn, psmt, null);			
		}
		return count>0?true:false;
	}
	public boolean updateBbs(int seq, String title, String content) {
		String sql = " UPDATE BBS SET "
				+ " TITLE=?, CONTENT=? "
				+ " WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 updateBbs");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, title);
			psmt.setString(2, content);
			psmt.setInt(3, seq);
			
			System.out.println("2/3 updateBbs");
			
			count = psmt.executeUpdate();
			System.out.println("3/3 updateBbs");
			
		} catch (Exception e) {			
			e.printStackTrace();
		} finally{
			DBClose.close(conn, psmt, null);			
		}		
		
		return count>0?true:false;
	}
							//부모글 번호 //새로운 답글
	  public boolean answer(int seq, BbsDto dto) { //답변을 달려고 하는 글에 대한 정보를 얻어 와야할것이다.. 
		  //답변글의 스텝을 늘려주는 쿼리
		  //UPDATE
		  String sql1 = " UPDATE BBS "
		  				+ " SET STEP=STEP+1 "
		  				+ " WHERE REF=(SELECT REF FROM BBS WHERE SEQ=?) "
		  				+ " AND STEP>(SELECT STEP FROM BBS WHERE SEQ=?) ";
		  //INSERT
		    String sql2 = " INSERT INTO BBS "
		               + " (SEQ, ID, "
		               + " REF, STEP, DEPTH, "
		               + " TITLE, CONTENT, WDATE, DEL, READCOUNT) "
		               + " VALUES(SEQ_BBS.NEXTVAL, ?, "
		               + "    (SELECT REF FROM BBS WHERE SEQ=?), "   //REF
		               + "    (SELECT STEP FROM BBS WHERE SEQ=?) + 1, " //STEP
		               + "    (SELECT DEPTH FROM BBS WHERE SEQ=?) + 1, " //DEPTH
		               + "    ?, ?, SYSDATE, 0, 0) ";

			  		
		  Connection conn = null;
		  PreparedStatement psmt = null;
		  int count = 0;	 
		  
		  
			
		  try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);		//자동커밋 해제
			System.out.println("1/6 success answer"); 
			
			//update
			psmt = conn.prepareStatement(sql1);
		 
			psmt.setInt(1, seq);
			psmt.setInt(2, seq);
			System.out.println("2/6 success answer"); 
			count = psmt.executeUpdate();
			System.out.println("3/6 success answer"); 

			//psmt 초기화
			psmt.clearParameters();
			
			//insert
			psmt = conn.prepareStatement(sql2);
			
			psmt.setString(1, dto.getId());
			psmt.setInt(2, seq);
			psmt.setInt(3, seq);
			psmt.setInt(4, seq);
			psmt.setString(5, dto.getTitle());
			psmt.setString(6, dto.getContent());
			System.out.println("4/6 success answer"); 

			count = psmt.executeUpdate();
			System.out.println("5/6 success answer"); 

			conn.commit();
			System.out.println("6/6 success answer"); 

		} catch (SQLException e) {
			System.out.println("answer fail"); 
			
			try {
				conn.rollback();
			} catch (SQLException e1) {
				
				e1.printStackTrace();
			}
			
			e.printStackTrace();
		}
		finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
			DBClose.close(conn, psmt, null);
		}
		  return count>0?true:false;
	  
	 }
	  public List<BbsDto> searchBbsList(String col, String keyword){
		  
		  Connection conn = null;
		  PreparedStatement psmt = null;
		  ResultSet rs = null;
		  List<BbsDto> slist = new ArrayList<BbsDto>();
		 //검색 아이디
		 String sql1 = " SELECT SEQ, ID, REF, STEP, DEPTH, "
					+ " TITLE, CONTENT, WDATE, "
					+ " DEL, READCOUNT "
				+ " FROM BBS ";
		 
		 conn = DBConnection.getConnection();
		 System.out.println("1/4 searchBbsList Success"); 		

		 
		 try {
			 	 
				 if(col.equals("title")) {
					 sql1 = sql1 + " WHERE TITLE LIKE ? "
								 + " ORDER BY REF DESC, STEP ASC ";	 
				 
					psmt = conn.prepareStatement(sql1);
					psmt.setString(1, '%' + keyword + '%');
			System.out.println("2/4 searchBbsList Success");
				
			 }else if(col.equals("id")) {
				 sql1 = sql1 + " WHERE ID LIKE ? "
				 		+ " ORDER BY REF DESC, STEP ASC ";
				 psmt = conn.prepareStatement(sql1);
				 psmt.setString(1, '%' + keyword + '%');
			System.out.println("3/4 searchBbsList Success");
			 }
				 rs = psmt.executeQuery();
				while (rs.next() == true) {
					BbsDto bbs = new BbsDto();
					bbs.setSeq(rs.getInt(1));
					bbs.setId(rs.getString(2));	
					bbs.setRef(rs.getInt(3));		
					bbs.setStep(rs.getInt(4));		 
					bbs.setDepth(rs.getInt(5));		 
					bbs.setTitle(rs.getString(6));		
					bbs.setContent(rs.getString(7));		
					bbs.setWdate(rs.getString(8)); 
					bbs.setDel(rs.getInt(9));		 
					bbs.setReadcount(rs.getInt(10));		 
							
					
					slist.add(bbs);
			System.out.println("4/4 searchBbsList Success");		
				}


			} catch (SQLException e) {
			System.out.println("searchBbsList fail");		

				e.printStackTrace();
			} finally {
				DBClose.close(conn, psmt, rs);
				
			}
			 return slist;
	
	  }

		public List<BbsDto> getBbsPagingList(String choice, String search, int page) {
			
			String sql = " SELECT SEQ, ID, REF, STEP, DEPTH, "
						+ " TITLE, CONTENT, WDATE, DEL, READCOUNT "
						+ " FROM ";
			
			sql += "(SELECT ROW_NUMBER()OVER(ORDER BY REF DESC, STEP ASC) AS RNUM, " + 
					"	SEQ, ID, REF, STEP, DEPTH, TITLE, CONTENT, WDATE, DEL, READCOUNT " + 
					"	FROM BBS ";
			
			String sWord = "";
			if(choice.equals("id")) {
				sWord = " WHERE ID='" + search + "'";
			}else if(choice.equals("content")) {
				sWord = " WHERE CONTENT LIKE '%" + search + "%' ";
			}else if(choice.equals("writer")) {
				sWord = " WHERE ID='" + search + "'";
			} 
			sql = sql + sWord;
			
			sql = sql + " ORDER BY REF DESC, STEP ASC) ";
			
			sql = sql + "WHERE RNUM >= ? AND RNUM <= ? ";
			
			int start, end;
			start = 1 + 10 * page;
			end = 10 + 10 * page;
			
			Connection conn = null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			
			List<BbsDto> list = new ArrayList<BbsDto>();
			
			try {
				conn = DBConnection.getConnection();
				System.out.println("1/4 getBbsSearchList success");
					
				psmt = conn.prepareStatement(sql);
				psmt.setInt(1, start);
				psmt.setInt(2, end);
				System.out.println("2/4 getBbsSearchList success");
				
				rs = psmt.executeQuery();

				System.out.println("3/4 getBbsSearchList success");
				
				while(rs.next()) {
					BbsDto dto = new BbsDto(rs.getInt(1), 
											rs.getString(2), 
											rs.getInt(3), 
											rs.getInt(4), 
											rs.getInt(5), 
											rs.getString(6), 
											rs.getString(7), 
											rs.getString(8), 
											rs.getInt(9), 
											rs.getInt(10));
					list.add(dto);
				}			
				System.out.println("4/4 getBbsSearchList success");
				
			} catch (SQLException e) {	
				System.out.println("getBbsSearchList fail");
				e.printStackTrace();
			} finally {			
				DBClose.close(conn, psmt, rs);			
			}
			
			return list;
		}
		
		public int getAllBbs(String choice, String search) {
			String sql = " SELECT COUNT(*) FROM BBS ";
			
			String sWord = "";
			if(choice.equals("title")) {
				sWord = " WHERE TITLE LIKE '%" + search + "%' ";
			}else if(choice.equals("content")) {
				sWord = " WHERE CONTENT LIKE '%" + search + "%' ";
			}else if(choice.equals("writer")) {
				sWord = " WHERE ID='" + search + "'";
			} 
			sql = sql + sWord;
			
			Connection conn = null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			
			int len = 0;
			
			
			
			try {
				conn = DBConnection.getConnection();
				System.out.println("1/4 getAllBbs success");
				
				psmt = conn.prepareStatement(sql);
				System.out.println("2/4 getAllBbs success");
				rs = psmt.executeQuery();
				System.out.println("3/4 getAllBbs success");
				if(rs.next()) {
					len = rs.getInt(1);
				}
				System.out.println("4/4 getAllBbs success");
			} catch (SQLException e) {
				System.out.println("getAllBbs fail");
				e.printStackTrace();
			} finally {
				DBClose.close(conn, psmt, rs);
			}
			
			return len;
			
		}
	  
}



