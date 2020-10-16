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
    
        #myPageForm table {margin: auto;}
        #myPageForm input {margin: 5px;}
    </style>


</head>
<body>
	<!-- 이곳에 메뉴바 포함 할 것임  -->
   <%@ include file="../common/menubar.jsp" %>
	
	<%
	
		String userId  = loginUser.getUserId();
		String userName = loginUser.getUserName();
		String phone = (loginUser.getPhone() == null) ? " " : loginUser.getPhone();
		String email = (loginUser.getEmail() == null) ? " " : loginUser.getEmail();
		String address = (loginUser.getAddress() == null) ? " " : loginUser.getAddress();
		String interest = (loginUser.getInterest() == null) ? "" : loginUser.getInterest();
		
	%>
	
	
    <div class="outer">

        <br>

        <h2 align="center">마이페이지</h2>

        <form action="" method="POST" id="myPageForm">
            
            <table id="myPageForm">
                <tr>
                    <td>* 아이디</td>
                    <td><input type="text" name="userId" maxlength="12" required value=<%=userId %> readonly></td>
                    <td></td>
                </tr>
                <tr>
                    <td>* 이름</td>
                    <td><input type="text" name="userName" maxlength="5" required value=<%=userName %>></td>
                    <td></td>
                </tr>
                <tr>
                    <td>&nbsp;&nbsp;전화번호 </td>
                    <td><input type="text" name="phone" placeholder="(-포함)" value=<%=phone %>></td>
                    <td></td>
                </tr>
                <tr>
                    <td>&nbsp;&nbsp;이메일</td>
                    <td><input type="email" name="email" value=<%=email %>></td>
                    <td></td>
                </tr>
                <tr>
                    <td>&nbsp;&nbsp;주소</td>
                    <td><input type="text" name="address" value=<%=address %>></td>
                    <td></td>
                </tr>
                <tr>
                	<!-- interest= ""; / "운동,등산, 낚시" -->
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
            
            <script>
            $(function() {
            	var interest = "<%=interest%>";
            	
            	// 총 6개 체크박스 요소 선택
        		$("input[type=checkbox]").each(function(){
        			
        			// 순차적으로 접근한 요소의 value값이 interest라는 변수 값에 포함되어있을 경우
        			// 그때의 해당 input요소에 checked 속성 부여
        			
        			if(interest.search($(this).val()) != -1) {
        				$(this).attr("checked",true);
        			}
        			
        		});    	
        
            });
            
            </script>

            <br><br>

            <div align="center">
                <button type="submit" class="btn btn-primary btn-sm">정보변경</button>
                <button type="button" class="btn btn-secondary btn-sm" data-toggle="modal" data-target="#updatePwdForm">비밀번호변경</button>
                <button type="button" class="btn btn-danger btn-sm" data-toggle="modal" data-target="#deleteForm">회원탈퇴</button>
            </div>


        </form>

        <br><br>

    </div>

     <!-- The Modal -->
    <div class="modal" id="updatePwdForm">
    <div class="modal-dialog">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">비밀번호 변경</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <!-- data-dismiss 때문에 닫히는것! -->
        </div>
        
        <!-- Modal body -->
        <div class="modal-body" align="center">
         
            <form action="" method="POST">
            
            <table>
                <tr>
                    <th>현재 비밀번호</th>
                    <td><input type="password" name="userPwd" required></td>
                </tr>
                <tr>
                    <th>변경할 비밀번호</th>
                    <td><input type="password" name="updatePwd" required></td>
                </tr>
                <tr>

                    <th>변경할 비밀번호 재입력</th>
                    <td><input type="password" name="checkPwd" required> </td>

                </tr>
            </table>

            <br>

            <button type="submit" class="btn btn-secondary btn-sm" >변경</button>
            
            </form>

        </div>
        
      </div>
    </div>
  </div>
  
</div>

</div>

<!---------------------------------------------------- 회원 탈퇴 버튼 -------------------------------------->
<div class="modal" id="deleteForm">
<div class="modal-dialog">
 <div class="modal-content">
 
   <!-- Modal Header -->
   <div class="modal-header">
     <h4 class="modal-title">회원탈퇴</h4>
     <button type="button" class="close" data-dismiss="modal">&times;</button>
     <!-- data-dismiss 때문에 닫히는것! -->
   </div>
   
   <!-- Modal body -->
   <div class="modal-body" align="center">

        <b>
            탈퇴 후 복구가 불가능합니다 <br>
            정말로 탈퇴하시겠습니까?
        </b>

        <br><br>

       <form action="" method="POST">
       


                비밀번호 : <input type="password" name="userPwd" required>


  
        <br>
        <br>

       <button type="submit" class="btn btn-danger btn-sm" >탈퇴하기</button>
       
       </form>

   </div>
   


 </div>
</div>
</div>
<!---------------------------------------------------- 회원 탈퇴 버튼 -------------------------------------->

</div>
</body>
</html>