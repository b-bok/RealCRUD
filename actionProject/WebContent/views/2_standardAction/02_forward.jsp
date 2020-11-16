<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<h2>여기는 forward.jsp 페이지입니다.</h2>
	<h3>${ status }</h3>
	
	<!-- 현재 jsp에서 또다른 jsp 포워딩 시킬 수 있는 태그 써보기  -->
	
	
	<% if(request.getAttribute("status").equals("success")) { %>
	
		<jsp:forward page="successPage.jsp">
			<jsp:param value="${status }" name="message"/>
		</jsp:forward>
	
	<% }else { %>
		<jsp:forward page="failPage.jsp">
			<jsp:param name="message" value="${ status }"/>
		</jsp:forward>
	
	<% } %>
	
	
	
</body>
</html>