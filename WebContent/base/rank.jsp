<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<%@ page import="beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String serial = UUID.randomUUID().toString().split("-")[0];
	String user = request.getParameter("user");
	int cnt = (Integer) session.getAttribute("cnt");
	long elapsed = (long) session.getAttribute("elapsed");
	java.sql.Date now = new java.sql.Date(System.currentTimeMillis()); // java.sql.Date

	BaseResultDAO dao = new BaseResultDAO();
	int r = dao.addData(serial, user, cnt, elapsed / 1000.0, now);
	System.out.println("r=="+r);
	List<Map<String, Object>> datas = dao.getAllDatas();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>GAME</title>
</head>
<body style="text-align: center">
	<h2>미니게임 - 숫자야구</h2>
	<p>
		<%
			if (r == 1) {
		%>
		<b><%=user%></b> 로 <b>시도횟수:<%=cnt%>(<%=elapsed / 1000.0%>sec)
		</b>가 기록되었습니다.
		<%
			} else {
		%>
		데이터처리과정에서 전산 오류가 발생하였습니다.
		<%
			}
		%>
	</p>
	<a href="start.jsp"><button type="button">R E G A M E</button></a>
	<h3>전체랭킹</h3>
	<p>
		<%if(datas != null){ 
			for(int i=0;i<datas.size();i++){
				Map<String,Object> each = datas.get(i);
				if(each.get("serial").equals(serial)){
				%>
					<font color="#B40404">RANk# <%=i+1 %>. <%=each.get("player") %>
				<small>시도횟수 : <%=each.get("tried") %> / <%=each.get("elapsed") %> sec / <%=each.get("logdate") %></small></font><br/>
				<%
				}else{				
				%>
				RANk# <%=i+1 %>. <%=each.get("player") %>
				<small>시도횟수 : <%=each.get("tried") %> / <%=each.get("elapsed") %> sec / <%=each.get("logdate") %></small><br/>
					<%
				}
			}	
		}%>
	</p>
</body>
</html>
<%--
	데이터 저장을 할때, 개별 데이터 제어를 쉽게 하려면 실제 저장할 값들 외에, 
	키값을 설정해두고 테이블을 관리하는게 좋다. 
	
	테이블에 설정가능한 제약조건들에 대해서...살펴보자.

 --%>







