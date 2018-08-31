<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.UUID" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	try{
		String url = "jdbc:oracle:thin:@kkh.mockingu.com:1521:xe";
		String user = "dev";
		String password = "123";
		Connection conn = DriverManager.getConnection(url, user, password);
		System.out.println("[JDBC] 연결");
		
		String sql = "select * from baseresult order by tried asc, elapsed asc";
		PreparedStatement ps = conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body style="text-align: center;">
	
	<h2>이번달 랭킹 TOP5</h2>
	<p>
	
	</p>
	
</body>
</html>