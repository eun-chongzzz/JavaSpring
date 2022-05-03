<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<h1>게시글</h1>
	 	<table class="table table-bordered border-info">
			<tr>
				<th>글 번호</th>
				<th>글 제목</th>
				<th>글쓴이</th>
				<th>쓴날짜</th>
				<th>최종수정날짜</th>
			</tr>
			<c:forEach var="board" items="${boardList }">
				<tr>
					<td>${board.bno}</td>
					<td><a href ="/board/boardDetail/${board.bno }?pageNum=${pageMaker.cri.pageNum }&searchType=${pageMaker.cri.searchType}&keyword=${pageMaker.cri.keyword}">${board.title}[ ${board.replyCount} ]</a></td>
					<td>${board.writer}</td>
					<td>${board.regdate}</td>
					<td>${board.updatedate}</td>
				</tr>
			</c:forEach>
		</table>
		<a href="/board/boardInsert" class="btn btn-info">글쓰기</a><br>
		${pageMaker }
		<!-- 버튼 -->
		<ul class="pagination justify-content-center">
			<!-- 이전버튼 -->
			<c:if test="${pageMaker.prev }">
		    	<li class="page-item">
			      <a class="page-link" href="/board/boardList?pageNum=${pageMaker.startPage -1}&searchType=${pageMaker.cri.searchType}&keyword=${pageMaker.cri.keyword}">
			      	&laquo;
			      </a>
		    	</li>
	    	</c:if>
	    	
	    	<!-- 밑에 깔아줄 버튼들 -->
	    	<c:forEach var="idx" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
			    <li class="page-item ${pageMaker.cri.pageNum eq idx ? 'active' : ''}">
			    	<a class="page-link" href="/board/boardList?pageNum=${idx}&searchType=${pageMaker.cri.searchType}&keyword=${pageMaker.cri.keyword}">
			    		${idx}
			    	</a>
			    </li>
			</c:forEach>
			
			<!-- 다음버튼 -->
		    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
			    <li class="page-item">
			      <a class="page-link" href="/board/boardList?pageNum=${pageMaker.endPage + 1}&searchType=${pageMaker.cri.searchType}&keyword=${pageMaker.cri.keyword}">
			        &raquo;
			      </a>
			    </li>
		    </c:if>
	  	</ul>
	  	<div class="row">	  	
			<!-- 검색창 -->
		  	<form action="/board/boardList" method="get">
		  		<!-- select태그를 이용해 클릭시 검색조건을 선택할수 있도록 처리합니다. -->
		  		<select name="searchType">
		  			<!-- 검색조건을 option태그를 이용해 만듭니다. -->
		  			<option value="n">-</option>
		  			<option value="t" ${pageMaker.cri.searchType eq 't' ? 'selected' : ''}>제목</option>
		  			<option value="c" ${pageMaker.cri.searchType eq 'c' ? 'selected' : ''}>본문</option>
		  			<option value="w" ${pageMaker.cri.searchType eq 'w' ? 'selected' : ''}>글쓴이</option>
		  			<option value="tc" ${pageMaker.cri.searchType eq 'tc' ? 'selected' : ''}>제목+본문</option>
		  			<option value="cw" ${pageMaker.cri.searchType eq 'cw' ? 'selected' : ''}>본문+글쓴이</option>
		  			<option value="tcw" ${pageMaker.cri.searchType eq 'tcw' ? 'selected' : ''}>제목+본문+글쓴이</option>
		  		</select>
		  		<input type="text" name="keyword" placeholder="검색어" value="${pageMaker.cri.keyword }">
		  		<input type="submit" value="Search">
		  	</form>
	  	</div>
	</div>
</body>
</html>