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
	try {
		Connection conn = DriverManager.getConnection(dburl, dbuser, dbpassword);

		System.out.println("[JDBC] connected..");

		
		String sql = "insert into baseresult values('"+user+"', "+ cnt+", "+ elapsed/1000.0 +", to_date('"+ nowString+"','YYYY-MM-DD HH24:MI'))";
		System.out.println(sql);
		
		PreparedStatement ps = conn.prepareStatement(sql);
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
<body style="text-align: center;">
	<h2>미니게임 - 숫자야구</h2>
	<p>
		<b><%=user%></b> 로 <b><%=cnt%></b> 점이 랭킹 등록처리 결과. <b><%=rst %></b>
	</p>
	<a href="start.jsp"><button type="button">R E G A M E</button></a>
	<h3>전 체 랭 킹</h3>
	<p>
	<%
		Connection conn = DriverManager.getConnection(dburl, dbuser, dbpassword);

		System.out.println("[JDBC] connected..");

		String sql = "select * from baseresult order by tried asc, elapsed asc";
		PreparedStatement ps = conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		if(rs.next()) {
			int rank=1;
			do {
				String p1 = rs.getString("player");
				int n1 = rs.getInt("tried");
				java.sql.Date d1 = rs.getDate("logdate");
				double e1 = rs.getDouble("elapsed");
				%>
				RANk# <%=rank %>. <%=p1 %>
				<small>시도횟수 : <%=n1 %> / <%=e1 %> sec / <%=d1 %></small>
				<br/>
				<%
				rank++;
			}while(rs.next());
		}else {
			
		}
		conn.close();
	%>
	</p>

</body>
</html>
<%--
	데이터 저장을 할때 , 개별 데이터 제어를 쉽게 하려면 실제 젖아할 값들 외엥, 
	키값을 설정해두고 테이블 관리하는게 좋다.
	테이블에 설정가능 한 제약조건들에 대해서 .. 살펴보자. 
--%>