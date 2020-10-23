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
 * Servlet implementation class LoginController
 */
@WebServlet("/login.me")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 로그인 요청 controller
		
		
		// 요청시 전달값 == request의 parameter영역
		
		// 1. 전달값에 한글이 있는 경우 인코딩 처리해야함! (post방식)
		request.setCharacterEncoding("utf-8");
		
		// 2. 요청시 전달값 꺼내서 변수 또는 객체에 기록
		String userId = request.getParameter("userId");
		String userPwd = request.getParameter("userPwd");
		
		// 3. 해당 요청을 처리하는 서비스 클래스의 메소드 호출 한 후 그에 해당하는 결과 받기
		Member loginUser = new MemberService().loginMember(userId,userPwd);
		
		// 4. 반환받은 결과를 가지고 사용자가 보게될 응답 뷰(화면) 지정
		if(loginUser == null) {	// 로그인 실패 => 에러페이지
			
			//System.out.println("로그인 실패");
			
			// 응답할 뷰에 필요한 데이터 request의 attribute에 담기
			
			request.setAttribute("errorMsg", "로그인에 실패했습니다.");
			
			
			
			//응답 페이지를 JSP에게 위임(제어권 넘김) : RequestDispatcher
			RequestDispatcher view = request.getRequestDispatcher("views/common/errorPage.jsp");
			
			view.forward(request, response);
			
			// forwarding방식 : 해당 선택된 뷰가 보여질 뿐 url에는 여전히 서블릿 매핑값 남아 있음
			
		}else { // 로그인 성공 => 다시 index페이지

			/*
			 * 
			 * 데이터를 담을 수 있는 영역(JSP 내장 객체 4종류)
			 * 
			 * 1) application : application에 담은 데이터는 해당 웹 애플리케이션 전역(jsp,servlet, java)에서 꺼내서 쓸 수 있음
			 * 					공유범위가 제일 큼
			 * 
			 * 2) session	  : session에 담은 데이터는 모든 jsp와 모든 servlet상에서 꺼내 쓸 수 있음
			 * 					공유범위 jsp/servlet
			 * 
			 * 3) request 	  : request에 담은 데이터는 해당 request객체가 전달된 응답jsp에서만 꺼내 쓸 수 있음
			 * 					공유범위가 제한적
			 * 
			 * 4) page 		  : page에 담은 데이터는 해당 그 jsp페이지에서만 꺼내 쓸 수 있음
			 * 					공유범위가 제일 작음 
			 * 
			 * 로그인한 회원정보(loginUser)를 session에 한번만 담아 놓으면
			 * 어느 페이지던 간에 session에 담겨 있는 회원 객체 뽑아서 사용할 수 있음!
			 * 
			 * 
			 * 4개의 객체에
			 * 데이터를 담고자 할 때 .setAttribute("키",밸류)
			 * 데이터를 뽑을 때 .getAttribute("키",밸류);
			 * 		   지울 떄 .removeAttribute("키",밸류);	
			 */
			
			
			
			// Servlet클래스에서 JSP내장객체인 session에 접근하고자 한다면 우선 세션객체를 얻어와야함
			HttpSession session = request.getSession();
			session.setAttribute("loginUser",loginUser);
			
			
			
			
			//System.out.println("로그인 성공");
			/*
			 * 1. forwarding 방식으로 응답뷰 출력
			 * index페이지가 잘 보여지지만 url에 여전히 login.me가 남아있음
			 * RequestDispatcher view = request.getRequestDispatcher("index.jsp");
			 * view.forward(request, response);
			 */
			
			// 2. redirect 방식(url을 재요청 방식)
			// request.getContextPath() == "/jsp"
			response.sendRedirect(request.getContextPath());
			
			
			
			
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
