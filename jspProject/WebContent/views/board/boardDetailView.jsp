<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.kh.board.model.vo.*" %>    
    
<%
	Board b = (Board)request.getAttribute("b");
	Attachment at = (Attachment)request.getAttribute("at");

%>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

  <style>
    .outer {
        background: black;
        color : white;
        width: 1000px;
        height: 550px;
        margin: auto;
        margin-top: 50px;
       
    }
    
    #detail-area {border-color: white;}
    </style>

</head>
<body>

	<%@ include file="../common/menubar.jsp" %>


	   <div class="outer" >
        <br>
        <h2 align="center">일반게시글 상세보기</h2>
        <br>

        <table id="detail-area" align="center" border="1px" >
            <tr>
                <th width="70">분야</th>
                <td width="70"><%=b.getCategory() %></td>
                <th width="70">제목</th>
                <td width="350"><%=b.getBoardTitle() %></td>
            </tr>

            <tr>
                <th>작성자</th>
                <td><%=b.getBoardWriter() %></td>
                <th>작성일</th>
                <td><%=b.getCreateDate() %></td>
            </tr>

            <tr>
                <th>내용</th>
                <td colspan="3">

                    <p style="height: 200px; margin: 0; margin-top: 5px;" >
                       	<%=b.getBoardContent() %>
                    </p>

                </td>
            </tr>

            <tr>
                <th>첨부파일</th>
                <td colspan="3">
                    <%if(at == null) { %>
                  	첨부파일이 없습니다.
					<% }else %>
                    <% { %>
                    <a download="<%=at.getOriginName() %>" href="<%=contextPath%>/<%=at.getFilePath() + at.getChangeName()%>"><%=at.getOriginName()%></a>
                	<% } %>
                </td>
            </tr>


        </table>


        <br>

        <!-- 로그인한 사용자가 작성자와 일치할경우 -->
        <%if(loginUser != null && loginUser.getUserId().equals(b.getBoardWriter())) { %>
        <div align="center">
            <a href="<%=contextPath %>/updateForm.bo?bno=<%=b.getBoardNo() %>" class="btn btn-warning btn-sm">수정하기페이지</a>
            <a href="" class="btn btn-danger btn-sm">삭제하기</a>
        </div>
        <% } %>
        <!-- ---------------------------------- -->

    </div>

</body>
</html>