<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%-- /score 라는 공통주소를 쓰되
	get, post접속으로 폼 접속인지, 결과 확인인지 나뉩니다.
	따라서 폼 접속을 이미 했다면 목적지는 공통주소인 /score가 되고
	post방식으로 전송하도록 하면 결과페이지에 도달할 수 있습니다.--%>
	<h3>각 과목의 성적을 입력해주세요</h3>
	
	<form action="/score" method="post">
		<input type="number" name="math" max="100" min="0" placeholder="수학"><br>
		<input type="number" name="eng" max="100" min="0" placeholder="영어"><br>
		<input type="number" name="lan" max="100" min="0" placeholder="언어"><br>
		<input type="number" name="soc" max="100" min="0" placeholder="사회탐구"><br>
		<input type="number" name="computer" max="100" min="0" placeholder="컴퓨터"><br>
		<input type="submit">
	</form>
</body>
</html>