<%@ page import="java.util.Map.Entry"%>
<%@ page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	System.out.println(session.getAttribute("baseFlag"));

	int cnt = (Integer) session.getAttribute("cnt");
	Map map = (Map) session.getAttribute("log");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GAME</title>
</head>
<body style="text-align: center">
	<h2>미니게임 - 숫자야구</h2>
	<p>
		<b style="color: blue"><%=cnt%>번째 시도 !</b>
	</p>
	<p style="font-size: 70pt;">
		<b>???</b>
	</p>
	<p>
		<%
			for (Iterator<Entry> it = map.entrySet().iterator(); it.hasNext();) {
				Entry en = it.next();
		%>
		<b><%=en.getKey()%></b> is <small><%=en.getValue()%></small><br />
		<%
			}
		%>
	</p>
	<form action="result.jsp">
		<p>
			<input type="number" min="1" max="9" name="ans"
				style="text-align: center; font-size: 15pt;" /> <input
				type="number" min="1" max="9" name="ans"
				style="text-align: center; font-size: 15pt;" /> <input
				type="number" min="1" max="9" name="ans"
				style="text-align: center; font-size: 15pt;" />
		</p>
		<p>
			<button type="submit">확인</button>
		</p>
	</form>
</body>
</html>