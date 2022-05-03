<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<meta charset="UTF-8">
<!-- 번들 cdn -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<!-- modal css -->
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
				<a href="/board/boardList?pageNum=${param.pageNum == null ? 1 : param.pageNum }&searchType=${param.searchType}&keyword=${param.keyword}" class="btn btn-info btn-sm">목록</a>
			</div>
			<div class="col-md-1">
				<form action="/board/boardDelete" method="post">
					<input type="hidden" name="bno" value="${board.bno }">
					<input type="hidden" name="pageNum" value="${param.pageNum }">
					<input type="hidden" name="searchType" value="${param.searchType }">
					<input type="hidden" name="keyword" value="${param.keyword }">
					<input type="submit" value="삭제" class="btn btn-danger btn-sm">
				</form>
			</div>
			<div class="col-md-1">
				<form action="/board/boardUpdateForm" method="post">
					<input type="hidden" name="bno" value="${board.bno }">
					<input type="hidden" name="pageNum" value="${param.pageNum }">
					<input type="hidden" name="searchType" value="${param.searchType }">
					<input type="hidden" name="keyword" value="${param.keyword }">
					<input type="submit" value="수정" class="btn btn-warning btn-sm">
				</form>
			</div>
		</div>
	
	
		<div class="row box-box-success">
			<div class="box-header">
				<h2 class="text-primary">댓글작성</h2>
			</div><!-- header -->
			<div class="box-body">
				<strong>Writer : </strong>
				<input type="text" id="newReplyWriter" placeholder="글쓴이" class="from-control">
				<strong>ReplyText : </strong>
				<input type="text" id="newReplyText" placeholder="댓글내용" class="from-control">
			</div><!-- body -->
			<div class="box-footer">
				<button type="button" class= "btn btn-success" id="replyAddBtn">댓글 추가</button>
			</div><!-- footer -->
		</div><!-- row -->
		
			<!-- 댓글추가공간 -->
			<ul id="replies">
				<!-- 비어있는 ul -->
			</ul>
		</div>	<!-- container -->
	
	
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
	
	<!-- 여기부터 댓글 비동기 처리 자바스크립트 처리 영역 -->
	<script type="text/javascript">
		var bno = ${board.bno};
		
		// 전체 댓글 가져오기
		function getAllList(){
			
			$.getJSON("/replies/all/" + bno, function(data){
		
				var str= "";
				
				$(data).each(function(){
					// 날짜 처리를 위해 자바스크립트의 Date 객체를 사용합니다.
					let timestamp = this.updateDate; // 유닉스 시간
					let date = new Date(timestamp);
					
					let formattedTime2 = date.toUTCString(date);
					
					let formattedTime = "게시일 : " + date.getFullYear() // 유닉스시간 년도 환산
										+ "년" + (date.getMonth()+1) // 컴퓨터는 월은 0부터 시작하기 때문에
										+ "월" + date.getDate() + "일" // 몇일
										// 시 분 초 추가
										+ "-" + date.getHours()
										+ ":" + date.getMinutes()
										+ ":" + date.getSeconds();
				
					str += "<div class='replyLi' data-rno='" + this.rno + "'><strong>@"
						+ this.replyer + "</strong> - " + formattedTime + "<br>"
						+ "<div class='reply'>" + this.reply + "</div>"
						+ "<button type='button' class='btn btn-info'>수정/삭제</button>"
						+ "</div>";
					});
				$("#replies").html(str);
			});
		}
		getAllList();
		
		// 댓글 추가
		$('#replyAddBtn').on("click",function(){
			
			var replyer = $("#newReplyWriter").val();
			var reply = $("#newReplyText").val();
			
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
			
			var replytag = $(this).parent();
			
			// 형제 태그 .reply의 내용을 대신 가져올수있도록
			// 변수 replyContent에 선언해 거기에 저장해주세요. 
			// (hint : .siblings("요소명"); 으로 형제태그를 가져올수있습니다
			//var replyContent = $(this).prev().text();// button의 직전 태그인 .reply의 내용물 가져오기
			var replyContent = $(this).siblings(".reply").text(); // button의 형제 중 .reply의 내용물 가져오기
			//var replyContent = $(this).parent().children(".reply").text(); 
			
			var rno = replytag.attr("data-rno");
			var reply = replytag.text();
		
			$(".modal-title").html(rno); // modal-title 부분에 글번호 입력 
			$("#reply").val(replyContent);  // reply 영역에 리플내용을 기입(수정삭제)
			$("#modDiv").show("slow"); // modal 열림
		});
		
		// 모달창 닫기
		$("#closeBtn").on("click",function(){ // #close버튼 클릭시
			$("#modDiv").hide("slow"); //#modDiv를 닫습니다.
		});
		
		// 삭제
		$("#replyDelBtn").on("click", function(){
			var rno = $(".modal-title").html();
			$.ajax({
				type : 'delete',
				url : '/replies/' + rno,
				header : {
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
			var reply = $("#reply").val();
			
			$.ajax({
				type : 'patch', 
				url : '/replies/' + rno,
				header : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "PATCH" 
				},
				contentType : "application/json",
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