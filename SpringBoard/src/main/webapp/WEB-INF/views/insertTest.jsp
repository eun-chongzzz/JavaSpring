<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<h2>Ajax 댓글 등록 테스트</h2>
	
	<div>
		<div>
			댓글 글쓴이 <input type="text" name="replyer" id="newReplyWriter">
		</div>
		<div>
			댓글 내애용 <input type="text" name="reply" id="newReplyText">
		</div>
		<button id="replyAddBtn">댓글 작성</button>
	</div>
	
	
	<!-- jquery cdn -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	
	<script type="text/javascript">
		var bno = 196636;
		
		$('#replyAddBtn').on("click",function(){
			
			// 폼이 없기때문에, input태그 내에 입력된 요소를 가져와야 합니다.
			// 버튼을 누르는 시점에, 글쓴이와 내용 내부에 적힌 문자열을 변수에 저장합니다.
			var replyer = $("#newReplyWriter").val();
			var reply = $("#newReplyText").val();
			
			// $.ajax({내용물}); 이 기본형태
			$.ajax({
				type : 'post',
				url : '/replies',
				headers:{
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				dataType : 'text',
				data : JSON.stringify({
					bno : bno,
					replyer : replyer,
					reply : reply
				}),
				success : function(result){
					if(result == 'SUCCESS'){
						alert("등록 되었습니다.");
					}
				}
			});
		});
	
	</script>
	
</body>
</html>