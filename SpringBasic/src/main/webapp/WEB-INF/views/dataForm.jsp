<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action = "/getData" method = "post">
		<input type="text" name = "data1" placeholder = "데이터1 값"><br>
		<input type="number" name = "data2" placeholder = "데이터2 값"><br>
		<input type="submit" value = "데이터 전송">
	</form>
</body>
</html>