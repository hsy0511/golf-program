# golf-program
# java (DB연결 코드)
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
![image](https://github.com/hsy0511/golf-program/assets/104752580/13cf7623-7bae-4895-933a-69b74ec7509c)

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
강사코드, 강사명, 강의명, 수강료, 강사자격취득일을 출력하는데 출력할 때 수강료 앞에는 ￦표시가 나오게 하고, 강사자격취득일은 yyyy년mm월dd일로 표현합니다.
```sql
select teacher_code, teacher_name, class_name,
to_char(class_price,'L999,999'),
substr(teach_resist_date,1,4) || '년' || 
substr(teach_resist_date,5,2) || '월' || 
substr(teach_resist_date,7,2) || '일' 
from tbl_teacher_202201
```
## 회원정보조회 페이지
수강월, 회원번호, 회원명, 강의명, 강의장소, 수강료, 등급을 출력하는데 수강료 앞에는 ￦표시가 나오게 하고, 수강월은 yyyy년mm월dd일로 표현합니다.
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
강사코드, 강의명, 강사명, 총매출을 출력하는데 총매출은 강사코드에 대한 강사의 수강료 더한 값을 나타내고 총매출 앞에는 ￦표시가 나오게 한다.
```sql
select c.teacher_code, t.class_name, t.teacher_name, 
to_char(sum(c.tuition),'L999,999') 
from tbl_teacher_202201 t, tbl_class_202201 c 
where t.teacher_code = c.teacher_code 
group by c.teacher_code, t.class_name, t.teacher_name 
order by teacher_code
```
# jsp
## 메인 페이지
![image](https://github.com/hsy0511/golf-program/assets/104752580/8ab3bbc8-02e9-4712-ab60-8860613d8222)

header.jsp, nav.jsp, section.jsp를 include하여 메인화면을 출력한다.
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
h1 태그를 사용하여 골프연습장 회원관리 프로그램 ver1.0라는 제목을 생성해주었다.
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
ul,li,a 태그를 이용하여 링크가 있는 목록을 생성해 주었다.
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
p 태그를 사용하여 HRDKOREA Copyrightⓒ2015 All rights reserved. Human Resources Development Service of Korea를 입력하였다.
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
![image](https://github.com/hsy0511/golf-program/assets/104752580/3e8400e7-5990-41cf-8fa2-2733fb4d2313)

db를 연결 시켜주고 조건에 맞는 쿼리문을 작성해주었다.
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
```
header, nav, footer는 include하여 가져왔다.

section에는 반복문을 사용하여 쿼리문에서 값들을 가져와 테이블을 생성했다.
```jsp
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
![image](https://github.com/hsy0511/golf-program/assets/104752580/0bb69ade-1fd2-4b02-9900-3560d93a2a6f)

db를 연결하고 테이블 2개를 select하였다.
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
```
form태그 안에 있는 값이 비었을 때 경고문을 띄워주고 포커스를  유효성 검사 코드를 작성하였다.
```jsp
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
```
select 박스에서 회원명에 따른 회원번호를 자동완성을 시켜주는 코드이고 회원명이 없는 회원명이면 none을 띄워준다.
```jsp
	function vDisplay(code) {
		alert(code);
		document.data.c_no.value = code;
		document.data.class_name.value = "none";
		document.data.tuition.value = "";
	}
```
회원명을 선택하지 않고 강의명을 선택하려고 하면 회원명을 먼저 선택하세요를 띄워준다.

강사코드에 따른 강의명에 수강료를 계산하는데 강사코드가 100면 100000, 200이면 200000, 300이면 300000, 400이면 400000을 출력한다.

하지만 만약에 회원번호 맨 앞자리가 2이면 수강료를 50% 할인하여 출력해준다.
```jsp
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
```
모든 데이터를 지우고 처음부터 다시씁니다를 출력하고 포커스가 맨 처음으로 이동한다. 
```jsp
	function re() {
		alert("처음부터 다시씁니다.");
		document.data.reset();
		document.data.resist_month.focus();
	}
</script>
</head>
```
header, nav, footer는 include하여 가져왔다.

form태그로 테이블을 감싼다. submit 버튼을 누르면 checkVal() 함수가 실행되고 문제가 없으면 ss_p.jsp 페이지로 이동한다.

회원명은 select 박스를 사용하는데 select 박스안에 있는 값을 반복문으로 나타낸다.

그리고 value값은 vDisplay() 함수로 이동한다.

강의명도 회원명과 동일하게 작동한다.

수강신청 버튼은 submit으로 지정하여 form 태그를  시키고, 다시쓰기 버튼은 re() 함수를 실행시킨다.
```jsp
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
## 수강신청 ss_p.jsp 페이지
수강신청을 할때 입력한 값을 회원정보테이블에 넣게 해주는 코드를 작성했다.
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

pstmt.executeUpdate();
%>
```
forward를 사용하여 index.jsp 메인화면으로 이동했다.
```jsp
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
![image](https://github.com/hsy0511/golf-program/assets/104752580/abebe7c9-10ef-462e-944c-376dbc2fb2e0)

db를 연결 시켜주고 조건에 맞는 쿼리문을 작성해주었다.
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
```
header, nav, footer는 include하여 가져왔다.

section에는 반복문을 사용하여 쿼리문에서 값들을 가져와 테이블을 생성했다.
```jsp
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
![image](https://github.com/hsy0511/golf-program/assets/104752580/6ae6dfc1-fbee-4326-bcf3-0ba286a440cb)

db를 연결 시켜주고 조건에 맞는 쿼리문을 작성해주었다.
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
```
header, nav, footer는 include하여 가져왔다.

section에는 반복문을 사용하여 쿼리문에서 값들을 가져와 테이블을 생성했다.
```jsp
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
# 결과
![image](https://github.com/hsy0511/golf-program/assets/104752580/04f40f0e-c3d1-4df1-85c9-190f5f503b6f)
![image](https://github.com/hsy0511/golf-program/assets/104752580/c8152683-c922-46b8-9f1c-a3105b8a69c2)
![image](https://github.com/hsy0511/golf-program/assets/104752580/316abed1-b2be-4e02-8791-3039e0221541)
![image](https://github.com/hsy0511/golf-program/assets/104752580/3093a965-7148-4a5f-aca8-6feb706931fb)
![image](https://github.com/hsy0511/golf-program/assets/104752580/11307fd8-441c-4568-a8e7-78829dea1d0e)
![image](https://github.com/hsy0511/golf-program/assets/104752580/61cbcb8a-5340-40b9-9682-cf283b8ce411)
![image](https://github.com/hsy0511/golf-program/assets/104752580/c584021e-dbaa-4117-82d3-33aeb8c1af6f)
![image](https://github.com/hsy0511/golf-program/assets/104752580/d720d3a3-18c8-4b53-ac86-772823ed5355)
![image](https://github.com/hsy0511/golf-program/assets/104752580/7ca9a7f1-8561-43f2-8642-cb0d4f05c4cc)
![image](https://github.com/hsy0511/golf-program/assets/104752580/6bd30ec5-6aa7-4e5a-b90e-e7f46fe6a4ba)




