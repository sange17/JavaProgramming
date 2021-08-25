<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<body>
	<%
		int id;
		String name="", e_mail="", title="", content="", passwd="";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		id = Integer.parseInt(request.getParameter("id"));
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:4001/board_db";
			String user = "root";
			String password = "rnjsxortkd175*";
			conn = DriverManager.getConnection(url, user, password);
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			String sql = "select * from board_tbl where id = " + id;
			rs = stmt.executeQuery(sql);
		}
		catch(Exception e){
			System.out.println("DB 연동 오류입니다. : " + e.getMessage());
		}
		
		passwd = request.getParameter("passwd");
		
		while(rs.next()){
			if(!passwd.equals(rs.getString("passwd"))){
		%>
		<center>
			<h2>잘못 입력된 패스워드입니다.</h2>
			<a href="board-read.jsp?id=<%=request.getParameter("id")%>">뒤로</a>
		</center>
		<%
			}
			else{
		%>
		<center>
			<h2>게시글 수정</h2><br><br>
			<form action="board-modify-db.jsp" method="POST">
				<table border="0">
					<tr>
		                <td>글쓴이:</td>
		                <td><input type="text" name="name" size="15" value="<%=rs.getString("name")%>"></td>
		            </tr>
		            <tr>
		                <td>메일주소:</td>
		                <td><input type="text" name="e_mail" size="30" value="<%=rs.getString("e_mail")%>"></td>
		            </tr>
		            <tr>
		                <td>글제목:</td>
		                <td><input type="text" name="title" size="15" value="<%=rs.getString("title")%>"></td>
		            </tr>
		            <tr>
		                <td valign="top">글내용:</td>
		                <td><textarea name="content" cols="65" rows="4"><%=rs.getString("content") %></textarea></td>
		            </tr>
				</table><br><br>
				
				<input type="hidden" name="id" value="<%=request.getParameter("id") %>">
				<input type="submit" value="등록하기">
				<input type="reset" value="다시쓰기">
			</form><br><br>
			<a href="board-read.jsp?id=<%= request.getParameter("id") %>">취소</a>
		</center>
		<%
			}
		}
		
		%>
</body>
</html>