<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 
	
		1. 회원 서비스
					  |  C(INSERT)	 |	R(SELECT)	|  U(UPDATE)	|	D(DELETE)
		======================================================================================
		로그인		  | 			 |		o		| 				|
		회원가입		  |		o		 |				|				|
		[아이디 중복체크] |				 |		o		| 				|
		마이페이지		  |				 |		o		|				|
		정보 수정		  |				 |				|   	o		|
		회원 탈퇴		  |				 |				|		o		| 		
			
				
		
		2. 공지사항 서비스
			공지사항 리스트 조회(R)/상세조회(R)/
			공지사항 작성하기(C)/ 공지사항수정하기(U)/ 공지사항삭제하기(U)


		3. 일반게시판 서비스
			게시판리스트조회(R) + 페이징 처리/상세조회(R) + 첨부파일다운로드
			게시판 작성하기(C) + 첨부파일업로드(1개) / 게시판수정하기(U)/ 게시판삭제하기(U)
			
			[댓글리스트조회(R)/댓글작성하기(C)]
			
		4. 사진게시판 서비스
			썸네일리스트조회(R)/상세조회(R)
			게시판작성하기(C)+ 첨부파일(다중)업로드

	 -->
	 
	 <%@ include file="views/common/menubar.jsp" %>
	 
</body>
</html>