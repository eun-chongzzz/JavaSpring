<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>${board.bno}번 글을 수정합니다.</h1>
	<form action="/boardUpdate" method="POST">
		<input type="hidden" name="bno" value="${board.bno }">
		<input type="text" name="title" value="${board.title }">
		<input type="text" name="writer" value="${board.writer }" readonly><br>
		<textarea rows="20" cols="50" name="content">${board.content }</textarea><br>
		<input type="submit" value="수정"><input type="reset" value="초기화">
	</form>
</body>
</html>