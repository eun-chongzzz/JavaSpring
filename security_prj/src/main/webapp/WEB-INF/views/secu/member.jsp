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
	<h1>member 주소</h1>
	
	<!-- ROLE_ADMIN 권한이 없다면 안보임 -->
	<sec:authorize access="hasAnyRole('ROLE_ADMIN')">
		<a href="/secu/admin">관리자페이지</a>
	</sec:authorize>
</body>
</html>