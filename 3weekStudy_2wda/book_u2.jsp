<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서적관리시스템 - 입력</title>
</head>
<body>

<h1>서적관리시스템 - 자료수정(U2)</h1>
<hr>

<%
int send_id = Integer.parseInt(request.getParameter("send_id"));
System.out.println(send_id + "<--send_id");
Connection con = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
	String driverName = "org.mariadb.jdbc.Driver";
	String url = "jdbc:mariadb://localhost:3307/book_db";
	String id = "root";
	String password = "print(\"0926\")";

	Class.forName(driverName);
	con = DriverManager.getConnection(url, id, password);
	System.out.println(con + "<-- book.jsp");
	pstmt = con.prepareStatement("SELECT * FROM books WHERE book_id=?");
	pstmt.setInt(1, send_id);
	
	System.out.println(pstmt + "<-- pstmt");
	rs = pstmt.executeQuery();
	request.setCharacterEncoding("utf-8");
	
	if(rs.next()){
		System.out.println("if 조건문 실행 book_u2.jsp");
		int dbbook_id =  rs.getInt("book_id");
		String dbtitle = rs.getString("title");
		String dbpub = rs.getString("publisher");
		String dbyear = rs.getString("year");
		int dbprice = rs.getInt("price");
		System.out.println(dbbook_id+"<- dbbook_id");
		System.out.println(dbtitle+"<-dbtitle");
		System.out.println(dbpub+"<-dbpub");
		System.out.println(dbyear+"<-dbyear");
		System.out.println(dbprice+"<- dbprice");
	
%>

<form method = "post" action = "./book_dao.jsp">
	<br>서적번호(수정불가) : <input type = "text" name = "book_id" size = "30" readonly value = "<%= dbbook_id %>">
	<br>서적명 : <input type = "text" name = "title" size = "30" value = "<%= dbtitle %>">
	<br>출판사 : <input type = "text" name = "publisher" size = "30" value="<%= dbpub %>">
	<br>출판년도 : <input type = "text" name = "year" size = "30" value="<%= dbyear %>">
	<br>가격 : <input type = "text" name = "price" size = "30" value="<%= dbprice %>">
	<br><input type = "hidden" name = "actionType" value = "U">
	<br><input type = "submit" value = "수정">
</form>
<%
	}
	
} catch(SQLException ex) {
	out.println(ex.getMessage());
	ex.printStackTrace();
} 
%>

<br><a href = "./index.jsp">홈으로 돌아가기</a>

</body>
</html>