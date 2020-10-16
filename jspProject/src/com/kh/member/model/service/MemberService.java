package com.kh.member.model.service;

import static com.kh.common.JDBCTemplate.*;

import java.sql.Connection;

import com.kh.member.model.dao.MemberDao;
import com.kh.member.model.vo.Member;


public class MemberService {
	
	
	
	/**
	 * 1. 로그인용 서비스
	 * @param userId  사용자가 입력한 아이디값
	 * @param userPwd 사용자가 입력한 비밀번호값 
	 * @return		    해당 아이디와 비밀번호가 일치하는 조회된 회원객체 / null
	 */
	public Member loginMember(String userId, String userPwd) {
		
		Connection conn = /*JDBCTemplate*/getConnection();
		
		Member loginUser = new MemberDao().loginMember(conn,userId,userPwd);
		
		close(conn);
		
		return loginUser;
	}
	
	public int insertMember(Member m ) {
		
		Connection conn = getConnection();
		
		int result = new MemberDao().insertMember(conn,m);
	
		if(result>0) {
			
			commit(conn); 
			
		}else { 
			
			rollback(conn);
			
			  }
	
		
		close(conn);
		
		return result;
	};
	
	
}
