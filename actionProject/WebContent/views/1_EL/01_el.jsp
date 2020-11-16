<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.kh.model.vo.Person"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h3>1. 기존에 하던 방식대로 스크립틀릿과 표현식을 이용해서 각 영역에 담겨있는 값 뽑아서 화면에 출력</h3>
	<!-- 
	<%
	
		String classRoom = (String)request.getAttribute("clasRoom");
		Person student = (Person)request.getAttribute("student");
		
		String academy = (String)session.getAttribute("academy");
		Person teacher = (Person)session.getAttribute("teacher");
		
		
	%>
	
	<p>
	
		학원명 : <%=academy %> <br />
		강의장 : <%=classRoom %> <br />
		강사 : <%= teacher.getName() %>, <%=teacher.getAge() %>,<%=teacher.getGender() %> <br />
		
		<br />
		
		수강생 정보
		<ul>
			<li>이름 : <%=student.getName() %></li>	
			<li>나이 : <%=student.getAge() %></li>
			<li>성별 : <%=student.getGender() %></li>
		</ul>
		
		
	
	</p>
	 -->
	 
	 <h3>2. EL을 이용해서 보다 쉽게 각 영역에 저장된 값들을 출력하기</h3>
	 <p>
	 
	 	EL은 getXXX을 통해 값을 빼올 필요 없이 단지 키값만 제시해서 바로 접근 가능 <br />
	 	내부적으로 해당 영역에 getXXX을 자동적으로 실행되면서 해당 키 밸류값을 읽읆 <br /><br />
	 	
	 	El은 request, session 등 JSP 내장객체를 구분하지 않아도 <br />
	 	알아서 해당 영역들에 해당 키값을 검색해서 존재하는 경우 해당 밸류값 가져옴
	 
	 </p>
	 
	  <p>
	  
	  	학원명 : ${ academy } <br />
	  	강의장 : ${classRoom} <br />
	  	강사 : ${ teacher.name }, ${ teacher.age }, ${teacher.gender } <br />
	  	<!-- teacher에 접근하면 밸류값은 Person객체임, 해당 Person객체에 필드에 담긴 값을 출력하고자 할 때
	  		 .필드명 하면됨 (내부적으로 해당 필드의 getter메소드 실행됨 == getter메소드 없으면 안됨!!)	
	  			 -->
	  	
	  	<br /> 
	  	수강생 정보
	  	<ul>
	  	<li>이름 : ${student.name }</li>
	  	<li>나이 : ${student.age }</li>
	  	<li>성별 : ${student.gender }</li>
	  	
	  	</ul>
	  	

	  </p>
	 
	 <h3>3. 단, JSP내장 객체들에 동일한 키값으로 저장된게 있을 경우</h3>
	 
	 
	 <p>
	 	scope값 : ${scope}  <br />
	 	
	 </p>
	 <!-- 
	 	별도의 영역제시 없이 단지 키값을 제시했을 때
	 	EL은 공유범위가 제일 작은 영역에서 부터 해당 키값을 찾음
	 	page=> request => session => application
	 	=> 만약 application까지 찾았을 때 없다? => 오류x, 아무것도 출력 되지 않음
	  -->
	 
	 
	<h3>4. 특정 영역을 제시해서 저장된 값 출력하기</h3>
	
	<%
		// pageScope에 담기
		pageContext.setAttribute("scope","page");
		
	%>
	
	
	
		pageScope에값 : ${scope} 또는 ${ pageScope.scope } <br />
		requestScope에 담긴 값 : ${ requestScope.scope } <br />
		sessionScope에 담긴 값 : ${ sessionScope.scope } <br />
		applicationScope   : ${ applicationScope.scope } <br />
		
		해당 영역에 없는 키값 : ${ abc } 또는 ${ requestScope.abc }
		<!-- 오류 x 아무것도 출력 안됨  -->
		
		
		<!-- 
			EL을 통해서 키값 제시만으로 접근하는 영역
			JSP 내장객체들의 attribute영역에 접근하는 거임!!
		
		 -->
	
	
</body>
</html>