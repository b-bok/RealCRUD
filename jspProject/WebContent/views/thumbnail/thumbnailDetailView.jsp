<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="com.kh.board.model.vo.*, java.util.*" %>

<%
	Board b = (Board)request.getAttribute("b");
	ArrayList<Attachment> list = (ArrayList<Attachment>)request.getAttribute("list");
	
	Attachment titleImg = list.get(0);		//대표이미지에 대한 이미지 뽑아놓기
	
	

%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


    <style>
        .outer {
            background: black;
            color: white;
            width: 900px;
            height: 800px;
            margin: auto;
            margin-top: 50px;
        }

        .detailArea td{border: 1px solid white;}
        .detailArea td {text-align: center;}

    </style>

</head>
<body>

	<%@ include file = "../common/menubar.jsp" %>
	
	   <div class="outer">
        <br>
        <h2 align="center">사진게시판 상세보기</h2>
        <br>

        <table class="detailArea" align="center">

            <tr>
                <td width="70">제목</td>
                <td colspan="3" width="600"><%=b.getBoardTitle() %></td>
            </tr>
            <tr>
                <td>작성자</td>
                <td><%=b.getBoardWriter() %></td>
                <td>작성일</td>
                <td><%=b.getCreateDate() %></td>
            </tr>
            <tr>
                <td>내용</td>
                <td colspan="3">
                    <p style="height: 50px;"><%=b.getBoardContent() %></p>
                </td>
            </tr>
            <tr>
                <td>대표 사진</td>
                <td colspan="3" align="center">
                       <img src="<%=contextPath %>/<%=titleImg.getFilePath()+titleImg.getChangeName() %>" width="500" height="300">
                </td>
            </tr>
            <tr>
                <td>상세사진</td>
                <td colspan="3" align="center">
                	<%for(int i = 1; i<list.size(); i++) { %>
                    <img src="<%=contextPath %>/<%=list.get(i).getFilePath() + list.get(i).getChangeName() %>" width="200" height="150">
               		<% } %>
                </td>
            </tr>

        </table>


    </div>

</body>
</html>