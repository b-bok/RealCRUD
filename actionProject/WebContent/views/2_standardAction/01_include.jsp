<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h3>Include</h3>
	<p>다른 페이지를 포함하고자 할 때쓰이는 방식</p>
	
	<h4>1. 기존의 include 지시어를 이용한 방식  (정적 include 방식 == compile 방식)</h4>
	<%-- 	<%@ include file="footer.jsp" %> <br /><br />
	
	특징 : include한 페이지에서 scriptlet으로 선언된 변수를 여기서도 사용가능 <br />
	
	include한 페이지의 year변수값 : <%= year %> <br /><br />
	
	단, 문제점 : 현재 이페이지에서 동일한 이름의 변수명으로 선언 불가 --%>
	
	<h4>2. JSP 표준액션태그를 이용한 방식 (동적 include 방식 == 런타임시 포함되는 형태)</h4>
	
	<jsp:include page="footer.jsp"/>	<br /><br />
	
	특징 1 : include한 페이지에 선언된 변수를 공유하지 않음! (동일한 이름의 변수로 재 선언 가능) <br />
	<%-- include한 페이지의 year변수 값 : <%=year %> --%>
	<% int year = 1900; %>
	
	특징 2 : include할 때 포함시킬 페이지로 값 전달할 수 있음!! <br /><br />
	<jsp:include page="footer.jsp">
		<jsp:param value="Hello World" name="test"/>
	</jsp:include>
	
	<br /><br />
	
	<jsp:include page="footer.jsp">
	
		<jsp:param name="test" value="Bye World"></jsp:param>
	</jsp:include>
	
	<!-- 내가 포함시키려는 페이지를 매번 동적으로 구성 가능 -->
	
	
</body>
</html>