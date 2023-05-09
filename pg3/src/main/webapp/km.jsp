<%@ page import="DB.DBConnect"%>
<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String sql = "select c.teacher_code, t.class_name, t.teacher_name, to_char(sum(c.tuition),'L999,999') from tbl_teacher_202201 t, tbl_class_202201 c where t.teacher_code = c.teacher_code group by c.teacher_code, t.class_name, t.teacher_name order by teacher_code";

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
				<td>강사코드</td>
				<td>강의명</td>
				<td>강사명</td>
				<td>총매출</td>
			</tr>
			<%while(rs.next()){ %>
			<tr align="center">
				<td><%=rs.getString(1) %></td>
				<td><%=rs.getString(2) %></td>
				<td><%=rs.getString(3) %></td>
				<td><%=rs.getString(4) %></td>
				<%} %>
			</tr>
		</table>
	</section>
	<footer>
		<jsp:include page="footer.jsp"></jsp:include>
	</footer>
</body>
</html>