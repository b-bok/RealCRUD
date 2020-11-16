<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<h1>* EL(Expression Language) 표현 언어</h1>
	<p>
	
		기존에 사용했떤 표현식(출력식) &lt;%= name %&gt;와 같이 <br />
		JSP에 표현하고자 하는 코드를 \${ name }의 형식으로 표현하여 작성하는 것
		
	</p>
	
	<h3>1. EL 기본 구문에 대해서 먼저 배워보자!</h3>
	<a href="el.do">01_EL</a>
	
	
	<br />
	
	<h3>2. EL(Param)에 대해서 배워보자!!</h3>
	<p>
	
		JSP에 서블릿 요청을 통해 응답 JSP로 갔지만
		현재 JSP에서 또다른 JSP 바로 요청도 가능하긴함 (요청시 전달값도 전달가능) <br />
		권장 x (왜? 디렉토리 구조가 노출되기 때문)
	
	</p>
	<form action="views/1_EL/02_elParam.jsp">
		<fieldset>
			<input type="text" name="pname"  placeholder="제품명 입력"/> <br />
			<input type="number" name="pcount" placeholder="수량입력" /> <br />
			<input type="text" name="option" placeholder="옵션1입력"/> <br />
			<input type="text" name="option" placeholder="옵션2입력" /> <br />
			<input type="submit" value="02_EL(Param)" />
		
		</fieldset>
	
	</form>
	
	
	
	<h3>3. EL(연산자)에 대해서 배워보자 </h3>
	
	<a href="operation.do">03_EL(연산자)</a>
	
	
	<br />
	
	<hr />
	
	<!--
		* JSP를 이루는 구성인자
			1. 스크립팅 원소 : JSP페이지에서 자바 코드를 직접 기술할 수 있게 하는 기능
						   ex) 스크립틀릿, 표현식(출력식) 등
			
			2. 지시어 : JSP페이지 정보에 대한 내용을 기술하거나 다른 jsp를 포함하고자 할 때 사용
					  JSP의 기능을 확장시키는 라이브러리 등록할 때도 사용
					   ex) page지시어, include지시어, taglib지시어
					   			   
			3. JSP액션 태그(표준액션태그, 커스텀 액션태그)
			   XML기술을 이용하여 기존의 JSP문법을 확장하는 기술들을 제공하는 태그
			   
			   >> 표준액션태그 (Standard Action) : JSP페이지에서 바로 사용가능 (별로 연동 필요 없음)	
			   									모든 태그들  이름 앞에 jsp:라는 접두어 붙음
			   									
			   >> 커스텀 액션 태그(Custom Action) : JSP페이지에서 바로 사용불가능(사용하고자 하는 jsp페이지에 별도의 연동 필요)	
			   									모든 태그들의 이름 앞에 jsp: 외의 접두어들 붙음 (c:, fn:, fmt:, ...)								
	  -->
	
		
		<h1>JSP Action Tag</h1>
		<p>XML기술을 이용하여 기존의 JSP문법을 확장하는 기술을 제공하는 태그들</p>
	
	
		<h3>1. 표준 액션 태그 (Standard Action Tag)</h3>
		<p>
			JSP 페이지에서 별도의 라이브러리 연동 없이 바로 사용 가능하고 태그 앞에  jsp:접두어가 붙음
		</p>
		
		
		<a href="views/2_standardAction/01_include.jsp">include</a>
	
		<br />
		
		
		<a href="forward.do">forward</a>
		
		
		
	
	
</body>
</html>