<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

    <Style>
        .outer {
            background: black;
            color: white;
            width: 800px;
            height: 500px;
            margin: auto;
            margin-top: 50px;

        }

        #enrollForm table {
            border: 1px solid white;
        }

        #enrollForm input, #enrollForm textarea {
            width: 100%;
            box-sizing: border-box;
        }
    </Style>

</head>
<body>
	
	<%@ include file="../common/menubar.jsp" %>
	
	
	 <div class="outer">
        <br>
        <h2 align="center">공지사항 작성하기</h2>
        <br>

        <form action="<%= contextPath %>/insert.no" id="enrollForm"  method="POST">
			<input type="hidden" name="userNo" value="<%=loginUser.getUserNo()%>" />
            <table align="center">
                <tr>
                    <th width="50px">제목</th>
                    <td width="300px"><input type="text" name="title" required></td>

                </tr>

                <tr>
                    <th width="50px">내용</th>
                    <td><textarea name="content"  rows="10" style="resize: none;" required></textarea></td>
                </tr>
            </table>

            <br><br>

            <div align="center">
            <button type="submit" class="btn btn-primary btn-sm" >등록하기</button>
            <!--<button type="button" class="btn btn-secondary btn-sm" onclick="history.back();">뒤로가기</button>  -->
            <a href="<%=contextPath %>/list.no" class="btn btn-secondary btn-sm">뒤로가기</a>
            </div>    

        </form>


    </div>
	
</body>
</html>