<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <style>
        .outer {
            background: black;
            color: white;
            width: 600px;
            
            margin: auto;

            margin-top: 50px;
        }

        #enrollForm table {
            margin: auto;
            
        }
        #enrollForm input {
            margin: 5px;
        }
    </style>
</head>
<body>
   <!-- 메뉴바 포함시킬꺼임 -->
   <%@include file="../common/menubar.jsp" %>
   
   
    <div class="outer">

        <br>

        <h2 align="center">회원가입 페이지</h2>
		<!-- menubar 정의해놨기 때문에 여기서도 contextPath변수 사용가능! -->
        <form action="<%=contextPath %>/insert.me" method="POST" id="enrollForm">
            
            <table id="enrollForm">
                <tr>
                    <td>* 아이디</td>
                    <td><input type="text" name="userId" maxlength="12" required></td>
                    <td><button type="button" onclick="idCheck();">중복확인</button></td>
                </tr>
                <tr>
                    <td>* 비밀번호</td>
                    <td><input type="password" name="userPwd" maxlength="15" required></td>
                    <td></td>
                </tr>
                <tr>
                    <td>* 비밀번호확인</td>
                    <td><input type="password" maxlength="15" required></td>
                    <td></td>
                </tr>
                <tr>
                    <td>* 이름</td>
                    <td><input type="text" name="userName" maxlength="5" required></td>
                    <td></td>
                </tr>
                <tr>
                    <td>&nbsp;&nbsp;전화번호 </td>
                    <td><input type="text" name="phone" placeholder="(-포함)"></td>
                    <td></td>
                </tr>
                <tr>
                    <td>&nbsp;&nbsp;이메일</td>
                    <td><input type="email" name="email"></td>
                    <td></td>
                </tr>
                <tr>
                    <td>&nbsp;&nbsp;주소</td>
                    <td><input type="text" name="address"></td>
                    <td></td>
                </tr>
                <tr>
                    <td>&nbsp;&nbsp;관심분야</td>
                    <td colspan="2">
                        <input type="checkbox" id="sports" name="interest" value="운동">
                        <label for="sports">운동</label>
                        <input type="checkbox" id="climbing" name="interest" value="등산">
                        <label for="climbing">등산</label>
                        <input type="checkbox" id="fishing" name="interest" value="낚시">
                        <label for="fishing">낚시</label>

                        <br>

                        <input type="checkbox" id="cooking" name="interest" value="요리">
                        <label for="cooking">요리</label>
                        <input type="checkbox" id="game" name="interest" value="게임">
                        <label for="game">게임</label>
                        <input type="checkbox" id="etc" name="interest" value="기타">
                        <label for="etc">기타</label>
    


                    </td>
                    
                </tr>
            </table>

            <br><br>

            <div align="center">
                <button type="submit" disabled>회원가입</button>
                <button type="reset">초기화</button>
            </div>


        </form>

        <br><br>


    </div>
    
    <script>
    	function idCheck(){
    		//아이디를 입력하는 input요소 객체
    		
    		var $userId = $("#enrollForm input[name=userId]");
    		var $submit = $("#enrollForm button[type=submit]");
    		
    		$.ajax({
    			
    			url:"idCheck.me",
    			type:"get",
    			data:{checkId:$userId.val()},
    			success:function(result){
    				
    				if(result == "fail"){// 중복있음 => 사용불가
    					
    					
    					// 이미 존재하거나 탈퇴한 회원의 아이디 입니다. 알람창 출력
    					alert("이미 존재하거나 탈퇴한 회원 아이디 입니다.");
    					// 해당 input요소에 포커스 맞추기
    					$userId.focus();
    					
    				}else {// 중복 없음 => 사용가능
    					
    					// 사용가능한 아이디 입니까? 사용하시겠습니까? confirm 창출력
    				
    					if(confirm("사용가능한 아이디 입니까? 사용하시겠습니까?")) {
 							// true일 경우
							//	아이디 입력 수정불가하게 readonly 속성추가
							//  회원가입 버튼 disabled 속성 없애기
    						$userId.attr("readonly", true);
    						$submit.removeAttr("disabled");
    					}else{
							// false일 경우
							//  해당 input 요소에 포커스 맞추기
    						$userId.focus();
    					}
   

    				}
    				
    			},error:function(){
    				console.log("아이디 중복체크 ajax 통신 실패");
    			}
    			
    		});
    	}
    
    
    </script>
    


</body>
</html>