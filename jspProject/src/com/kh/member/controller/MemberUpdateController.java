package com.kh.member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.member.model.service.MemberService;
import com.kh.member.model.vo.Member;

/**
 * Servlet implementation class MemberUpdateController
 */
@WebServlet("/update.me")
public class MemberUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberUpdateController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 인코딩 설정 (utf-8)
		request.setCharacterEncoding("utf-8");
		
		// 요청시 전달된 값 뽑기
		String userId = request.getParameter("userId");
		String userName = request.getParameter("userName");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		String address = request.getParameter("address");
		
		String[] interests = request.getParameterValues("interest");
		
		String interest = "";
		
		if(interests != null) {
			interest = String.join(",", interests);
		}
		
		Member m = new Member(userId, userName, phone, email, address,interest);
		
		// 요청 처리할 서비스의 메소드 호출하기
		
		Member updateMem = new MemberService().updateMember(m);
		
		if(updateMem == null) { // 정보변경 실패 => 에러페이지
			
			request.setAttribute("errorMsg", "회원정보 수정에 실패하셨습니다.");
			
			RequestDispatcher view = request.getRequestDispatcher("views/common/errorPage.jsp");
			view.forward(request, response);
			
			
		}else { // 정보변경 성공 => url재요청(/jsp/myPage.me)
			
			//session에 담겨있는 loginUser 덮어쓰기
			
			HttpSession session = request.getSession();
			
			session.setAttribute("loginUser", updateMem); // 동일한 키값으로 담아주면 덮어쓰기됨!
			session.setAttribute("alertMsg", "성공적으로 회원정보를 수정했습닏다.");
			
			
			response.sendRedirect(request.getContextPath() + "/myPage.me");
			
			
			
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
