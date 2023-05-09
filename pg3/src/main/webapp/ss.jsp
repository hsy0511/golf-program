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