<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.kh.board.model.vo.*"%>
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
    .outer{
        background:black;
        color:white;
        width:1000px;
        /* height:800px; */
        margin:auto;
        margin-top:50px;
    }
    #detail-area{border-color:white;}
</style>
</head>
<body>
   
   <%@ include file="../common/menubar.jsp" %>
   
   <div class="outer">

        <br>
        <h2 align="center">일반게시판 상세보기</h2>
        <br>

        <table id="detail-area" align="center" border="1">
            <tr>
                <th width="70">분야</th>
                <td width="70"><%= b.getCategory() %></td>
                <th width="70">제목</th>
                <td width="350"><%= b.getBoardTitle() %></td>
            </tr>
            <tr>
                <th>작성자</th>
                <td><%= b.getBoardWriter() %></td>
                <th>작성일</th>
                <td><%= b.getCreateDate() %></td>
            </tr>
            <tr>
                <th>내용</th>
                <td colspan="3">
                    <p style="height:200px"><%= b.getBoardContent() %></p>
                </td>
            </tr>
            <tr>
                <th>첨부파일</th>
                <td colspan="3">
                   <% if(at == null) { %>
                       <!--첨부파일이 없을 경우-->
                       첨부파일이 없습니다.
               <% }else{ %>
                       <!--첨부파일이 있을 경우-->
                       <a download="<%= at.getOriginName() %>" href="<%= contextPath %>/<%= at.getFilePath() + at.getChangeName() %>"><%= at.getOriginName() %></a>
                   <% } %>
                </td>
            </tr>
        </table>

        <br>

        <!-- 로그인한 사용자가 해당 게시글을 작성한 본인일 경우 -->
        <% if(loginUser != null && loginUser.getUserId().equals(b.getBoardWriter())){ %>
           <div align="center">
               <a href="<%=contextPath %>/updateForm.bo?bno=<%= b.getBoardNo() %>" class="btn btn-warning btn-sm">수정하기페이지</a>
               <a href="" class="btn btn-danger btn-sm">삭제하기</a>
           </div>
        <% } %>
        
        
        <br />
        
        <div id="replyArea">
        	<table border="1" align="center">
        		<thead>
        			<tr>
        				<th>댓글작성</th>
        			 <%if(loginUser == null) {// 로그인 전  %>
        				<td>
        				<textarea cols="50" rows="2" style="resize:none" readonly>로그인 후 이용가능한 서비스입니다.</textarea>
        				</td>
        				<td><button disabled>댓글등록</button></td>
        			<%}else { // 로그인 후 %>
        				<td>
        				<input type="hidden" value="<%=loginUser.getUserNo() %>" id="userNo" />			
        				<textarea cols="50" rows="2" style="resize:none" id="replyContent"></textarea>
        				</td>
        				<td><button onclick="addReply();">댓글등록</button></td>
					<%} %>
        				
        			</tr>
        		</thead>
        		
        		<tbody>

        		</tbody>
        	</table>
        </div>
        <br /><br />

    </div>
   	
   		<script>
   			$(function(){
   				selectReplyList();
   				
   				setInterval(selectReplyList,1000);
   				
   			})
   			
   			function addReply(){	// 댓글 등록용 ajax
   				
   				$.ajax({
   					url:"rinsert.bo",
   					type: "post",
   					data:{
   						content : $("#replyContent").val(),
   						bno : <%=b.getBoardNo()%>,
   						userNo : $("#userNo").val()
   					},
   					success : function(result){
   						
   						if(result == "success") {
   							selectReplyList();
   							$("#replyContent").val("");
   							$("#replyContent").focus();
   						}
   						
   						
   					},
   					error : function(){
   						
   						console.log("댓글 작성용 ajax 통신 실패");
   						
   					}
   				})
   				
   			}
   		
   			function selectReplyList(){//해당 게시글 딸려있는 댓글 리스트 
   				$.ajax({
   					url:"rlist.bo",
   					data:{bno: <%=b.getBoardNo()%>},
   					success:function(list){
   						
   						console.log(list);
   						
   						var str = "";
   						
   						for(var i in list) {
   							
   							str +=   "<tr>" +
			   	        				"<td>" + list[i].replyWriter + "</td>" +
			   	        				"<td>" + list[i].replyContent + "</td>" +
			   	        				"<td>" + list[i].createDate + "</td>" +
			   	    
   	        						 "</tr>";
   							
   						}
   						
   						$("#replyArea tbody").html(str);
   						
   					},
   					error: function(){
   						console.log("댓글 리스트 조회용 ajax 통신 실패");	
   					}
   				})

   			}
   		</script>
   

</body>
</html>