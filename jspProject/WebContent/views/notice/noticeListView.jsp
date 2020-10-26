<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.util.ArrayList, com.kh.notice.model.vo.Notice" %>    
    
<%

	ArrayList<Notice> list = (ArrayList<Notice>)request.getAttribute("list");

	
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
            width: 800px;
            height: 500px;
            margin: auto;
            margin-top:50px;

        }
        .list-area {
            border: 1px solid white;
            text-align: center;
        }

        .list-area tbody>tr:hover {
            background: darkgray;
            cursor: pointer;
        }
    </style>


</head>


<body>
	<%@ include file="../common/menubar.jsp"  %>
	
	   <!-- 메뉴바 포함 -->


    <div class="outer">

        <br>
        <h2 align="center">공지사항</h2>
        <br>



        <!-- 현재 로그인한 회원이 admin일 경우에만 보여지는 div -->
        <!-- 현재 로그인한 회원 아이디가 admin과 일치 할 떄 -->
        <!-- 로그인 하지 않았을 때, nullPointException 에러 뜰 수 있음 -->
		<%if(loginUser != null && loginUser.getUserId().equals("admin")) { %>
		
        <div align="right" style="width: 700px;">
            <!--<button onclick="location.href='writeNotice.no';">글 작성</button>-->
             <a href="<%=contextPath %>/enrollForm.no" class="btn btn-secondary btn-sm">글작성</a> 
            <br><br>
        </div>
        
        <% } %>
        <!-- -------------------------------------------------- -->

        <table class="list-area" align="center">
        
            <thead>
            	<tr>
                <th>글번호</th>
                <th width=300px>제목</th>
                <th width=100px>작성자</th>
                <th>조회수</th>
                <th width=100px>작성일</th>
                </tr>
            </thead>

           <tbody>

                <!--1_1. 공지사항이 없는 경우 -->
                <%if(list.isEmpty()) { %>
                
                <tr>
                    <td colspan="5">존재하는 공지사항이 없습니다.</td>
                </tr>
                <%}else { %>

                <!--1_2. 공지사항이 있을 경우 -->
                <% for(Notice n : list)  { %> 
                <tr>
                    <td><%= n.getNoticeNO() %></td>
                    <td><%= n.getNoticeTitle() %></td>
                    <td><%= n.getNoticeWriter() %></td>
                    <td><%= n.getCount() %></td>
                    <td><%= n.getCreateDate() %></td>
                </tr>
                
				<% } %>
          	<% } %>

            </tbody>

        </table>
        
        <script>
        
        $(function(){
        	
        	$(".list-area>tbody>tr").click(function(){
        		
        		
        		// 클릭했을 때 행에 존재하는 글번호
        		// eq ==> 인덱스 활용
        		var nno = $(this).children().eq(0).text();
        		
        		//console.log(nno);
        		
        		// 쿼리스트링으로 만들어서 요청시 어떤 값을 전달 가능!! 
        		// ex) key = value 세트로 => ?(구분짓는 물음표)"nno="+nno
        				
        		location.href = "<%=contextPath%>/detail.no?nno=" + nno;
        		
        	});
        	
        });
        
        </script>
        

    </div>


	</body>


</html>