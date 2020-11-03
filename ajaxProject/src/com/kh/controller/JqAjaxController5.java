package com.kh.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.kh.model.vo.User;

/**
 * Servlet implementation class JqAjaxController5
 */
@WebServlet("/jqAjax5.do")
public class JqAjaxController5 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public JqAjaxController5() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		ArrayList<User> list = new ArrayList<>();
		
		list.add(new User(1, "박철수",30,'남'));	// JSONObject
		list.add(new User(2, "오영심",27,'여'));  // JSONObject
		list.add(new User(3, "김영희",26,'여'));  // JSONObject
		// [{},{},{}]	=> JSONArray
		
		response.setContentType("application/json; charset=utf-8"); 
		
		Gson gson = new Gson();
		
		gson.toJson(list, response.getWriter());
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
