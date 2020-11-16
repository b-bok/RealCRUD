<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	
	<h2>EL에서의 연산자</h2>
	
	<h3>1. 산술연산</h3>
	el : ${ big + small }	<!-- el은 숫자값 자동 형변환 -->
	
	<p>
		10 + 3 = ${ big + small } <br />
		10 - 3 = ${ big - small } <br />
		10 * 3 = ${ big * small } <br />
		10 / 3 = ${ big / small } 또는 ${ big div small } <br />
		10 % 3 = ${ big % small } 또는 ${ big mod small } <br />
	
	</p>
	
	
	<h3>2. 숫자간의 대소비교 연산</h3>
	<p>
		10 &gt; 3 = ${big > small } 또는 ${big gt small } <br /> <!-- greater than -->
		10 &lt; 3 = ${big < small } 또는 ${big lt small } <br /> <!-- less than -->
		10 &gt;= 3 = ${big >= small } 또는 ${big ge small } <br /> <!-- greater equal -->
		10 &lt;= 3 = ${big <= small } 또는 ${big le small } <br /> <!-- less equal -->
		
		
	</p>
	
	
	<h3>3. 객체간의 비교</h3>
	
	
	<p>							<!-- el에서는 ==는 equals()와 같은 동작 -->
		- sOne과 sTwo가 같습니까? : ${sOne == sTwo } 또는 ${sOne eq sTwo } <br />
		- sOne과 sTwo가 틀립니까? : ${sOne != sTwo } 또는 ${sOne ne sTwo } <br />
		- pOne과 pTwo가 같습니까? : ${pOne == pTwo } 또는 ${pOne eq pTwo } 
	
	</p>
	
	<h3>4. 객체가 null인지 또 비어있는지 비교(empty)</h3>
	
	
	<p>
		- p가 null입니까? : ${ empty p } <br />
		- p가 null이 아닙니까? : ${ !empty p } <br />
		
		
		- list가 비어있습니까? : ${empty list } <br />
		- list가 비어있지 않습니까? : ${!empty list } <br />
		
 	
	</p>
	
	
	<h3>5. 논리연산자</h3>
	${ true && true } 또는 ${true and true} <br />
	${ true || true } 또는 ${true or  true } <br />
	
	
	
	
</body>
</html>