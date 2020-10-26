package com.kh.board.model.service;

import static com.kh.common.JDBCTemplate.close;
import static com.kh.common.JDBCTemplate.commit;
import static com.kh.common.JDBCTemplate.getConnection;
import static com.kh.common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import com.kh.board.model.dao.BoardDao;
import com.kh.board.model.vo.Attachment;
import com.kh.board.model.vo.Board;
import com.kh.board.model.vo.PageInfo;

public class BoardService {

	
	public int selectListCount() {
		
		Connection conn = getConnection();
		
		int listCount = new BoardDao().selectListCount(conn);
		
		close(conn);
		
		return listCount;
	}
	
	
	public ArrayList<Board> selectList(PageInfo pi) {
		
		Connection conn = getConnection();
		
		ArrayList<Board> list = new BoardDao().selectList(conn, pi);
		
		close(conn);

		return list;
	}
	
	/**
	 * 2. 일반게시판 작성용 서비스
	 * @param b			제목, 내용, 카테고리 번호, 작성자 회원번호 담긴 객체
	 * @param at		첨부파일 o=? 원본명, 수정명, 폴더경로 담겨 있는 Attachment 객체 / 첨부파일=x? null
	 * @return
	 */
	public int insertBoard(Board b, Attachment at) {
		
		
		
		Connection conn = getConnection();
		
		int result1 = new BoardDao().insertBoard(conn,b);
		
		int result2 = 1;
		
		if(at != null) {	// 첨부파일이 있었을 경우
			
			result2 = new BoardDao().insertAttachment(conn, at);
			
		}

		if(result1 >0 && result2 >0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		
		return result1*result2; 
	}
	
	public int increaseCount(int bno) {
		
		Connection conn = getConnection();
		
		int result = new BoardDao().increaseCount(conn, bno);
		
		if(result>0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
		
	}
	
	public Board selectBoard(int bno) {
		
		Connection conn = getConnection();
		
		Board b = new BoardDao().selectBoard(conn, bno);
		
		close(conn);
		
		return b;
	}
	
	
	public Attachment selectAttachment(int bno) {
		Connection conn = getConnection();
		
		Attachment at = new BoardDao().selectAttachment(conn, bno);
		
		close(conn);
		
		return at;
	}
	
}
