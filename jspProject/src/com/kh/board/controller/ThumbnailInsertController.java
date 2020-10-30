package com.kh.board.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

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
 * Servlet implementation class ThumbnailInsertController
 */
@WebServlet("/insert.th")
public class ThumbnailInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ThumbnailInsertController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		
		
		if(ServletFileUpload.isMultipartContent(request)) {
			
			//1_1. 용량 제한 (int maxSize)
			
			int maxSize = 10*1024*1024;
			
			//1_2. 저장할 폴더의 물리적 경로(String savePath)
			// 마지막 반드시 / 찍어야 폴더 안에 저장하는 것이 된다.
			String savePath = request.getSession().getServletContext().getRealPath("/resources/thumbnail_upfiles/");
			
			
			// 2. 전달된 파일들 수정명 작업 및 업로드
			MultipartRequest multiRequest = new MultipartRequest(request,savePath, maxSize, "utf-8", new MyFileRenamePolicy() );
			
			// 3. DB에 기록할 값들을 뽑기 (요청시 전달되는 값들)
			String boardWriter = multiRequest.getParameter("userNo");
			String boardTitle = multiRequest.getParameter("title");
			String boardContent = multiRequest.getParameter("content");
			
			
			// 3_1. Board
			Board b = new Board();
			
			b.setBoardWriter(boardWriter);
			b.setBoardTitle(boardTitle);
			b.setBoardContent(boardContent);
			

			// 3_2. Attachment
			
			ArrayList<Attachment> list = new ArrayList<>();
			
			for(int i = 1; i<=4; i++) {
				
				String key = "file" + i;
				// 원본명을 뽑았을 때 널이 아닐경우 == 첨부파일이 있음!
				if(multiRequest.getOriginalFileName(key) != null) {
					
					// Attachment 객체 생성 <= 원본명, 수정명,폴더경로,파일레벨(1,2)
					// list 추가
					
					
					Attachment at = new Attachment();
					
					at.setOriginName(multiRequest.getOriginalFileName(key));
					at.setChangeName(multiRequest.getFilesystemName(key));
					at.setFilePath("resources/thumbnail_upfiles/");
					
					if(i == 1) {
						
						at.setFileLevel(1);
						
					}else {
						
						at.setFileLevel(2);
					}

					list.add(at);
						
				}
				
			}
			
			
			int result = new BoardService().insertThumbnailBoard(b, list);
			
			
			if(result >0) { // 성공 리스트 페이지요청
				
				HttpSession session = request.getSession();
				
				session.setAttribute("alertMsg", "게시글 등록 성공!");
				
				response.sendRedirect(request.getContextPath()+"/list.th");
				
			}else {
				
				for(Attachment at : list) {
					// 실패했을 때 파일 찾아서 지워주기 
					new File(savePath + at.getChangeName()).delete();
				}
				
				request.setAttribute("errorMsg", "게시글 등록에 실패했어요!");
				
				request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
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
