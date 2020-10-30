package com.kh.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.board.model.service.BoardService;
import com.kh.board.model.vo.Attachment;
import com.kh.board.model.vo.Board;

/**
 * Servlet implementation class BoardDetailController
 */
@WebServlet("/detail.bo")
public class BoardDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardDetailController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		int bno = Integer.parseInt(request.getParameter("bno"));
		
		// 조회수 증가
		int result = new BoardService().increaseCount(bno);
		
	
		if(result>0) {
			// 게시글 정보 조회 (Board)
			Board b = new BoardService().selectBoard(bno);
			// 첨부파일 정보 조회 (Attachment)
			Attachment at = new BoardService().selectAttachment(bno);
			
			request.setAttribute("b", b);
			
			request.setAttribute("at", at);
		
			System.out.println(b);
			System.out.println(at);
			
			
			request.getRequestDispatcher("views/board/boardDetailView.jsp").forward(request, response);
			
		}else {
			
			request.setAttribute("errorMsg", "유효한 게시글이 아니거나, 삭제된 게시글입니다.");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
			
		}
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
