<%@page import="java.sql.Date"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String user = request.getParameter("user");
	int cnt = (Integer) session.getAttribute("cnt");
	long elapsed = (long) session.getAttribute("elapsed");

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");	
	//	application.setAttribute(arg0, arg1);;
	String nowString = sdf.format(System.currentTimeMillis());
	
	String dburl = "jdbc:oracle:thin:@13.125.80.20:1521:xe";
	// ↑ DB 종류, 서버 위치등등을 설정 - 어떤 DB로 연결을 할꺼냐에 따라 작성요령이 있음.
	String dbuser = "dev"; // 계정이름
	String dbpassword = "123"; // 해당계정의 비밀번호
	
	boolean rst;
	Date now = new Date(System.currentTimeMillis());
	
	try {
		Connection conn = DriverManager.getConnection(dburl, dbuser, dbpassword);

		System.out.println("[JDBC] connected..");

		
		//String sql = "insert into baseresult values(?,?,?,to_date(?,'YYYY-MM-DD HH24:MI'))";
		/*
			oralce's to_date 함수는 Y년 , M월 , D일 , HH12 (0~11)or HH24(0~23) 시 , MI 분 , SS초
		*/
		//PreparedStatement ps = conn.prepareStatement(sql);
		/*
			데이터 세팅 , setInt, setLong , setDouble , setFloat , setString 형태의 메서드로 데이터세팅
			첫번째 매개변수 ? 위치 (int)
			두번째 매개변수 date (어떤 데이터냐에 따라 다름)
		*/
		//ps.setString(1,user);
		//ps.setInt(2, cnt);
		//ps.setDouble(3, elapsed/1000.0);
		//ps.setString(4, nowString);
		
		String sql = "insert into baseresult values(?,?,?,?)";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,user);
		ps.setInt(2, cnt);
		ps.setDouble(3, elapsed/1000.0);
		ps.setDate(4, now);
		
		int n = ps.executeUpdate(); // send → receive 작업을 함.

		System.out.println("[JDBC] result = " + n); // insert 한해서는 이게 1밖에 안나옴.

		conn.close();
		System.out.println("[JDBC] done.."); // 프로그램에서 연결잡아서 하는 작업은 기본이 commit 된다.
		rst = true;
	} catch (Exception e) {
		System.out.println("[JDBC] ERROR - " + e);
		e.printStackTrace();
		rst = false;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GAME</title>
</head>
<body>
	<h2>미니게임 - 숫자야구</h2>
	<p>
		<b><%=user%></b> 로 <b><%=cnt%></b> 점이 랭킹 등록처리 결과. <b><%=rst %></b>
	</p>
	<a href="start.jsp"><button type="button">R E G A M E</button></a>
</body>
</html>