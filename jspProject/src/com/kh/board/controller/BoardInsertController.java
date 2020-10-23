package com.kh.board.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.kh.board.model.service.BoardService;
import com.kh.board.model.vo.Attachment;
import com.kh.board.model.vo.Board;
import com.kh.common.MyFileRenamePolicy;
import com.oreilly.servlet.MultipartRequest;

/**
 * Servlet implementation class BoardInsertController
 */
@WebServlet("/insert.bo")
public class BoardInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardInsertController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


			request.setCharacterEncoding("utf-8");
			
			// System.out.println(request.getParameter(category")); 	// null이 찍힘
		 
			// 폼 전송을 일반방식이 아닌 multipart/form-data 로 전송할 경우 request로 값을 뽑을 수 없음!!
			// HttpServletRequest => MultipartRequest 변환한 후 그 후에 뽑을 수 있음
			
			// 우선 enctype이 multipart/form-data로 잘 전송되었을 경우 전반적인 내용 수행되게끔
			if(ServletFileUpload.isMultipartContent(request)) {
				
				// 요청시 전달된 파일을 업로드(서버에 세팅해놓은 폴더에 저장) 처리
				// 1. 전달되는 파일을 업로드 처리할때 필요한 작업내용 (전달되는 파일의 용량제한, 전달되는 파일을 저장할 폴더 경로)
				// 1_1. 전송파일 용량 제한(int maxSize => byte단위) : 10Mbyte로 제한
				
				/*
				 *  byte => kbyte => mbyte => gbyte => tbtye ...
				 *  
				 *  1 kbyte == 1024byte
				 *  1 mbyte == 1024kbyte => 1024*1024byte
				 *  10 mbyte == 10*1024*1024 byte
				 *  
				 */
				
				int maxSize = 10 * 1024 * 1024;
				
				// 1_2. 전달되는 파일을 저장할 서버의 폴더 물리적 경로 알아내기 (String savePath)
				
				String savePath = request.getSession().getServletContext().getRealPath("/resources/board_upfiles/");
				
				
				// 2. 전달되는 파일명 수정작업 및 서버에 업로드 작업
				
				/*
				 * 	파일 업로드를 위한 외부 라이브러리 : cos.jar (com.oreilly.servlet의 약자)
				 * 	http://www.servlet.com
				 *  
				 *  > HttpServletRequest requet => MultipartRequest multiRequest 변환 (해당 객체 생성)
				 *  
				 *  
				 *  위의 구문만으로 넘어온 첨부파일은 내가 지정한 폴더에 업로드가 됨
				 *  => 즉, 문제가 있든 없든 간에 무조건 서버에 업로드 되버림...
				 *  => 즉, 혹시 DB에 INSERT할때 문제가 생기면 해당 업로드 된 파일 지우는게 좋음! => 메모리 관리!
				 *  
				 *   
				 *   첨부한 파일을 업로드 할 때 원본명 그대로 업로드 하지 않는 게 일반적임!
				 *   - 중복된 이름 파일이 있을 수 도 있고, 한글/특수문자/띄어쓰기가 포함된 파일일 수 있음!
				 *   
				 *   
				 *   => 기본적인 수정명 작업을 해주는 객체 => cos에서 제공하는 DefaultFileRenamePolicy객체
				 *   => 내부적으로 rename() 메소드가 실행되면서 파일명 수정진행됨!
				 *   => 기존에 동일한 파일명이 있을 경우 카운팅 된 숫자 붙여줌!
				 *   	ex) aaa.jpg, aaa1.jpg
				 *   
				 *  단, 내 입맛대로 수정명작업 가능!!
				 *    
				 *  
				 */
				
				//MultipartRequest multiRequest = new MultipartRequest(request, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
				
				
				MultipartRequest multiRequest = new MultipartRequest(request, savePath, maxSize, "UTF-8", new MyFileRenamePolicy());
				
				// 요청시 전달된 값들을 뽑아서 DB에 INSERT하는 서비스 요청
				// 1. Board 테이블에 Insert할 카테고리번호, 게시판제목, 내용, 회원번호
				
				
				String category = multiRequest.getParameter("category");
				String boardTitle = multiRequest.getParameter("title");
				String boardContent = multiRequest.getParameter("content");
				String boardWriter = multiRequest.getParameter("userNo");
				
				
				Board b = new Board();
				
				b.setCategory(category);
				b.setBoardTitle(boardTitle);
				b.setBoardContent(boardContent);
				b.setBoardWriter(boardWriter);
				
						
				// 2. Attachment 테이블에 Insert할 파일원본명, 파일수정명(업로드된 명),저장된 폴더경로 Attachment객체에 담기
				//		만일, 첨부파일이 없다면 Attachment 객체 null로 변환
				
				Attachment at = null;	// 처음엔  null로 초기화, 넘어온 첨부파일 그 때 생성
				
				
				if(multiRequest.getOriginalFileName("upfile") != null) {	// 넘어온 첨부파일 있을 경우
					
					at = new Attachment();
					
					at.setOriginName(multiRequest.getOriginalFileName("upfile"));	// 원본명
					at.setChangeName(multiRequest.getFilesystemName("upfile"));		// 실제서버에 업로드된 이름
					at.setFilePath("resources/board_upfiles/");
					
				}
				
				
				
				int result = new BoardService().insertBoard(b, at);
				// case1	at가 널이 아닌경우
				// case2	at가 널인 경우
				
				
				
				if(result>0) {
					

					
					HttpSession session = request.getSession();
					
					session.setAttribute("alertMsg", "게시글이 생성되었습니다!");
					
					response.sendRedirect(request.getContextPath()+"/list.bo?currentPage=1");
					
					
					
					
				}else {
					
					multiRequest.getFile("upfile").delete();
					
					request.setAttribute("errorPage", "게시글 생성에 실패하였습니다.");
					
					RequestDispatcher view = request.getRequestDispatcher("/views/common/errorPage.jsp");
					
					view.forward(request, response);
					
					
				}
				
				
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
