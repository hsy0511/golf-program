<%@ page import="DB.DBConnect"%>
<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String sql = "select substr(c.resist_month,1,4) || '년' || substr(c.resist_month,5,2) || '월' || substr(c.resist_month,7,2) || '일', m.c_no, m.c_name, t.class_name, c.class_area, to_char(c.tuition,'L999,999'), m.grade from tbl_teacher_202201 t, tbl_member_202201 m, tbl_class_202201 c where m.c_no = c.c_no and t.teacher_code = c.teacher_code";

Connection conn = DBConnect.getConnection();
PreparedStatement pstmt = conn.prepareStatement(sql);
ResultSet rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="style.css?abc">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<header>
		<jsp:include page="header.jsp"></jsp:include>
	</header>
	<nav>
		<jsp:include page="nav.jsp"></jsp:include>
	</nav>
	<section class="section">
		<h1>회원정보조회</h1>
		<table class="table">
			<tr align="center">
				<td>수강월</td>
				<td>회원번호</td>
				<td>회원명</td>
				<td>강의명</td>
				<td>강의장소</td>
				<td>수강료</td>
				<td>등급</td>
			</tr>
			<%while(rs.next()){ %>
			<tr align="center">
				<td><%=rs.getString(1) %></td>
				<td><%=rs.getString(2) %></td>
				<td><%=rs.getString(3) %></td>
				<td><%=rs.getString(4) %></td>
				<td><%=rs.getString(5) %></td>
				<td><%=rs.getString(6) %></td>
				<td><%=rs.getString(7) %></td>
				<%} %>
			</tr>
		</table>
	</section>
	<footer>
		<jsp:include page="footer.jsp"></jsp:include>
	</footer>
</body>
</html>