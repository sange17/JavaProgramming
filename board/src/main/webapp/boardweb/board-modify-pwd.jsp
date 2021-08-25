<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
<title>게시글 수정</title>
</head>
<body>
	<center>
		<h2>패스워드를 입력하세요</h2>
		<form action="board-modify.jsp" method="POST">
			<table border="0">
				<tr>
					<td>패스워드:</td>
					<td><input type="password" name="passwd" size="30"></td>
					<td><input type="hidden" name="id" value="<%= request.getParameter("id")%>"></td>
				</tr>
			</table><br><br>
			
			<input type="submit" value="수정하기">
			<input type="reset" value="다시쓰기">
		</form><br><br>
		
		<a href="board-read.jsp?id=<%=request.getParameter("id") %>">수정 취소</a>
		
		<hr width="60%">
	</center>
</body>
</html>