<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판</title>
</head>
<body>
	<center>
		<h2>게시글 내용</h2>
		<%
			int id, ref = 0;
			String name="", e_mail="", title="", content="";
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
			
			while(rs.next()){
				name = rs.getString("name");
				e_mail = rs.getString("e_mail");
				title = rs.getString("title");
				content = rs.getString("content");
				ref = Integer.parseInt(rs.getString("ref"));
			}
			
		%>
		<table border="0" width="500">
			<tr>
                <td width="100">글쓴이:</td>
                <td><%=name %></td>
            </tr>
            <tr>
                <td width="100">메일주소:</td>
                <td><%=e_mail %></td>
            </tr>
            <tr>
                <td width="100">글제목:</td>
                <td><%=title %></td>
            </tr>
            <tr>
                <td width="100">글내용:</td>
                <td><%=content %></td>
            </tr>
		</table><br><br>
		
		<a href="board-insert.jsp?ref=<%= ref %>&flag=r">답글 쓰기</a>
		<a href="board-modify-pwd.jsp?id=<%= id %>">게시글 수정</a>
		<a href="board-delete-pwd.jsp?id=<%= id %>">게시글 삭제</a>
		<a href="board-list.jsp">게시글 목록 보기</a>
	</center>
</body>
</html>