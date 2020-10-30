package com.kh.board.controller;

import java.io.File;
import java.io.IOException;

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
			MultipartRequest multiRequest = new MultipartRequest(request,savePath, maxSize, "UTF-8", new MyFileRenamePolicy());
			
			
			// 본격적으로 sql문 실행하기 위한 값 뽑아서 객체에 담기
			// 무조건 실행하는 sql문 => Board테이블 Update
			int bno = Integer.parseInt(multiRequest.getParameter("bno"));
			String category = multiRequest.getParameter("category");
			String boardTitle = multiRequest.getParameter("title");
			String boardContent = multiRequest.getParameter("content");
			
			Board b = new Board();
			
			b.setBoardNo(bno);
			b.setCategory(category);
			b.setBoardTitle(boardTitle);
			b.setBoardContent(boardContent);
			
			
			// 새로이 전달된 첨부파일 관련된 값 뽑기
			
			Attachment at = null;
			// 새로 전달되는 파일이 있을 경우
			if(multiRequest.getOriginalFileName("reUpfile") != null) {
				
				at = new Attachment();
				
				at.setOriginName(multiRequest.getOriginalFileName("reUpfile"));
				at.setChangeName(multiRequest.getFilesystemName("reUpfile"));
				at.setFilePath("resources/board_upfiles/");
				// 위의 3개의 데이터는 기존의 첨부파일이 있든 없든 간에
				// 새로 전달되는 파일이 있기 때문에 무조건 DB에 기록할 값
				
				if(multiRequest.getParameter("originFileNo") !=null) {
					// 새로운 첨부파일 있고, 기존의 파일 역시 있을 경우
					// Attachment  테이블에 Update
					// + 기존의 첨부파일 번호
					
					at.setFileNo(Integer.parseInt(multiRequest.getParameter("originFileNo")));
					
					
					
				}else {
					// 새로운 첨부파일 있고, 기존의 파일이 없을 경우
					// Attachment 테이블에 INSERT
					// 현재 게시글 번호

					at.setRefBoardNo(bno);
					
				}
				
				
			}
			
			
			int result = new BoardService().updateBoard(b, at);
			// case1 : 새로운 첨부파일 이없을 경우					=> updateBoard(b, null);
			// Board Update

			// case2 : 새로운 첨부파일 있고, 기존의 첨부파일도 있을 때 	=> updateBoard(b, fileNo가 담긴 at);
			// Board Update, Attachment update
			
			// case3 : 새로운 첨부파일 있고, 기존의 첨부파일이 없을 때 	=> updateBoard(b, refBoardNo가 담긴 at);
			// Board UPdate, Attachment insert
			
			if(result >0) {
				// 성공
				
				// 만약, 새로 업로드된 파일 있고, 기존 첨부파일 있으면!
				// 기존의 첨부파일 찾아 삭제!
				if(at != null && multiRequest.getParameter("originFileName") != null ) {
					// 기존 파일 경로를 찾아 삭제 할 것임
					File deleteFile = new File(savePath + multiRequest.getParameter("originFileName"));
					deleteFile.delete();
				}
				
				
				// 상세조회 페이지 요청
				HttpSession session = request.getSession();
				
				session.setAttribute("alertMsg", "게시글 수정 완료");
				
				response.sendRedirect(request.getContextPath()+"/detail.bo?bno=" + bno);
				
				
				
			}else {
				// 실패 => 에러메세지
				request.setAttribute("errorMsg", "게시글 수정 실패!");
				request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
				
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
