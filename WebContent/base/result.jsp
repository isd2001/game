<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
	String[] ans = request.getParameterValues("ans");
	int[] ians = new int[ans.length];
	for (int i = 0; i < ans.length; i++) {
		ians[i] = Integer.parseInt(ans[i]);
	}
	if (ians[0] == ians[1] || ians[0] == ians[2] || ians[1] == ians[2]) {
		throw new IllegalArgumentException("duplicated number");
	}
	//=======================================================================
	int[] t = (int[]) session.getAttribute("target");
	int s = 0;
	int b = 0;
	for (int ii = 0; ii < ians.length; ii++) {
		int n = ians[ii];
		for (int jj = 0; jj < t.length; jj++) {
			if (t[jj] == n) {
				if (ii == jj) {
					s++;
				} else {
					b++;
				}
			}
		}
	}
	int cnt = (Integer) session.getAttribute("cnt");
	session.setAttribute("cnt", cnt + 1);
	Map<String, String> map =(Map)session.getAttribute("log");
	map.put(ans[0]+","+ans[1]+","+ans[2] ,  s+"STRIKE " + b+" BALL");
	session.setAttribute("log", map);
	//=========================================================================
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
		TRY
		<%=cnt%>!<br /> 당신이 추측하신 숫자 <b>[ <%=ians[0]%> ] [ <%=ians[1]%> ]
			[ <%=ians[2]%> ]
		</b> 은/는 <b style="color: red"><%=s%> STRIKE</b> <b style="color: blue"><%=b%>
			BALL</b> 입니다.
	</p>
	<p>
		<%
			if (s == 3) {
				long start = (long)session.getAttribute("start");
				long now = System.currentTimeMillis();
				long elpased = now-start;
				session.setAttribute("elapsed", now-start);
		%>
	<p>
		정답입니다! 기록 : <%=cnt%> 번만에 성공!! (<small><%=elpased/1000.0 %> sec</small>)
		<a href="start.jsp"><button type="button">R E G A M E</button></a>
	</p>
		<h3>게임기록 저장</h3>
		<form action="rank.jsp" method="post">
			<p>
				게임이 완료되었습니다.<br/>
				자신의 기록을 저장하시려면 이름을 입력후 확인을 눌러주세요.
			</p>
			<p>
			<input type="text" name="user" style="text-align: center"/>
			<button type="submit">확인</button>
			</p>
		</form>
	<%
		} else {
	%>
	<p>
		다시 한번 ?
		<a href="turn.jsp"><button type="button">R E T R Y</button></a>
	</p>
	<%
		}
	%>




</body>
</html>



