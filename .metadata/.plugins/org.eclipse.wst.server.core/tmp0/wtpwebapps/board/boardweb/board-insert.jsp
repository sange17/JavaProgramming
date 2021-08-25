<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <body>
        <center>
        	<h2>게  시  판</h2>
            <form action="board-insert-db.jsp" method="POST">
                <table border="0">
                    <tr>
                        <td>글쓴이:</td>
                        <td><input type="text" name="name" size="15"></td>
                    </tr>
                    <tr>
                        <td>메일주소:</td>
                        <td><input type="text" name="e_mail" size="30"></td>
                    </tr>
                    <tr>
                        <td>글제목:</td>
                        <td><input type="text" name="title" size="50"></td>
                    </tr>
                    <tr>
                        <td>글내용:</td>
                        <td><textarea name="content" cols="65" rows="4"></textarea></td>
                    </tr>
                    <tr>
                        <td>패스워드:</td>
                        <td><input type="password" name="passwd" size="10" maxlength="8"></td>
                    </tr>
                </table><br><br>
    
                <input type="submit" value="등록하기">
                <input type="reset" value="다시쓰기">
                
                <%
                    String flag = request.getParameter("flag");
                if("r".equals(flag)){%>
                    <input type="hidden" name="ref" value="<%=request.getParameter("ref")%>">
                    <input type="hidden" name="reply" value="y">
                <% }
                else %>
                    <input type="hidden" name="reply" value="n">
            </form><br><br>
    
            <a href="board-list.jsp">게시글 목록 보기</a>
            <hr width="60%">
        </center>
    </body>
</html>