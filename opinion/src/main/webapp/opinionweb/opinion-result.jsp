<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8" 
	import="java.sql.*" 
	import="java.util.Date" 
	import="java.util.Calendar"
	import="java.text.DateFormat"
	import="java.text.SimpleDateFormat"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% 
	Calendar cal = Calendar.getInstance();
	cal.setTime(new Date());
	DateFormat df = new SimpleDateFormat("yyyy년 MM월 dd일 a hh:mm:ss");
%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title> JSP를 이용한 여론조사 </title>
	</head>
	<body>
	<%
		int choice_id, i;
		int opinion[]={0, 0, 0, 0, 0};
		float total, rate[]={0, 0, 0, 0, 0};
		String choice="";
		String fruit[]={"사과", "포도", "딸기", "메론", "키위"};
		String opinion_id=request.getParameter("opinion_id");
		Connection conn=null;
		Statement stmt=null;
		String sql="";
		ResultSet rs = null;
		System.out.println(opinion_id);

		try {
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:4001/opinion_db";
			conn = DriverManager.getConnection(url,"root","rnjsxortkd175*");
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			sql = "select * from opinion_tbl";
			rs = stmt.executeQuery(sql);
		}
		catch(Exception e) {
			out.println("DB 연동 오류입니다. : " + e.getMessage());
		}
		if(!rs.next()) {
			for(i = 0; i < 5; i++) {
				String sql1 = "insert into opinion_tbl values (" + i + ",'" + fruit[i] + "', 0)";
				try{
					stmt.executeUpdate(sql1);
				}
				catch(Exception e) {
					out.println("DB 연동 오류입니다.:" + e.getMessage());
				}
			}
		}
		else
	      {
	         sql="select * from opinion_tbl;";
	         rs = stmt.executeQuery(sql);
	         i = 0;
	         while(rs.next())
	         {
	            opinion[i++] = Integer.parseInt(rs.getString("sum"));
	         }
	      }
		
		if(opinion_id != null) {
			String sql2 = "update opinion_tbl set sum = sum + 1 where id = " + opinion_id;
			try{
				stmt.executeUpdate(sql2);
			}
			catch(Exception e) {
				out.println("DB 연동 오류입니다. : " + e.getMessage());
			}
		}
		
		choice_id = Integer.parseInt(opinion_id);
		opinion[choice_id] += 1;
		
		total = opinion[0] + opinion[1] + opinion[2] + opinion[3] + opinion[4];
		for(i = 0; i < 5; i++)
			rate[i] = (opinion[i] / total) * 100;
	%>
	
	<center>
		<h2> 여론조사 결과 </h2>
		여론조사 실행 일시: <%= df.format(cal.getTime()) %> 입니다.<br><br>
		<table border="0" width="500">
			<tr>
				<td bgcolor="yellow" width="30%"><b> 사과 : <%=Math.round(rate[0])%>%</b></td>
				<td><img src="pole.PNG" width=<%=rate[0]%>% height="25"></td>
			</tr>
			<tr>
				<td bgcolor="purple"><b> 포도 : <%=Math.round(rate[1])%>% </b></td>
				<td><img src="pole.PNG" width=<%=rate[1]%>% height="25"></td>
			</tr>
			<tr>
				<td bgcolor="red"><b> 딸기 : <%=Math.round(rate[2])%>%</b></td>
				<td><img src="pole.PNG" width=<%=rate[2]%>% height="25"></td>
			</tr>
			<tr>
				<td bgcolor="blue"><b> 메론 : <%=Math.round(rate[3])%>%</b></td>
				<td><img src="pole.PNG" width=<%=rate[3]%>% height="25"></td>
			</tr>
			<tr>
				<td bgcolor="green" width="30%"><b> 키위 : <%=Math.round(rate[4])%>%</b></td>
				<td><img src="pole.PNG" width=<%=rate[4]%>% height="25"></td>
			</tr>
		</table><br><br>
		당신은<font color="blue"><b><%=fruit[choice_id]%></b></font>를(을) 선택하였습니다.<br>
		총 <b><font color="red"><%=Math.round(total)%></font><b>명이 참여하였습니다.<p>
		<a href="opinion.html"> 처음으로</a>
	</center>
 </body>
</html>
