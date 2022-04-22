<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<ul id="replies">
	
	</ul>
	<button id="requestBtn">
		댓글보기
	</button>
	
	<!-- jquery cdn -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	
	<!-- script태그에 requestBtn에 대한 onclick 이벤트를 걸어주세요.
	onclick시 $getJSON을 이용해 댓글 데이터를 요청한다음(글번호는 test.jsp에 설정해둔 글번호를 그대로 쓰세요)
	얻어온 데이터를 이용해 #replies 내부에 댓글을 집어넣도록 해주세요. -->
	<script type="text/javascript">
		var bno = 196636;
		
		// onClick이 걸려있으므로, 실행 조건은 클릭시 실행
		$("#requestBtn").on("click",function(){
			// #replies 사이에 들어갈 태그를 저장하는 변수
			var str = "";
			
			// #requestBtn 클릭시
			$.getJSON("/replies/all/" + bno, function(data){
				// 댓글 집어넣어주는 로직 실행
				console.log(data); // 디버깅(해당 글번호의 댓글 정보)
				
				$(data).each(function(){
					// str에 적절하게 댓글형식으로 문자열을 추가
					str += "<li data-rno='" + this.rno + "' class='replyLi'>"
					+ this.rno + ":" + this.reply + "</li>";
					
					console.log(str); // 디버깅(돌아갈때마다 str이 어떻게 찍히는지)
					console.log("---------------");
				});
				// #replies에 댓글 끼워넣기.
				$("#replies").html(str);
			});
		});
	</script>
</body>
</html>