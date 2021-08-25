<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<body>
	<%
		int id;
		String name="", e_mail="", title="", content="";
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		id = Integer.parseInt(request.getParameter("id"));
		name = request.getParameter("name");
		e_mail = request.getParameter("e_mail");
		title = request.getParameter("title");
		content = request.getParameter("content");
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:4001/board_db";
			String user = "root";
			String password = "rnjsxortkd175*";
			conn = DriverManager.getConnection(url, user, password);
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			String sql_update = "update board_tbl set name= '" + name + "', e_mail = '" + e_mail + "', title = '" + title + "', content = '" + content + "' where id = " + id;
			
			stmt.executeUpdate(sql_update);
		}
		catch(Exception e){
			System.out.println("DB 연동 오류입니다. : " + e.getMessage());
		}
	%>
	<center>
		<h2>게시글이 수정되었습니다.</h2>
		<a href="board-read.jsp?id=<%=request.getParameter("id")%>">작성한 글 확인</a>
		<a href="board-list.jsp">게시글 목록 보기</a>
	</center>
</body>
</html>