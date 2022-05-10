<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>admin 주소</h1>
	<h2>다양한 페이지 정보</h2>
	
	<p>principal : <sec:authentication property="principal"/></p>
	<p>MemberVO : <sec:authentication property="principal.member"/></p>
	<p>사용자 이름 : <sec:authentication property="principal.member.userName"/></p>
	<p>사용자 아이디 : <sec:authentication property="principal.member.userId"/></p>
	<p>사용자 권한 목록 : <sec:authentication property="principal.member.authList"/></p>
		
	<hr>
	<a href="/customLogout">로그아웃페이지 이동</a>
</body>
</html>