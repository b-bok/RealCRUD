package com.kh.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.kh.model.vo.User;

/**
 * Servlet implementation class jqAjaxController3
 */
@WebServlet("/jqAjax3.do")
public class jqAjaxController3 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public jqAjaxController3() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		// 조회하려는 회원번호
		int num = Integer.parseInt(request.getParameter("num"));
		
		User u = new User (1, "박철수",30, '남');
		
		
		//out.print(u);	// u.toString() => 자바에서 객체를 바로 응답하면  해당객체.toString()이 응답됨
		
		
		/*
		 * 	* JSON(JavaScript Object Notaion : 자바스크립트 객체 표기법)
		 * 	- ajax 통신시 데이터 전송에 사용되는 포맷형식 중 하나
		 *  - {key:value,key:value,key:value,...}
		 * 	- key : 문자열, value: 기본자료형값, 문자열, 배열,..., (char값 담으면 안됨! => 통신에러)
		 * 
		 * => JSON관련한 클래스 쓰고자 한다면 라이브러리 필요!
		 */
		// u => 자바스크립트 객체 형태 {}
		
		JSONObject jObj = new JSONObject();	//{}
		
		jObj.put("no",u.getNo());			//{no:1}
		jObj.put("name",u.getName());		//{no:1, name:"박철수"}
		jObj.put("age",u.getAge());			//{no:1, name:"박철수", age:30}
		jObj.put("gender",u.getGender()+" ");	//{no:1, name:"박철수", age:30, gender:"남"}
		
		
		// 내가 응답할 데이터는 json객체이고, 문자셋은 utf-8이야! 선언
		
		response.setContentType("applicaton/json; charset=utf-8");
		
		PrintWriter out = response.getWriter();
		
		out.print(jObj);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
