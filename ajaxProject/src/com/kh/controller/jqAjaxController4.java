package com.kh.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.kh.model.vo.User;

/**
 * Servlet implementation class jqAjaxController4
 */
@WebServlet("/jqAjax4.do")
public class jqAjaxController4 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public jqAjaxController4() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		int num = Integer.parseInt(request.getParameter("num"));
		
		
		User u = new User (1,"박철수",30, '남');
		
		// GSON : Google JSON을 뜻함
		// 내가 응답할 데이터를 알아서 JSON객체로 변환해서 응답해주는 객체
		
		response.setContentType("application/json; charset=utf-8");
		
		Gson gson = new Gson();
					// 객체, 통로 반드시
		gson.toJson(u, response.getWriter());
		// 내부적으로 JSON객체로 변환후 응답
		// 객체에 key값은 해당 vo객체의 필드명
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
