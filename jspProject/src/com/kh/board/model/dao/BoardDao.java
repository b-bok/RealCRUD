package com.kh.board.model.dao;

import static com.kh.common.JDBCTemplate.close;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;

import com.kh.board.model.vo.Attachment;
import com.kh.board.model.vo.Board;
import com.kh.board.model.vo.PageInfo;

public class BoardDao {
	
	private Properties prop = new Properties();
	
	
	public BoardDao() {
		
		
		// "C:\servlet-jsp-workspace2\jspProject\WebContent\WEB-INF\classes\sql\board\board-mapper.xml"
		// "/" 최상위 폴더
		try {
			prop.loadFromXML(new FileInputStream(BoardDao.class.getResource("/sql/board/board-mapper.xml").getPath()));
		} catch (IOException e) {
			
			e.printStackTrace();
		}
		
	}
	
	
	
	public int selectListCount(Connection conn) {
		
		int listCount = 0;
		
		Statement stmt = null;
		ResultSet rset = null;
		
		
		String sql = prop.getProperty("selectListCount");
		
		try {
			
		stmt = conn.createStatement();
		
		rset = stmt.executeQuery(sql);
		
		while(rset.next()) {
			
			listCount = rset.getInt("listcount");
		}
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally {
			
			close(rset);
			
			close(stmt);
			
		}
		

		return listCount;
		
	};
	
	
	
	public ArrayList<Board> selectList(Connection conn, PageInfo pi) {
		
		ArrayList<Board> list = new ArrayList<>();
		
		PreparedStatement pstmt = null;
		
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectList");
		
		try {
			
			pstmt = conn.prepareStatement(sql);
			
			/*
			 * 
			 *  boardLimit : 10이라는 가정하에
			 *  currnetPage = 1 	=> startRow : 1  endRow : 10
			 *  currentPgae = 2 	=> startRow : 11 endRow : 20
			 *  currentPage = 3		=> startRow : 21 endRow
			 *  
			 *  
			 *  startRow = (currentPage -1) * boardLimit +1;
			 *  endRow = startRow + boardLimt -1
			 * 
			 */
			
			int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit() +1;
			int endRow = startRow + pi.getBoardLimit() -1;
			
			
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				
				list.add(new Board(
									
								    rset.getInt("board_no")
								  , rset.getString("category_name") 
								  , rset.getString("board_title")
								  , rset.getString("user_id")
								  , rset.getInt("count")
								  , rset.getDate("create_date")
						
								   )
						); 
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			
			close(rset);
			close(pstmt);
		}
		

		return list;
	}
	
	
	
	public int insertBoard(Connection conn, Board b) {
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("insertBoard");
		
		try {
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, Integer.parseInt(b.getCategory()));
			pstmt.setString(2, b.getBoardTitle());
			pstmt.setString(3, b.getBoardContent());
			pstmt.setInt(4, Integer.parseInt(b.getBoardWriter()));

			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally {
			close(pstmt);
			
		}
		
		return result;
	}
	
	
	public int insertAttachment(Connection conn, Attachment at) {
		int result = 0;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("insertAttachment");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, at.getOriginName());
			pstmt.setString(2, at.getChangeName());
			pstmt.setString(3, at.getFilePath());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}
	
	
	public int increaseCount(Connection conn, int bno) {
		int result = 0;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("increaseCount");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, bno);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally {
			close(pstmt);
			
		}
		
		return result;
		
	}
	
	
	public Board selectBoard(Connection conn, int bno) {
		
		Board b = null;
		
		PreparedStatement pstmt = null;
		
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectBoard");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, bno);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				
				b= new Board(
						      rset.getInt("board_no")
						    , rset.getString("category_name")
						    , rset.getString("board_title")
						    , rset.getString("board_content")
						    , rset.getString("user_id")
						    , rset.getDate("create_date")
						
							);
			}
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		
		return b;
	}
	
	
	public Attachment selectAttachment(Connection conn, int bno) {
		
		Attachment at = null;
		
		PreparedStatement pstmt = null;
		
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectAttachment");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, bno);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				
				at = new Attachment (
									  rset.getInt("file_no")
									, rset.getString("origin_name")
									, rset.getString("change_name")
									, rset.getString("file_path")
									);
			}
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return at;
	}
	
	
}
