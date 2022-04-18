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
		<!-- 수정을 했다면, 수정완료후에도 페이지번호ㅡ 검색조건, 검색어가 유지되도록
		전달받은 데이터를 폼으로 다시 넘겨줘야 합니다.
		넘겨받은 pageNum, searchType, keyword를 재전달하도록 폼 내부에 추가해주세요 -->
		<input type="hidden" name="pageNum" value="${param.pageNum }">
		<input type="hidden" name="searchType" value="${param.searchType }">
		<input type="hidden" name="keyword" value="${param.keyword }">
		<input type="submit" value="수정"><input type="reset" value="초기화">
	</form>
</body>
</html>