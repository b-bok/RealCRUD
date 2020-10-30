package com.kh.member.model.dao;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import static com.kh.common.JDBCTemplate.*;
import com.kh.member.model.vo.Member;

public class MemberDao {
	
	
	private Properties prop = new Properties();
	
	public MemberDao() {
		// / == 최상위 폴더 
		String fileName =MemberDao.class.getResource("/sql/member/member-mapper.xml").getPath();
		
		try {
			//prop.load(new FileInputStream(fileName));
			prop.loadFromXML(new FileInputStream(fileName));
		} catch (FileNotFoundException e) {
			
			e.printStackTrace();
		} catch (IOException e) {
			
			e.printStackTrace();
		}
	}
	
	
	public Member loginMember(Connection conn, String userId, String userPwd) {
		// select문 => 한 행 => Member
		
		// 필요한 변수 세팅
		Member m = null;
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		// 실행할 sql문
		String sql = prop.getProperty("loginMember");
		
		try {
			pstmt = conn.prepareStatement(sql); // 애초에 sql문 담은채로 생성
			
			// 현재 담긴 sql문이 미완성된 sql문이기 때문에 바로 실행 불가!
			
			// 완성형태로 만든 후 실행 해주기
			pstmt.setString(1, userId); // ''가 묶인채로 삽입됨!
			pstmt.setString(2, userPwd);
			
			// 실행! (select문 => executeQuery(반환형ResultSet) / dml문 => executeUpdate(반환형))
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				
				m = new Member(
							   rset.getInt("USER_NO")
							  ,rset.getString("USER_ID")
							  ,rset.getString("USER_PWD")
							  ,rset.getString("USER_NAME")
							  ,rset.getString("PHONE")
							  ,rset.getString("EMAIL")
							  ,rset.getString("ADDRESS")
							  ,rset.getString("INTEREST")
							  ,rset.getDate("ENROLL_DATE")
							  ,rset.getDate("MODIFY_DATE")
							  ,rset.getString("STATUS")
							  );
				
			}
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally {
			/*JDBCTemplate.*/close(rset);
			/*JDBCTemplate.*/close(pstmt);
			
		}
		
		return m; // 일치하는 회원 있으면 Member 객체 반환// 없으면 null 반환
	}
	
	
	public int insertMember(Connection conn, Member m) {
		// insert문 => 처리된 행수
		
		// 필요 변수 셋팅
		PreparedStatement pstmt = null;
		int result = 0;
		
		String sql = prop.getProperty("insertMember"); // 미완성
		
		try {
			pstmt = conn.prepareStatement(sql); // 담긴 sql문이 미완성
			
			// 완성형태로 만들기
			pstmt.setString(1, m.getUserId());
			pstmt.setString(2, m.getUserPwd());
			pstmt.setString(3, m.getUserName());
			pstmt.setString(4, m.getPhone());
			pstmt.setString(5, m.getEmail());
			pstmt.setString(6, m.getAddress());
			pstmt.setString(7, m.getInterest());
			
			
			//실행 
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}
	
	
	public int updateMember(Connection conn, Member m) {
		// update문 => 처리된 행수
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("updateMember");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			// 완성형태로 채우기
			pstmt.setString(1, m.getUserName());
			pstmt.setString(2, m.getPhone());
			pstmt.setString(3, m.getEmail());
			pstmt.setString(4, m.getAddress());
			pstmt.setString(5, m.getInterest());
			pstmt.setString(6, m.getUserId());
			
			//실행
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			
			
			e.printStackTrace();
		}finally {
			close(pstmt);
		}

		return result;
	}
	
	
	public Member selectMember(Connection conn, String userId) {
		// select문 => 한행 조회 => Member객체
		
		Member m = null;
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectMember");
		
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userId);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				
				m = new Member(
						   rset.getInt("USER_NO")
						  ,rset.getString("USER_ID")
						  ,rset.getString("USER_PWD")
						  ,rset.getString("USER_NAME")
						  ,rset.getString("PHONE")
						  ,rset.getString("EMAIL")
						  ,rset.getString("ADDRESS")
						  ,rset.getString("INTEREST")
						  ,rset.getDate("ENROLL_DATE")
						  ,rset.getDate("MODIFY_DATE")
						  ,rset.getString("STATUS")  	
						);
						
			}
			
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		
		return m;
	}
	
	public int updatePwdMember(Connection conn, String userId, String userPwd, String updatePwd) {
		// update문 => 처리행수
		
		int result = 0;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("updatePwdMember");
		
		try {
			pstmt= conn.prepareStatement(sql);
			
			pstmt.setString(1, updatePwd);
			pstmt.setString(2, userId);
			pstmt.setString(3, userPwd);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally {
			close(pstmt);
			
		}
		
		return result;
		
		
	}
	
	
	public int deleteMember(Connection conn, String userId, String userPwd) {
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("deleteMember");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userId);
			pstmt.setString(2, userPwd);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		

		return result;
	}
	
	
	
	public int idCheck(Connection conn, String checkId) {
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		
		ResultSet rset = null;
		
		String sql = prop.getProperty("idCheck");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, checkId);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {

				result = rset.getInt(1);		
			}
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return result;

	}
	
}
