<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</head>
<body>
	
	<<h1>AJAX 개요</h1>
	<p>
		
		Asynchronous JavaScript and XML의 약자 <br />
		
		현재 페이지 그대로 유지한채로 서버로 요청후 그에 해당하는 응답 데이터를 가져와 <br />
		전체 페이지를 새로 고치지 않고 일부만 로드하는 기법 <br />
		
		우리가 기존에 href로 요청 및 form을 통해 요청했던 방식은 동기식 요청 <br />
		=> 응답 페이지가 돌아와야만 볼 수 있음(페이지 깜빡꺼림) <br />
		
		비동기식 요청을 보내기 위해서는 AJAX라는 기술이 필요함 <br /><br />
		
		* 동기식 / 비동기식 <br />
		- 동기식 : 요청처리후에 그에 해당하능 응답페이지가 돌아와야만 그다음 작업 가능함 <br />
				 만약 서버에서 호출된 결과까지의 시간이 딜레이되면 무한정 계속 기다려야만됨! (흰페이지 상태에서)
				 전체 페이지가 리로드됨 (즉, 페이지가 기본적으로 깜박거림) <br /><br />
		- 비동기식 : 현재 페이지를 유지하면서 중간중간마다 추가적인 필요 요청을 보낼 수 있음 <br />
		  		   요청한다고 해서 페이지 넘어가지 않음! (현재페이지 그대로!) <br /><br />
		  		  요청 보내놓고 그에 해당하는 응답이 올때까지 다른 작업 할 수 있음 (페이지 깜박거림 없음) <br />
		  		 ex) 실시간 검색어 로딩, 검색어 자동완성, 아이디 중복체크, 찜하기 /해제하기, 추천 <br /> 
		  		 
		  		 
		* 비동기식 단점 <br />
		- 현재 페이지에 지속적으로 리소스가 쌓임 => 페이지가 느려질 수 있음
		- dom요소들 새로이 만들어내는 구문을 잘 익여야함 <br />
		
		
		* AJAX 구현 방식 => JavaScript 방식 / jQuery 방식 (코드 간결및 사용 쉬움)
		
		  		 
	</p>
	
	<!-- 	
	<a href="test.do">동기식요청</a>
	
	<form action="test.do">
	
		<button type="submit">동기식요청</button>
	</form> -->
	
	<!-- 
		* jQuery 방식에서 AJAX 통신
		
		$.ajax({
			속성:속성값,
			속성:속성값,
			속성:속성값,
		});
	
	 -->
	 
	 <h1>jQuery 방식을 이용한  ajax 테스트</h1>
	 
	 
	 <h3>1. 버튼 클릭 GET방식으로 서버에  데이터 전송 및 응답</h3>
	 
	 입력 : <input type="text" id="input1"/>
	 <button id="btn1">전송</button>
	 
		<br />
		
	응답 : <label  id="output1">현재 응답없음</label>	
	 
	<script>
		$(function(){
			$("#btn1").click(function(){
				
				//location.href="test.do?input=" + $("#input1").val();
				
				
				$.ajax({
					url: "jqAjax1.do",	// url : 요청할 url (필수로 입력해야함!)
					data: {input:$("#input1").val()},	//data : 요청시 전달할 데이터(key:value형태의 객체)
					type: "get",	// type : 요청전송방식(get/post)
					success : function(result){	// success :  ajax 통신 성공시 실행할 함수 정의
						
						//result 매개변수 : 서버에서 응답이 돌아왔을 때 응답 결과를 담을 매개변수
						
						
						 //console.log(result);
					
						$("#output1").text(result);
					
					},
					error: function(){	// error : ajax 통신 실패시 실행할 함수 정의
						
						console.log("통신 실패");
						
					},
					
					complete : function(){	// complete : ajax 통신 성공여부 상관없이 무조건 실행 
						
						console.log("무조건 실행");
					}
						
				});
				
			});
		});
	
	</script>
	
	
	<h3>2. 버튼 클릭시 post방식으로 서버에 여러개 데이터 전송 및 응답</h3>
	
	이름 : <input type="text" id="input2_1" /> <br />
	나이 : <input type="text" id="input2_2" /> <br />
	<button id="btn2">전송</button> <br />
	
	응답 : <label id="output2"></label>
	
	<script>
		$(function(){
			$("#btn2").click(function(){
				
				$.ajax({
					
					url: "jqAjax2.do",
					data:{
						name:$("#input2_1").val(),
						age:$("#input2_2").val()
					},
					type:"post",
					success:function(result){
						
						$("#output2").text(result);
						
						console.log("ajax 통신 성공")
					},
					error:function(){
						console.log("ajax통신 실패");
					}
					
				
					
				});
			});
		});
		
	</script>
	
	
</body>
</html>