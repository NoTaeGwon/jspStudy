<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>데이터베이스 연결 테스트 JSP페이지</title>
</head>
<body>
<h1>데이터베이스 연결 테스트</h1>
<hr>

<%
	String driverName = "org.mariadb.jdbc.Driver";
	String url = "jdbc:mariadb://localhost:3307/book_db";
	String id = "root";
	String password = "print(\"0926\")";
	
	Class.forName(driverName);
	System.out.println("드라이버 로드 성공");
%>
	<br><h2>드라이버 로드 성공</h2>
<%
	Connection con = DriverManager.getConnection(url, id, password);
	System.out.println("데이터베이스 연결 성공");
%>
	<br><h2>데이터베이스 연결 성공</h2>
<%
	con.close();
%>
</body>
</html>