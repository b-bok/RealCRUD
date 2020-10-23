package com.kh.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.member.model.service.MemberService;

/**
 * Servlet implementation class MemberDeleteController
 */
@WebServlet("/delete.me")
public class MemberDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberDeleteController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 요청시 전달값 뽑기 (아이디, 비밀번호)
		String userId = request.getParameter("userId");
		String userPwd = request.getParameter("userPwd");
		
		
		// 뽑을 두개 값 MemberService deleteMember 메소드로 전달 호출 결과는 int로!
		int result = new MemberService().deleteMember(userId, userPwd);
		
		//결과값을로
		
		if(result > 0) { //성공했을 경우
			
			// 세션에 담겨있는 loginUser라는 키값 제시해서 삭제(removeAttribute("키값"))
			HttpSession session = request.getSession();
			session.removeAttribute("loginUser");
			// 세션에 alert 보이고, 문구 담기
			session.setAttribute("alertMsg", "회원이 삭제 되었습니다.");
			
			// "/jsp" url  재요청
			response.sendRedirect(request.getContextPath());
		}else { // 실패 했을 경우
			
			// 에러페이지 포워딩(문구 담아서)
			request.setAttribute("errorMsg", "회원탈퇴 실패했소!");
			request.getRequestDispatcher("views/common/erroPage.jsp").forward(request, response);
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
