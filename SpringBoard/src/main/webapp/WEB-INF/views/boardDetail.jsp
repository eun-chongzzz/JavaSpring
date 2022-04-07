<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>${detail.bno }번 글 상세페이지</h1>
	글제목 : <input type="text" value="${detail.title }" readonly><br>
	글쓴이 : <input type="text" value="${detail.writer }" readonly><br>
	쓴날짜 : <input type="text" value="${detail.regdate }" readonly><br>
	마지막 수정날짜 : <input type="text" value="${detail.updatedate }" readonly><br>
	본문 : <textarea rows="15" cols="50" readonly>${detail.content }</textarea><br>
</body>
</html>