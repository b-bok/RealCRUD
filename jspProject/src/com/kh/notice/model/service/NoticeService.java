package com.kh.notice.model.service;

import static com.kh.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.*;

import com.kh.notice.model.dao.NoticeDao;
import com.kh.notice.model.vo.Notice;

/**
 * @author hooyu
 *
 */
public class NoticeService {
	
	/**
	 * 1. 공지사항 전체조회용 서비스
	 * @return 조회된 공지사항 리스트
	 */
	public ArrayList<Notice> selectNoticeList() {
		
		Connection conn = getConnection();
		
		ArrayList<Notice> list = new NoticeDao().selectNoticeList(conn);
		
		close(conn);
		
		return list;
		
	}
	
	/**
	 * 2. 공지사항 작성용 서비스
	 * @param n		사용자가 입력한 제목, 내용, 로그인한 사용자 번호가 담긴 Notice 객체
	 * @return 		처리된 행수 반환
	 */
	public int insertNotice(Notice n) {
		
		Connection conn = getConnection();
		
		int result = new NoticeDao().insertNotice(conn, n);
		
		if(result>0) {
			
			commit(conn);
			
		}else {
			
			rollback(conn);
		}
		
		close(conn);
		
		return result;
		
	}
	
	/**
	 * 3_1. 상세조회요청한 공지사항 조회수 증가용 서비스
	 * @param nno		상세조회 요청한 해당 공지사항 글 번호
	 * @return			처리된 행수
	 */
	public int increaseCount(int nno) {
		
		Connection conn = getConnection();
		
		int result = new NoticeDao().increaseCount(conn, nno);
		
		if(result>0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
		
	}
	
	public Notice selectNotice(int nno) {
		
		Connection conn =getConnection();
		
		Notice n = new NoticeDao().selectNotice(conn, nno);
		
		//트랜잭션 필요 없음 select문 실행하기 때문
		
		close(conn);
		
		
		return n;
	}
	
	
	public int updateNotice(Notice n) {
		
		Connection conn = getConnection();
		
		int result = new NoticeDao().noticeUpdate(conn, n);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
	}
	
	public int deleteNotice(int nno) {
		Connection conn = getConnection();
		
		int result = new NoticeDao().deleteNotice(conn, nno);
		
		if(result > 0) {
			
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
	}
	
}
