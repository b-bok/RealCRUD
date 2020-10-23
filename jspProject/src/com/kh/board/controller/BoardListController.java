package com.kh.board.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.board.model.service.BoardService;
import com.kh.board.model.vo.Board;
import com.kh.board.model.vo.PageInfo;

/**
 * Servlet implementation class BoardListController
 */
@WebServlet("/list.bo")
public class BoardListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardListController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// ------------------------------ 페이징 처리 ------------------------------------
		
		int listCount;			// 현재 일반 게시판 총 갯수
		int currentPage; 		// 사용자가 요청한 페이지 (즉, 현재 페이지)
		int pageLimit;			// 한 페이지 하단에 보여질 페이지 최대 갯수
		int boardLimit;			// 한 페이지 내에 보여질 게시글 최대 갯수
		
		int maxPage;			// 전체 페이지들 중 가장 마지막 페이지 수
		int startPage;			// 현재 사용자가 요청한 페이지에 하단에 보여질 페이징 바의 시작수
		int endPage;			// 현재 사용자가 요청한 페이지에 하단에 보여질 페이징 바의 끝 수
		
		
		// * listCount : 현재 일반 게시판 총 게시글 갯수
		
		listCount = new BoardService().selectListCount();
		
		// * currentPage : 사용자가 요청한 페이지 (즉, 현재 페이지)
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
		// * pageLimit : 한 페이지 하단에 보여질 페이지 최대 갯수
		pageLimit = 10;
		
		// * boardLimit : 한 페이지 내에 보여질 게시글 최대 갯수
		boardLimit = 10;
		
		// * maxPage :  제일 마지막 페이지 수
		
		/*
		 * 	ex) boardLimit : 10 이면?
		 * 
		 * 	총 게시글 / boardLimt 		  			  maxPage	
		 * 	 100.0개 / 10 	 => 10.0		= 		10
		 *   101.0개 / 10	 => 10.1		= 		11
		 *   102.0개 / 10	 => 10.2		=		11
		 * 	 109.0  / 10	 => 10.9		= 		11
		 *   
		 *  
		 *  총 게시글 갯수(실수)/boardLimit => 올림처리 = >  maxPage	
		 * 
		 * 
		 */

		maxPage = (int)Math.ceil((double)listCount/boardLimit);
		
	
		
		
		// * startPage : 현재 사용자가 요청한 페이지에 하단에 보여질 페이징 바 시작수
		
		/*
		 *  currentPage, pageLimit에 영향을 받음
		 *  
		 *  ex) pageLimit : 10 이라는 가정하에
		 *  	startPage : 1,11,21,31,41 => n*10 + 1 => n*pageLimit + 1
		 *  
		 *  	currentPage = 1 => 1  => 0 * 10 +1
		 *  	currentPage = 5 => 1  => 0 * 10 +1
		 *  	currentPage = 10 => 1 => 0 * 10 +1
		 *  	
		 *  	currentPage = 11 => 11  => 1 * 10 +1
		 *  	currentPage = 15 => 11  => 1 * 10 +1
		 *  	currentPage = 20 => 11 => 1 * 10 +1
		 *  
		 *  		1~10 		=> n = 0;	
		 *  		11~20		=> n = 1;
		 *  		
		 *  	n = (currentPage -1)/pageLimit	
		 *  
		 *  
		 * 		
		 * 
		 */
		startPage = ((currentPage -1) / pageLimit) * pageLimit + 1;
		
		
		// * endPage : 현재 사용자가 요청한 페이지에 하단에 보여질 페이징 바의 끝 수
		
		/*
		 * startPage, pageLimit에 기본적으로 영향을 받음
		 * 
		 */
		
		endPage = startPage + pageLimit -1;
		
		// 만약 maxPage가 고작 13까지 밖에 안된다면? endPage를 다시 13으로 해줘야함
		
		if(endPage > maxPage) {
			
			endPage = maxPage;
			
		}
		
		// 페이징바를 만들 때 필요한 정보들이 담겨있는 PageInfo 객체
		PageInfo pi = new PageInfo(listCount, currentPage, pageLimit, boardLimit, maxPage, startPage, endPage);
		
		
		// 사용자가 요청한 페이지에 뿌려줄 게시글 리스트
		ArrayList<Board> list = new BoardService().selectList(pi);
		

		request.setAttribute("pi", pi);
		request.setAttribute("list", list);
		
		request.getRequestDispatcher("views/board/boardListView.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
