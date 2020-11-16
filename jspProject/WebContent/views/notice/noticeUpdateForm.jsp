<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.kh.notice.model.vo.Notice"%>
    
<%-- <%
	Notice n = (Notice)request.getAttribute("n");
	
%>     --%>
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

        #updateForm table {
            border: 1px solid white;
        }

        #updateForm input, #updateForm textarea {
            width: 100%;
            box-sizing: border-box;
        }
    </Style>

</head>
<body>

	<!-- 메뉴바 -->
	<%-- <%@ include file = "../common/menubar.jsp" %> --%>
	<jsp:include page="../common/menubar.jsp"/>

    <div class="outer">
        <br>
        <h2 align="center">공지사항 수정하기</h2>
        <br>

        <form action="update.no" id="updateForm"  method="POST">
			<input type="hidden" name="nno" value="${n.noticeNO }" />
            <table align="center">
                <tr>
                    <th width="50px">제목</th>
                    <td width="300px"><input type="text" name="title" value="${n.noticeTitle }"></td>

                </tr>

                <tr>
                    <th width="50px">내용</th>
                    <td><textarea name="content"  rows="13" style="resize: none;">"${n.noticeContent }"</textarea></td>
                </tr>
            </table>

            <br><br>

            <div align="center">
            <button type="submit">변경하기</button>
            <button type="button" onclick="history.back();">뒤로가기</button>
            </div>    

        </form>


    </div>


</body>
</html>