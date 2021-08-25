<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="java.sql.*" import="java.text.*"%>
<% request.setCharacterEncoding("UTF-8"); %>
    
<!DOCTYPE html>
<html>
<body>
<%
	int temp = 0, cnt;
	int new_id = 0, ref = 0;
	String name, e_mail, title, content, passwd, reply;
	
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String sql_update;
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:4001/board_db";
		String user = "root";
		String password = "rnjsxortkd175*";
		conn = DriverManager.getConnection(url, user, password);
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
		String sql = "select max(id) as max_id, count(*) as cnt from board_tbl";
		rs = stmt.executeQuery(sql);
	}
	catch(Exception e){
		System.out.println("DB 연동 오류입니다. : " + e.getMessage());
	}
	
	while(rs.next()){
		cnt = Integer.parseInt(rs.getString("cnt"));
		if(cnt!=0)
			new_id = Integer.parseInt(rs.getString("max_id"));
	}
	
	new_id++;
	name = request.getParameter("name");
	e_mail = request.getParameter("e_mail");
	title = request.getParameter("title");
	content = request.getParameter("content");
	passwd = request.getParameter("passwd");
	reply = request.getParameter("reply");
	
	if("y".equals(reply)){
		ref = Integer.parseInt(request.getParameter("ref"));
	}
	else{
		ref=new_id;
	}
	
	sql_update = "insert into board_tbl values (" + new_id + ",'" + name + "','" + e_mail + "','" + title + "','" + content + "','" + passwd + "'," + ref + ")";
	try{
		stmt.executeUpdate(sql_update);
	}
	catch(Exception e){
		System.out.println("DB 연동 오류입니다. : " + e.getMessage());
	}
%>
<center>
	<h2> 작성한 글이 등록되었습니다.</h2>
	<a href="board-list.jsp">게시글 목록 보기</a>
</center>

</body>
</html>