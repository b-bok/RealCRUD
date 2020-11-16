package com.kh.controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.model.vo.Person;

/**
 * Servlet implementation class ElServlet
 */
@WebServlet("/el.do")
public class ElServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ElServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		
		/*
		 *  데이터들을 담을 수 있는 JSP 내장 객체 종류
		 *  
		 *  1. application(ServletContext)
		 *     한 애플리케이션당 단 1개 존재
		 *     여기에 담긴 데이터는 애플리케이션 전역에서 사용 가능
		 *     공유범위가 가장 크다.(java/jsp/servlet)
		 *     
		 *  2. session (HttpSession)
		 *     한 브라우저당 1개 존재하는 객체
		 *     여기에 담긴 데이터는 어떤 jsp/servlet 사용 가능
		 *     공유범위가 jsp/servlet
		 *  
		 *  3. request(HttpServletRequest)
		 *     사용자가 요청할 때 만들어지는 객체
		 *     여기에 담긴 데이터는 해당 request객체를 포워딩 받는 응답페이지에서만 사용 가능
		 *     공유범위가 다소 제한적임 (응답 페이지에서만 꺼낼 수 있음)
		 *  
		 *  4. page
		 *     여기에 담긴 데이터는 해당 페이지에서만 사용가능
		 *     
		 * 위의 4개의 객체들에
		 * 데이터를 담고자할때는 .setAttribute("키", 담을 value값);    
		 * 데이터를 꺼낼 때는     .getAttribute("키");
		 * 데이터를 지울 때는     .removeAttribute("키");
		 *     
		 *  
		 * 영역 == scope 
		 *  
		 *  
		 */
		
		// requestScope에 담음
		request.setAttribute("classRoom", "I강의장");
		request.setAttribute("student", new Person("홍길동",23,'남'));
		
		
		// sessionScope에 담음
		HttpSession session = request.getSession();
		
		session.setAttribute("academy", "KH정보교육원");
		session.setAttribute("teacher", new Person("강보람",20,'여') );
		
		// requestScope, sessionScope  동일한 키값으로 담아보기
		request.setAttribute("scope", "request");
		session.setAttribute("scope", "session");
		
		
		// applicationScope에 담기
		
		ServletContext application = request.getServletContext();
		application.setAttribute("scope", "application");
		
		
		request.getRequestDispatcher("views/1_EL/01_el.jsp").forward(request, response);
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
