<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>서적관리시스템 - 데이터베이스 처리 부분</h1>
<hr>
<%
	String driverName = "org.mariadb.jdbc.Driver";
	String url = "jdbc:mariadb://localhost:3307/book_db";
	String id = "root";
	String password = "print(\"0926\")";
	
	Class.forName(driverName);
	Connection con = DriverManager.getConnection(url, id, password);
	Statement stmt = con.createStatement();
	PreparedStatement pstmt = null;
	request.setCharacterEncoding("utf-8");
%>

<%
	String actionType = request.getParameter("actionType");
	
	int book_id;
	String title;
	String publisher;
	String year;
	int price;
	
	String sql;
	int result;
	String msg = "실행결과 : ";
	
	switch(actionType) {
	case "C":
		title = request.getParameter("title");
		publisher = request.getParameter("publisher");
		year = request.getParameter("year");
		price = Integer.parseInt(request.getParameter("price"));
		
		sql = "INSERT INTO books (title, publisher, year, price) VALUES";
		sql += "('" + title + "','" + publisher + "','" + year + "','" + price + "')";
		
		System.out.println(sql);
		
		result = stmt.executeUpdate(sql);
		
		if(result == 1) {
			System.out.println("레코드 추가 성공");
			msg += "레코드 추가 성공";
		}
		else {
			System.out.println("레코드 추가 실패");
			msg += "레코드 추가 실패";
		}
		break;
	
	case "U":
		title = request.getParameter("title");
		publisher = request.getParameter("publisher");
		year = request.getParameter("year");
		price = Integer.parseInt(request.getParameter("price"));
		book_id = Integer.parseInt(request.getParameter("book_id"));
		
		try {
			pstmt = con.prepareStatement("update books set title = ?, publisher = ?, year = ?, price = ? where book_id = ?");
			System.out.println(pstmt + "<-- pstmt 1");
			pstmt.setString(1, title);
			pstmt.setString(2, publisher);
			pstmt.setString(3, year);
			pstmt.setInt(4, price);
			pstmt.setInt(5, book_id);
			
			System.out.println(pstmt + "<--- pstmt 2");
			
			result = pstmt.executeUpdate();
			
			if(result == 1) {
				System.out.println("레코드 수정 성공");
				msg += "레코드 수정 성공";
			}
			else {
				System.out.println("레코드 수정 실패");
				msg += "레코드 수정 실패";
			}
			
		} catch(SQLException se) {
			System.out.println(se.getMessage());
		}
		
		break;
		
	case "D":
	
		int send_id = Integer.parseInt(request.getParameter("send_id"));
		System.out.println(send_id + "<--send_id");
		
		try {
			pstmt = con.prepareStatement("DELETE FROM books WHERE book_id = ?");
			System.out.println(pstmt + "<-- pstmt 1");
			pstmt.setInt(1, send_id);
			
			System.out.println(pstmt + "<--- pstmt 2");
			
			result = pstmt.executeUpdate();
			
			if(result == 1) {
				System.out.println("레코드 삭제 성공");
				msg += "레코드 삭제 성공";
			}
			else {
				System.out.println("레코드 삭제 실패");
				msg += "레코드 삭제 실패";
			}
			
		} catch(SQLException se) {
			System.out.println(se.getMessage());
		}
		
		break;

	}
	
%>

<h2><%=msg%></h2>

<br><a href="./index.jsp">홈으로 돌아가기</a>
</body>
</html>