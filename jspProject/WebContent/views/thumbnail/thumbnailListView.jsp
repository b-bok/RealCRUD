<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.kh.board.model.vo.*, java.util.*" %>    


<%

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
            width: 900px;
            height: 800px;
            margin: auto;
            margin-top: 50px;

        }

        .list-area {
            width: 760px;
            margin: auto;
        }

        .thumbnail {
            border: 1px solid white;
            width: 220px;
            display:inline-block;
            margin: 14px;
        }

        .thumbnail:hover {
            cursor: pointer;
            opacity: 0.3;
        }


    </style>

</head>
<body>
	
	
	<%@ include file="../common/menubar.jsp" %>
	
  <div class="outer">
        <br>
        <h2 align="center">사진 게시판</h2>
        <br>
        
        <!-- 현재 로그인 되어있을 경우에만 -->
        <%if(loginUser != null) { %>
        <div align="right" style="width: 800px;">
            <a href="<%=contextPath %>/enrollForm.th" class="btn btn-secondary btn-sm">글작성</a>
            <br><br>
        </div>
		<% } %>
        <div class="list-area">
        
            <%for(Board b : list) { %>
            <div class="thumbnail" align="center">
            	<input type="hidden" name="bno" value="<%=b.getBoardNo() %>" />
                <img src="<%=contextPath %>/<%=b.getTitleImg() %>" width="200" height="200">
                <p>
                    No.<%=b.getBoardNo() %><br>
                       <%=b.getBoardTitle() %> <br>
                              조회수 : <%=b.getCount() %>
                </p>
            </div>
			<%} %>
        </div>

    </div>
	
	<script>
	
		$(function(){
			
			$(".thumbnail").click(function(){
				 location.href ="<%=contextPath%>/detail.th?bno=" + $(this).children().eq(0).val();

			});
			
		});	
	
	</script>


</body>
</html>