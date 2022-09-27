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
<h1>서적관리시스템 - 삭제(D)</h1>
<hr>

<%
	String driverName = "org.mariadb.jdbc.Driver";
	String url = "jdbc:mariadb://localhost:3307/book_db";
	String id = "root";
	String password = "print(\"0926\")";
	
	try {

	Class.forName(driverName);
	Connection con = DriverManager.getConnection(url, id, password);
	Statement stmt = con.createStatement();
	PreparedStatement pstmt = null;
	request.setCharacterEncoding("utf-8");
%>

<%
	int book_id; // = Integer.parseInt(request.getParameter("book_id"))
	String title;
	String publisher;
	String year;
	int price;
	
	
	String sql = "SELECT * FROM books";
	pstmt = con.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
%>
	<table border = "1">
		<thead>
			<tr>
				<th>순번</th>
				<th>제목</th>
				<th>출판사</th>
				<th>출판년도</th>
				<th>가격</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
<%
	while(rs.next()) {
		book_id = rs.getInt("book_id");
		title = rs.getString("title");
		publisher = rs.getString("publisher");
		year = rs.getString("year");
		price = rs.getInt("price");
%>
			<tr>
				<td><%=book_id%></td>
				<td><%=title%></td>
				<td><%=publisher%></td>
				<td><%=year%></td>
				<td><%=price%></td>
				<td>
				<a href ="book_dao.jsp?actionType=D&send_id=<%=book_id%>">삭제</a>
				</td>
			</tr>
<%
//	String send_id = request.getParameter("send_id");
//	System.out.println(send_id+"<--send_id");
%>
			
<%
	}
	} catch(SQLException se) {
		System.out.println(se.getMessage());
	} 
%>

		</tbody>
	</table>

<br><a href = "./index.jsp">홈으로 돌아가기</a>
</body>
</html>