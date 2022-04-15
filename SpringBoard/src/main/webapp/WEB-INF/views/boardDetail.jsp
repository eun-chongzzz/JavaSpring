<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<h1 class="text text-info">${board.bno }번 글 상세페이지</h1>
		<div class="row">
			<div class="col-md-1">글제목</div>
			<div class="col-md-5">
				<input type="text" class="form-control" value="${board.title }" readonly>
			</div>
			<div class="col-md-1">글쓴이</div>
			<div class="col-md-5">
				<input type="text" class="form-control" value="${board.writer }" readonly>
			</div>
		</div>
			<textarea class="form-control" rows="10" readonly>${board.content }</textarea>
		<div class="row">
			<div class="col-md-3">쓴날짜 : </div>
			<div class="col-md-3">${board.regdate }</div>
			<div class="col-md-3">수정날짜 : </div>
			<div class="col-md-3">${board.updatedate }</div>
		</div>
		<div class="row">
			<div class="col-md-1">
				<a href="/boardList?pageNum=${param.pageNum == null ? 1 : param.pageNum }&searchType=${param.searchType}&keyword=${param.keyword}" class="btn btn-info btn-sm">목록</a>
			</div>
			<div class="col-md-1">
				<form action="/boardDelete" method="post">
					<input type="hidden" name="bno" value="${board.bno }">
					<input type="hidden" name="pageNum" value="${param.pageNum }">
					<input type="hidden" name="searchType" value="${param.searchType }">
					<input type="hidden" name="keyword" value="${param.keyword }">
					<input type="submit" value="삭제" class="btn btn-danger btn-sm">
				</form>
			</div>
			<div class="col-md-1">
				<form action="/boardUpdateForm" method="post">
					<input type="hidden" name="bno" value="${board.bno }">
					<input type="hidden" name="pageNum" value="${param.pageNum }">
					<input type="hidden" name="searchType" value="${param.searchType }">
					<input type="hidden" name="keyword" value="${param.keyword }">
					<input type="submit" value="수정" class="btn btn-warning btn-sm">
				</form>
			</div>
		</div>
	</div>
	
</body>
</html>