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
        color : white;
        margin: auto;
        margin-top: 50px;
        width: 900px;
        height: 800px;

    }

    #enrollForm table {border: 1px solid white}
    #enrollForm input, #enrollForm textarea {
        width: 100%;
        box-sizing: border-box;
    }

    </style>


</head>
<body>


	<%@ include file ="../common/menubar.jsp" %>
	
	  
    <div class="outer">
        <br>
        <h2 align="center">사진게시판작성하기</h2>
        <br>

        <form id="enrollForm" action="<%=contextPath %>/insert.th" method="POST" enctype="multipart/form-data">
			<input type="hidden" name="userNo" value="<%=loginUser.getUserNo() %>" />
            <table align="center">
                <tr>
                    <th width="100">제목</th>
                    <td colspan="3"><input type="text" name="title" required></td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td colspan="3">
                        <textarea name="content" rows="10" style="resize: none;" required></textarea>
                    </td>
                </tr>
                <tr>
                    <th>대표이미지</th>
                    <td colspan="3" align="center">
                        <img  id="titleImg" width="250px" height="170px">
                    </td>
                </tr>
                <tr>
                    <th>상세이미지</th>
                    <td><img id="contentImg1" width="150px" height="120px"></td>
                    <td><img id="contentImg2" width="150px" height="120px"></td>
                    <td><img id="contentImg3" width="150px" height="120px"></td>
                </tr>
            </table>


            <div id="fileArea">
                <input type="file" name="file1" id="file1" onchange="loadImg(this,1);" required>
                <input type="file" name="file2" id="file2" onchange="loadImg(this,2);">
                <input type="file" name="file3" id="file3" onchange="loadImg(this,3);">
                <input type="file" name="file4" id="file4" onchange="loadImg(this,4);">
            </div>

            <br>

            <div align="center">
                <button type="submit">등록하기</button>
                <button type="reset">취소하기</button>
            </div>

        </form>
    </div>
    
    <script>

        $(function() {

            $("#fileArea").hide();

            $("#titleImg").click(function(){

                $("#file1").click();
            });
            $("#contentImg1").click(function(){

                $("#file2").click();
            })
            $("#contentImg2").click(function(){
                $("#file3").click();
            })
            $("#contentImg3").click(function(){
                $("#file4").click();
            })


        });





        function loadImg(inputFile, num){
            //inputFile : 현재 변화가 생긴 input type="file" 요소 객체
            // num      : 몇번째 input 요소인지 구분지어줄 숫자


            //onsole.log(num);
            //console.log(inputFile.files.length);

            
            if(inputFile.files.length == 1) {
                // 현재 선택된 file이 존재할 경우 => 읽어들여서 미리보기

                // 파일 읽어들일 FileReader 객체 생성
                var reader = new FileReader();

                // 파일을 읽어들일 메소드 호출
                // 해당 파일을 읽어들이는 순간 그 파일 고유한 url 부여됨
                reader.readAsDataURL(inputFile.files[0]);

                // 파일 읽어들이기가 다 완료됐을 때, 실행할 함수 정의 
                reader.onload = function(e){
                    // 각 영역에 맞춰서 이미지 미리보기
                    switch(num) {
                        case 1 : $("#titleImg").attr("src", e.target.result); break;
                        case 2 : $("#contentImg1").attr("src",e.target.result); break;
                        case 3 : $("#contentImg2").attr("src",e.target.result);  break;
                        case 4 : $("#contentImg3").attr("src", e.target.result); break;
                     }
                }

            }else {
                 // 현재 선택된 file이 사라졌을 경우 => 미리보기 해제
                
                switch(num) {
                    case 1 : $("#titleImg").attr("src", null); break;
                    case 2 : $("#contentImg1").attr("src",null); break;
                    case 3 : $("#contentImg2").attr("src",null);  break;
                    case 4 : $("#contentImg3").attr("src",null); break;
                }

            }

        }


    </script>
	

</body>
</html>