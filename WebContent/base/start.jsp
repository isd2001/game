<%@ page import="java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="beans.BaseResultDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	BaseResultDAO dao = new BaseResultDAO();
	Map one = dao.getRankTopData();
	int[] nums = new int[3];
	do {
		for (int i = 0; i < nums.length; i++) {
			nums[i] = 1 + (int) (Math.random() * 9);
		}
	} while (nums[0] == nums[1] || nums[0] == nums[2] || nums[1] == nums[2]);

	session.setAttribute("target", nums);
	session.setAttribute("cnt", 1);
	session.setAttribute("log", new LinkedHashMap());
	session.setAttribute("start", System.currentTimeMillis());
	System.out.println(nums[0]+"/"+nums[1]+"/"+nums[2]);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>GAME</title>
</head>
<body style="text-align: center">
	<!-- <%=nums[0]%> .. <%=nums[1]%> .. <%=nums[2]%> -->
	<h2>미니게임 - 숫자야구</h2>
	<h3>명예의 전당<span style="font-size: x-small;"><a href="ranklist.jsp"	style="text-decoration: none;">+ 더보기 </a></span></h3>
	<p>
	<% if(one!=null){ %>
	
		<%=one.get("player") %>(player) >> <small><%=one.get("tried") %>(횟수),<%=one.get("logdate") %>(걸린시간)</small> 
	</p>
	<%}else{ %>
		-
		<%} %>
 conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}%>
	<p>
		서로 다른 숫자들(1~9)로 구성된 3자리 수를 맞추시면 됩니다.<br /> 총 <b>10</b>회의 기회가 부여되며, 매
		입력에 따른 결과를 토대로 정답을 추출해 나가시면 됩니다.<br /> 시작을 하시려면 아래 버튼을 눌러주세요.<br/>(중복 없습니다.)
	</p>
	<p>
		<a href="turn.jsp"><button type="button">S T A R T</button></a>
	</p>
</body>
</html>

