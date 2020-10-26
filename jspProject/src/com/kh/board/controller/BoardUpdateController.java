package com.kh.board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.kh.common.MyFileRenamePolicy;
import com.oreilly.servlet.MultipartRequest;

/**
 * Servlet implementation class BoardUpdateController
 */
@WebServlet("/update.bo")
public class BoardUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardUpdateController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		
		 // enctype multipart/form-data로 잘 전송되었을 때만 수행되게끔
		if(ServletFileUpload.isMultipartContent(request)) {
			
			//System.out.println("잘 실행되남?");
			
			
			// 1_1. 전송되는 파일 용량제한 (int maxSize) : 10mbyte;
			
			int maxSize = 10*1024*1024;
			
			// 1_2. 전달되는 파일 저장시킬 서버의 폴더 물리적인 경로(String savePath)
			
			String savePath = request.getSession().getServletContext().getRealPath("/resources/board_upfiles/");
			
			
			// 2. 전달되는 파일 수정명 작업 및 업로드 처리
			// HttpServletRequest => MultipartRequest
			MultipartRequest multipart = new MultipartRequest(request,savePath, maxSize, "UTF-8", new MyFileRenamePolicy());
			
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
