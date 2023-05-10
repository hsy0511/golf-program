# golf-program
# java
```java
package DB;
import java.sql.*;
public class DBConnect{
public static Connection getConnection() throws Exception {
	 Connection conn = null;
	 
	 String url = "jdbc:oracle:thin:@//localhost:1521/xe";
	 String user = "system";
	 String pw = "1234";
	
	 Class.forName("oracle.jdbc.OracleDriver");
 		conn = DriverManager.getConnection(url,user,pw);
 		return conn;
 }
}

```
# DB table
```sql

create table tbl_teacher_202201 (
	teacher_code char(3) not null,
	teacher_name varchar2(15),
	class_name varchar2(20),
	class_price number(8),
	teach_resist_date varchar2(8),
	primary key(teacher_code)
);

insert into tbl_teacher_202201
values ('100', '이초급', '초급반', 100000, '20220101');
insert into tbl_teacher_202201
values ('200', '김중급', '중급반', 200000, '20220102');
insert into tbl_teacher_202201
values ('300', '박고급', '고급반', 300000, '20220103');
insert into tbl_teacher_202201
values ('400', '정심화', '심화반', 400000, '20220104');

create table tbl_member_202201 (
	c_no char(5) not null,
	c_name varchar2(15),
	phone varchar2(11),
	address varchar2(50),
	grade varchar2(6),
	primary key(c_no)
);

insert into tbl_member_202201
values ('10001', '홍길동', '01011112222', '서울시 강남구', '일반');
insert into tbl_member_202201
values ('10002', '장발장', '01022223333', '성남시 분당구', '일반');
insert into tbl_member_202201
values ('10003', '임꺽정', '01033334444', '대전시 유성구', '일반');
insert into tbl_member_202201
values ('20001', '성춘향', '01044445555', '부산시 서구', 'VIP');
insert into tbl_member_202201
values ('20002', '이몽룡', '01055556666', '대구시 북구', 'VIP');

create table tbl_class_202201 (
	resist_month varchar2(6) not null,
	c_no char(5) not null,
	class_area varchar2(15),
	tuition number(8),
	teacher_code char(3),
	primary key(resist_month, c_no)
);

insert into tbl_class_202201
values('202203', '10001', '서울본원', 100000, '100');
insert into tbl_class_202201
values('202203', '10002', '성남분원', 100000, '100');
insert into tbl_class_202201
values('202203', '10003', '대전분원', 200000, '200');
insert into tbl_class_202201
values('202203', '20001', '부산분원', 150000, '300');
insert into tbl_class_202201
values('202203', '20002', '대구분원', 200000, '400');
```
# sql 쿼리문
## 강사조회 페이지
```sql
select teacher_code, teacher_name, class_name,
to_char(class_price,'999,999'),
substr(teach_resist_date,1,4) || '년' || 
substr(teach_resist_date,5,2) || '월' || 
substr(teach_resist_date,7,2) || '일' 
from tbl_teacher_202201
```
## 회원정보조회 페이지
```sql
select substr(c.resist_month,1,4) || '년' || 
substr(c.resist_month,5,2) || '월' || 
substr(c.resist_month,7,2) || '일',
m.c_no, m.c_name, t.class_name, c.class_area, 
to_char(c.tuition,'L999,999'), m.grade 
from tbl_teacher_202201 t, tbl_member_202201 m, tbl_class_202201 c
where m.c_no = c.c_no and t.teacher_code = c.teacher_code
```
## 강사매출현황
```jsp
select c.teacher_code, t.class_name, t.teacher_name, 
to_char(sum(c.tuition),'L999,999') 
from tbl_teacher_202201 t, tbl_class_202201 c 
where t.teacher_code = c.teacher_code 
group by c.teacher_code, t.class_name, t.teacher_name 
order by teacher_code
```
# jsp
## 메인 페이지
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel = "stylesheet" href = "style.css?abc">
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
<section>
<jsp:include page="section.jsp"></jsp:include>
</section>
<footer>
<jsp:include page="footer.jsp"></jsp:include>
</footer>
</body>
</html>
```
### header 페이지
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel = "stylesheet" href = "style.css?abc">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<header class = "header">
<h1> 골프연습장 회원관리 프로그램 ver1.0</h1>
</header>
</body>
</html>
```
### nav 페이지
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel = "stylesheet" href = "style.css?abc">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<nav class = "nav">
<ul>
<li><a href = "kj.jsp">강사조회</a></li>
<li><a href = "ss.jsp">수강신청</a></li>
<li><a href = "hj.jsp">회원정보조회</a></li>
<li><a href = "km.jsp">강사매출현황</a></li>
<li><a href = "index.jsp">홈으로</a></li>
</ul>
</nav>
</body>
</html>
```
### section 페이지
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel = "stylesheet" href = "style.css?abc">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<section class = "section">
</section>
</body>
</html>
```
### footer 페이지
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel = "stylesheet" href = "style.css?abc">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<footer class = "footer">
<p>HRDKOREA Copyrightⓒ2015 All rights reserved. Human Resources Development Service of Korea
</footer>
</body>
</html>
```
## 강사조회 페이지
```jsp
<%@ page import="DB.DBConnect" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	String sql = "select teacher_code, teacher_name, class_name, to_char(class_price,'L999,999'), substr(teach_resist_date,1,4) || '년' || substr(teach_resist_date,5,2) || '월' || substr(teach_resist_date,7,2) || '일' from tbl_teacher_202201";

	Connection conn = DBConnect.getConnection();
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
	
%>
<!DOCTYPE html>
<html>
<head>
<link rel = "stylesheet" href = "style.css?abc">
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
<section class = "section">
<h1>강사조회</h1>
<br>
<table class = "table">
<tr align="center">
<td>강사코드</td><td>강사명</td><td>강의명</td><td>수강료</td><td>강사자격취득일</td>
</tr>
<%while(rs.next()){ %>
<tr align="center">
<td><%=rs.getString(1) %></td>
<td><%=rs.getString(2) %></td>
<td><%=rs.getString(3) %></td>
<td><%=rs.getString(4) %></td>
<td><%=rs.getString(5) %></td>
<%} %>
</tr>
</table>
</section>
<footer>
<jsp:include page="footer.jsp"></jsp:include>
</footer>
</body>
</html>
```
## 수강신청 페이지
```jsp
<%@page import="DB.DBConnect"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String sql1 = "select c_no, c_name from tbl_member_202201";
String sql2 = "select teacher_code, class_name from tbl_teacher_202201";

Connection conn = DBConnect.getConnection();
PreparedStatement pstmt1 = conn.prepareStatement(sql1);
PreparedStatement pstmt2 = conn.prepareStatement(sql2);

ResultSet rs1 = pstmt1.executeQuery();
ResultSet rs2 = pstmt2.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/style.css">
<script type="text/javascript">
	function checkVal() {
		var cls = document.data;

		if (!cls.resist_month.value) {
			alert("수강월이 입력되지 않았습니다.");
			cls.resist_month.focus();
			return false;
		}
		if (!cls.c_name.value == "none") {
			alert("회원명이 선택되지 않았습니다.");
			cls.c_name.focus();
			return false;
		}
		if (!cls.class_area.value) {
			alert("강의장소 입력되지 않았습니다.");
			cls.class_area.focus();
			return false;
		}
		if (!cls.class_name.value) {
			alert("강의명 입력되지 않았습니다.");
			cls.class_name.focus();
			return false;
		}
		alert("수강신청이 정상적으로 완료되었습니다!")
		return true;
	}
	
	function vDisplay(code) {
		alert(code);
		document.data.c_no.value = code;
		document.data.class_name.value = "none";
		document.data.tuition.value = "";
	}

	function cal(tcode) {
		var mbr = document.data.c_no.value;

		if (!mbr) {
			alert("회원명을 먼저 선택하세요.");
			document.data.class_name[0].selected = true;
			document.data.c_name.focus();
		} else {
			var salesPrice = 0;

			switch (tcode) {
			case "100":
				salePrice = 100000;
				break;
			case "200":
				salePrice = 200000;
				break;
			case "300":
				salePrice = 300000;
				break;
			case "400":
				salePrice = 400000;
				break;
			}

			if (mbr.charAt(0) == '2') {
				alert("수강료가 50% 할인되었습니다.");
				salePrice = salePrice / 2;
			}

			document.data.tuition.value = salePrice;
		}
	}

	function re() {
		alert("처음부터 다시씁니다.");
		document.data.reset();
		document.data.resist_month.focus();
	}
</script>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<jsp:include page="nav.jsp"></jsp:include>
	<section class="section">
		<h1>수강신청</h1>

		<form action="ss_p.jsp" method="post" name="data"
			onsubmit="return checkVal()">
			<table class="table">
				<tr>
					<th>수강월</th>
					<td><input type="text" name="resist_month"> 2022년03월
						예)202203</td>
				</tr>
				<tr>
					<th>회원명</th>
					<td><select name="c_name" onchange="vDisplay(this.value)">
							<option value="none">회원명</option>
							<%
							while (rs1.next()) {
							%>
							<option value="<%=rs1.getString("c_no")%>"><%=rs1.getString("c_name")%></option>
							<%
							}
							%>
					</select> <input type="button" value="수강확인"></td>
				</tr>
				<tr>
					<th>회원번호</th>
					<td><input type="text" name="c_no" readonly> 예)10001</td>
				</tr>
				<tr>
					<th>강의장소</th>
					<td><input type="text" name="class_area"></td>
				</tr>
				<tr>
					<th>강의명</th>
					<td><select name="class_name" onchange="cal(this.value)">
							<option value="">강의신청</option>
							<%
							while (rs2.next()) {
							%>
							<option value="<%=rs2.getString("teacher_code")%>"><%=rs2.getString("class_name")%></option>
							<%
							}
							%>
					</select></td>
				</tr>
				<tr>
					<th>수강료</th>
					<td><input type="text" name="tuition" readonly> 원</td>
				</tr>
				<tr>
					<th colspan="2"><input type="submit" value="수강신청"> <input
						type="button" value="다시쓰기" onclick="return re()">
				</tr>
			</table>
		</form>
	</section>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
```
## 수강신청 insert 페이지
```jsp
<%@page import="java.sql.*"%>
<%@page import="DB.DBConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String sql = "insert into tbl_class_202201 values (?,?,?,?,?)";

Connection conn = DBConnect.getConnection();
PreparedStatement pstmt = conn.prepareStatement(sql);

pstmt.setString(1, request.getParameter("resist_month"));
pstmt.setString(2, request.getParameter("c_no"));
pstmt.setString(3, request.getParameter("class_area"));
pstmt.setInt(4, Integer.parseInt(request.getParameter("tuition")));
pstmt.setString(5, request.getParameter("class_name"));

System.out.print("CLASS_NAME : " + request.getParameter("class_name"));

pstmt.executeUpdate();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:forward page="index.jsp"></jsp:forward>
</body>
</html>
```
## 회원정보조회 페이지
```jsp
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
```
## 강사매출현황
```jsp
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
```
# css
페이지와 알맞게 css를 구성해 줍니다.
```css
@charset "UTF-8";

*{
	list-style: none;
	padding: 0;
	margin: 0;
}

.header{
	position:fixed;
	top: 0px;
	width: 100%;
	height: 80px;
	line-height: 80px;
	background-color: blue;
	text-align: center;
	color: white;
}

.nav{
	position:fixed;
	top: 80px;
	width: 100%;
	height: 40px;
	line-height: 40px;
	background-color: rgb(128, 128, 255);
}

.nav ul li{
	float: left;
	padding: 0 15px;
}

.nav ul li a{
	text-decoration: none;
	color: white;
}

.section{
	position : fixed;
	top:120px;
	width: 100%;
	height:800px;
	background-color: #c0c0c0;
	overflow:auto;
	
}

.section h1{
	text-align: center;
	padding: 3px;
}

.footer{
	position:absolute;
	bottom : 0;
	width: 100%;
	height: 50px;
	line-height: 50px;
	background-color: blue;
	text-align: center;
	color: white;
	
}


.table{
	border: solid 1px black;
	border-collapse: collapse;
	margin: auto;
	overflow:auto;
}

.table tr td{
	border: solid 1px black;
	padding: 5px 20px;
} 

.table tr th{
	border: solid 1px black;
	padding: 5px 20px;
}
```
