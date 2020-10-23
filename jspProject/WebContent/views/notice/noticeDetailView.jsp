<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.kh.notice.model.vo.Notice"  %>    

<%
	Notice n = (Notice)request.getAttribute("n");	
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

    <style>
        .outer{
            background: black;
            color : white;
            width: 800px;
            height: 500px;

            margin: auto;
            margin-top: 50px;

        }

        #detail-area {border-color: white;}
    </style>


</head>
<body>

   <!-- 메뉴바 포함 할것 -->
   <%@ include file="../common/menubar.jsp" %>
   
   <%
   		
   		int noticeNo = n.getNoticeNO();
   	 	String noticeTitle = n.getNoticeTitle();
   	 	String noticeContent = n.getNoticeContent();
   	 	String noticeWriter = n.getNoticeWriter();
   		Date createDate = n.getCreateDate();

   %>
   
   
   
   
   

    <div class="outer" align="center">
        <br>
        <h2>공지사항</h2>
        <br>

        <table id="detail-area" align="center" border="1px">
            <tr>
                <th>제목</th>
                <td colspan="3" width="300"><%=noticeTitle %></td>
            </tr>
            <tr>
                <th>작성자</th>
                <td><%=noticeWriter %></td>
                <th>작성일</th>
                <td><%=createDate %></td>
            </tr>
            <tr>
                <th>내용</th>
                <td colspan="3">

                    <p style="height: 150px; margin: 0; margin-left: 10px;">
                        	<%=noticeContent %>
                    </p>

                </td>
            </tr>
            

        </table>

        <br><br>



        <div align="center">

            <a href="<%=contextPath%>/list.no" class="btn btn-secondary btn-sm">목록가기</a>

            <!-- 현재 로그인한 사용자가 해당 글 작성한 작성자일 경우 -->
            
            <%if(loginUser != null && loginUser.getUserId().equals(noticeWriter)) { %>
            
              <a href="<%=contextPath %>/updateForm.no?nno=<%=noticeNo %>"  class="btn btn-warning btn-sm">수정하기페이지</a>
            
            
            
            <!--  <a href="<%=contextPath %>/delete.no?nno=<%=noticeNo %>" class="btn btn-danger btn-sm">삭제하기</a>-->
            
            <button type="button" class="btn btn-danger btn-sm" data-toggle="modal" data-target="#myModal">
   			삭제하기
  			</button>
            
			  <!-- The Modal -->
			  <div class="modal" id="myModal">
			    <div class="modal-dialog">
			      <div class="modal-content">
			      
			 
			         
			        <!-- Modal body -->
			        <div class="modal-body">
			        	<h4 style="color: black;" >정말로 삭제하시겠습니까?</h4>
			        
			        	<hr />
			        	
			          <a href="<%=contextPath %>/delete.no?nno=<%=noticeNo %>" class="btn btn-danger btn-sm" >삭제하기</a>
			        </div>

			       
			      </div>
			    </div>
            
            
            
            
            <% } %>
            <!-- ------------------- -->
            
        </div>

    </div>

</body>
</html>