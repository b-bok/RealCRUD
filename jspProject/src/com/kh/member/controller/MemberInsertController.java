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
 * Servlet implementation class MemberInsertController
 */
@WebServlet("/insert.me")
public class MemberInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberInsertController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//회원가입 요청처리용 controller
		
		
		
		// 1. 요청시 전달값 한글이 있을 경우 대비에서 인코딩 (post방식)
		request.setCharacterEncoding("utf-8");
		
		// 2. 요청시 전달값 뽑기 (request의 parameter영역으로부터)
		String userId = request.getParameter("userId");
		String userPwd = request.getParameter("userPwd");
		String userName = request.getParameter("userName");
		String phone = request.getParameter("phone");					// ""
		String email = request.getParameter("email");					// ""
		String address = request.getParameter("address"); 				// ""
		String[] interests = request.getParameterValues("interest");	// null
		// String[] --> String
		// ["운동","등산"] --> "운동,등산"
		
		String interest = "";
		
		if(interests != null) {
			interest = String.join(",", interests);
		}else {
			interest = "취미없음";
		}
		
		// 기본 생성자로 생성 후 각 필드에 setter메소드로 담아주기
		
		// 매개 변수 생성자 이용해서 담기

		Member m = new Member(userId,userPwd,userName,phone,email,address,interest);
		
		// 3. 요청을 처리해주는 서비스 클래스의 메소드 호출 후 결과 받기
		int result = new MemberService().insertMember(m);
		// 4. 반환 받은 결과를 가지고 사용자가 보게될 응답 페이지 지정
		if(result>0) {// 회원 가입 성공 = 인덱스페이지 띄우기
			//System.out.println("회원가입 성공");
			
			// session영역에 alert로 띄워줄 메세지 담기
			HttpSession session = request.getSession();
			session.setAttribute("alertMsg", "성공적으로 회원가입이 완료됐습니다.");
			
			// redirect 방식 (url을 재요청)
			response.sendRedirect(request.getContextPath());
			
		}else {// 회원 가입 실패 = 에러 페이지
			//System.out.println("회원가입 실패");

			request.setAttribute("errorMsg", "회원가입 실패했으요");
			
			RequestDispatcher view = request.getRequestDispatcher("views/common/errorPage.jsp");
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
