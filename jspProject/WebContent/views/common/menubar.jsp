<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.kh.member.model.vo.Member, java.util.Date" %>
    
<%

	Member loginUser = (Member)session.getAttribute("loginUser");
	// >> 로그인 요청전 : null
	// >> 로그인 성공후 : 로그인 성공한 회원정보가 담겨 있는 Member객체
	
	String alertMsg = (String)session.getAttribute("alertMsg");
	// >> 회원가입 서비스 요청전 : null
	// >> 회원가입 성공후 	  : alert로 띄워줄 메세지 담김 
	
	String contextPath = request.getContextPath(); // "/jsp"
	
	
	
	
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <style>
        #loginForm, #userInfo{float: right;}
        #userInfo a {
            color: black;
            text-decoration: none;
            font-size: 11px;

        }
        .navWrap {background: black;}
        .menu {
            display: table-cell;    /* 셀 모양 처럼 옆으로 배열  */
            height: 50px;
            width: 150px;
        }
        .menu a {
            color: white;
            text-decoration: none;
            font-weight: bold;
            /* border: 1px solid red; */
            display: block;
            font-size: 20px;
            width: 100%;
            height: 100%;
            line-height: 50px;
            
        }

        .menu a:hover {
            background: darkgray;
        }
    </style>

</head>
<body>
	
	<% if(alertMsg != null) { %>
	<script>
		
		alert("<%=alertMsg%>"); // alert("성공적으로 회원가입 되었습니다!"); // 따옴표 필수!
	
	</script>
		<!-- 알람창 띄워준 후 session 메시지 지워야함 그렇지 않으면, menubar.jsp가 포함된 페이지 열때마다 alert 실행 -->
		<% session.removeAttribute("alertMsg"); %>	
		<!-- session에 담긴 값 지워주기, 지워주지 않으면 계속 뜬다. -->
	
	<% } %>


	<%if(loginUser == null) { %>
			
			<h1 align="center">Welcome JSP World!</h1>
			
			<div class="loginArea">
		        <!-- 1. 로그인 전에 보여지는 로그인form -->
		        
		        <form id="loginForm" action="<%=contextPath %>/login.me" method="POST">
		        
		         <table >
		
		            <tr>
		                <th><label for="userId">아이디 </label></th>
		                <td><input type="text" id="userId" name="userId" required></td>
		            </tr>
		
		            <tr>
		                <th><label for="userPwd">비밀번호 </label></th>
		                <td><input type="password" id="userPwd" name="userPwd" required></td>
		            </tr>
		
		            <tr>
		                <th colspan="2">
		
		                    <button type="submit">로그인</button>
		                    <button type="button" onclick="enrollPage();">회원가입</button>
		
		                </th>
		
		            </tr>
		         </table>   
				<script>
					function enrollPage() {
						//location.href="/jsp/views/member/memberEnrollForm.jsp";
						//바로페이지 요청 => 웹 애플리케이션 디렉터리 구조가 url에 노출 => 보안상 좋지 않음
						
						//단순한 정적인 페이지 요청에 있어도 반드시 Servlet으로 요청한후 forwarding방식으로 응답할것!
						// => url에 서블릿 매핑값만 보일꺼임
						location.href = "<%=contextPath %>/enrollForm.me";
					}
				
				</script>
				
				
				
		        </form>
       <% }else { %>

        <!-- 로그인 성공 후 보여지는  div  -->
        
        <div id="userInfo">

            <b><%=loginUser.getUserName() %>님</b>의 방문을 환영합니다! <br><br>
            <div>
                <a href="<%=contextPath %>/myPage.me">마이페이지</a>
                <a href="<%=contextPath %>/logout.me">로그아웃</a>

            </div>

        </div> 
        
        <% } %>
        
    </div>

    <br clear="both">  <!--기존의 float을 해제 해주는 역할  -->
    <br>


    <div class="navWrap" align="center">
        <div class="menu"><a href="<%=contextPath %>">HOME</a></div>
        <div class="menu"><a href="<%=contextPath %>/list.no">공지사항</a></div>
        <div class="menu"><a href="<%=contextPath %>/list.bo?currentPage=1">일반게시판</a></div>
        <div class="menu"><a href="">사진게시판</a></div>
    </div>
</body>
</html>