package com.kh.notice.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.notice.model.service.NoticeService;
import com.kh.notice.model.vo.Notice;

/**
 * Servlet implementation class NoticeDetailController
 */
@WebServlet("/detail.no")
public class NoticeDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NoticeDetailController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// NumberFormatException => nno에 널값이 들어갔을 때
		int nno = Integer.parseInt(request.getParameter("nno")); // "7" => 7 로 파싱해줌
		
		int result = new NoticeService().increaseCount(nno);
		
		if(result > 0) {// 유효한 공지사항 번호일 경우 => 해당 공지사항 상세조회후  => 상세 페이지 띄우기
			
			Notice n = new NoticeService().selectNotice(nno);
			
			request.setAttribute("n", n);
			
			request.getRequestDispatcher("views/notice/noticeDetailView.jsp").forward(request, response);
			
		}else { // 유효한 공지사항이 아님
			
			request.setAttribute("alertMsg", "유효한 공지사항이 아닙니다.");
			
			RequestDispatcher view =  request.getRequestDispatcher("views/common/errorPage.jsp");
			
			view.forward(request, response);
			
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
