<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import ="com.kh.board.model.vo.*, java.util.ArrayList" %>    
    
    
<%
	PageInfo pi = (PageInfo)request.getAttribute("pi");
	ArrayList<Board> list = (ArrayList<Board>)request.getAttribute("list");

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
            margin: auto;
            width: 1000px;
            height: 550px;
            margin-top: 50px;


        }

        .list-area {
            border : 1px solid white;
            text-align: center;
        }

        .list-area tbody tr:hover {
            background: darkgray;
            cursor: pointer;
        }

        .paging-area a{
            text-decoration: none;
            color: white;
            margin: 5px;
            
        }
        
        
    </style>

</head>
<body>


    <%@ include file="../common/menubar.jsp" %>


    <div class="outer">
        <br>
        <h2 align="center">일반게시판</h2>
        <br>
		
		
		<% if(loginUser != null) { %>
		<div align="right" style="width:850px">
		
			<a href="<%=contextPath %>/enrollForm.bo" class="btn btn-secondary btn-sm">글작성</a>
			<br /><br />
		</div>
		<% } %>
		
        <table align="center" class="list-area">

            <thead>

                <tr>
                    <th width="70px">글번호</th>
                    <th width="70px">카테고리</th>
                    <th width="300px">제목</th>
                    <th width="100px">작성자아이디</th>
                    <th width="50px">조회수</th>
                    <th width="100px">작성일</th>
                </tr>

            </thead>
			
			
			
            <tbody>
      
				<% if(list.isEmpty()) { %>
	
                <th colspan="6"> 조회된 게시글이 없습니다. </th>

            	<%}else { %>
            		<%for(Board b : list) { %>
            <tr>
                <td><%=b.getBoardNo() %></td>
                <td><%=b.getCategory() %></td>
                <td><%=b.getBoardTitle() %></td>
                <td><%=b.getBoardWriter() %></td>
                <td><%=b.getCount() %></td>
                <td><%=b.getCreateDate() %></td>
            </tr>
            		<%} %>
           
            </tbody>
            
            <% } %>    
        </table>

        <br><br>


        <div class="paging-area" align="center">
			
			
			<%if(pi.getCurrentPage() != 1) { %>
            <a href="<%=contextPath%>/list.bo?currentPage=<%=pi.getCurrentPage() - 1%>">&lt; 이전</a>
			<% } %>
			
			
			<%for(int p = pi.getStartPage(); p<pi.getEndPage(); p++) {%>
            <a href="<%=contextPath%>/list.bo?currentPage=<%=p %>"><%=p%></a>
			<% } %>
			
			<%if(pi.getCurrentPage() != pi.getMaxPage()) {%>
            <a href="<%=contextPath%>/list.bo?currentPage=<%=pi.getCurrentPage() + 1%>">다음 &gt;</a>
			<% } %>
        </div>


    </div>


</body>
</html>