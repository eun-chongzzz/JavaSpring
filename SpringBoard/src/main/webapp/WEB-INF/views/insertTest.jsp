<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

	<style>
		#modDiv{
		 	width : 300px;
		 	height : 100px;
		 	background-color : green;
		 	position : absolute;
		 	top : 50%;
		 	left : 50%;
		 	margin-top : -50px;	/*height의 절반(음수) 중앙위치*/
		 	margin-left : -150px; /*width의 절반(음수) 중앙위치*/
		 	padding : 10px;
		 	z-index : 1000; /*무조건 1보다 클것*/
		}
	</style>
<meta charset="UTF-8">
<!-- css cdn -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<!-- 번들 cdn -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<title>Insert title here</title>
</head>
<body>
	
	<h2>Ajax 댓글 등록 테스트</h2>
	
	<!-- 댓글작성공간 -->
	<div>
		<div>
			댓글 글쓴이 <input type="text" name="replyer" id="newReplyWriter">
		</div>
		<div>
			댓글 내애용 <input type="text" name="reply" id="newReplyText">
		</div>
		<button id="replyAddBtn">댓글 작성</button>
	</div>
	<!-- 댓글추가공간 -->
	<ul id="replies">
		<!-- 비어있는 ul -->
	</ul>
	
	<!-- modal은 일종의 팝업입니다. 
	단, 새 창을 띄우지는 않고 css를 이용해 특정 태그가 조건부로 보이거나 안 보이도록 처리해서
	마치 창이 새로 띄워지는것처럼 만듭니다.
	따라서 눈에 보이지는 않아도 modal을 구성하는 태그 자체는 화면에 미리 적혀있어야 합니다.-->
	<div id="modDiv" style="display:none;">
		<div class="modal-title"></div>
		<div>
			<input type="text" id="reply">
		</div>
		<div>
			<button type="button" id="replyModBtn">수정</button>
			<button type="button" id="replyDelBtn">삭제</button>
			<button type="button" id="closeBtn">닫기</button>
		</div>
	</div>
	
	
	<!-- jquery cdn -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	
	<script type="text/javascript">
		var bno = 196636;
		
		// 전체 댓글 가져오기
		function getAllList(){
		
			$.getJSON("/replies/all/" + bno, function(data){
		
				var str= "";
											
				$(data).each(function(){
					
					str += "<li data-rno='" + this.rno + "' class='replyLi'>"
					+ this.rno + ":" + this.reply + "<button> 수정/삭제</button></li>";
					});
				
				$("#replies").html(str);
			});
		}
		getAllList();// 댓글 전체를 들고와서 #replies에 심어주는 로직 실행
		
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
						getAllList(); // 댓글 등록 성공시, 다시 목록 갱신
						// 폼 태그 비우기.
						$("#newReplyWriter").val("");
						$("#newReplyText").val("");
					}
				}
			});
		});
	
		// 이벤트 위임
		$("#replies").on("click", ".replyLi button", function(){
			// 클릭한 요소가 this이고, 현재 button에 걸렸기 때문에
			// this는 button 입니다. button의 부모가 바로 .replyLi 입니다.
			// 즉, 클릭한 버튼과 연계된 li태그를 replytag 변수에 저장합니다.
			var replytag = $(this).parent();
			
			// 클릭한 버튼과 연계된 li태그의 data-rno에 든 값을 가져와 rno변수에 저장
			var rno = replytag.attr("data-rno");
		
			// rno뿐만 아니라 본문도 가져와야함
			var reply = replytag.text();
		
			$(".modal-title").html(rno); // modal-title 부분에 글번호 입력
			$("#reply").val(reply); // reply 영역에 리플 내용을 기입(수정/삭제)
			$("#modDiv").show("slow");// 버튼누르면 모달 열림
		});
		
		// 모달창 닫기
		$("#closeBtn").on("click",function(){ // #close버튼 클릭시
			$("#modDiv").hide("slow"); //#modDiv를 닫습니다.
		});
		
		
		// 삭제
		$("#replyDelBtn").on("click", function(){
			var rno = $(".modal-title").html();
			var reply = $("#reply").val(); // 글번호만 받기 때문에 없어도 돌아감 (생략가능)
			$.ajax({
				type : 'delete',
				url : '/replies/' + rno,
				header : {
					"Content-Type" : "application/json", // json형식으로 받는것도 아님 (생략가능)
					"X-HTTP-Method-Override" : "DELETE"
				},
				dataType : 'text',
				success : function(result){
					console.log("result : " + result);
					if(result == 'SUCCESS'){
						alert("삭제 되었습니다.");
						$("#modDiv").hide("slow");
						getAllList(); // 삭제된 댓글 반영한 새 댓글목록갱신
					}
				}
			});
		});
		
		// 수정
		$("#replyModBtn").on("click", function(){
			var rno = $(".modal-title").html();
			var reply = $("#reply").val(); // 댓글내용을 가져와서 넣어줘야 수정 가능
			
			$.ajax({
				type : 'patch', // put으로 해도 상관없음
				url : '/replies/' + rno,
				header : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "PATCH" // put으로 해도 상관없음
				},
				contentType : "application/json", // json자료를 추가로 입력받기 때문에
				data : JSON.stringify({reply:reply}),
				dataType : 'text',
				success : function(result){
					console.log("result : " + result);
					if(result == 'SUCCESS'){
						alert("수정 되었습니다.");
						$("#modDiv").hide("slow");
						getAllList();
					}
				}
			});
		});
	</script>
	
</body>
</html>