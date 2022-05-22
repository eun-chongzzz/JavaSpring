<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- 아임포트 모4듈 -->
<script src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" type="text/javascript"></script>
<!-- 제이쿼리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>품질좋은 상품목록</h1>

<div class="itemSection">
	<div class="itemCard">
		<div class="itemTitle">
			<h2>헬창을 위한 근육보충제</h2>
		</div>
		<div class="itemContent">
			<h2>맛없지만 단백질 보충이 됩니다.</h2>
		</div>
		<div class="itemPrice">
			<p data-price="4000">4000원</p>
		</div>
		<div class="itemButton">
			<button class="orderBtn">주문하기</button>
		</div>
	</div>
	
	<div class="itemCard">
		<div class="itemTitle">
			<h2>개발자를 위한 키보드</h2>
		</div>
		<div class="itemContent">
			<h2>타건감이 죽여주는 키보드</h2>
		</div>
		<div class="itemPrice">
			<p data-price="2000">2000원</p>
		</div>
		<div class="itemButton">
			<button class="orderBtn">주문하기</button>
		</div>
	</div>
</div>



<script type="text/javascript">
	// 미리 받아와야할 정보를 변수에 전역변수처름 쓰기위해 선언
	var itemPrice = 0;
	var itemTitle = "";
	var merchant_uid = "";
	
	// 위임처리로 어떤 상품을 클릭했을 때 그 상품에 대한
	$(".itemSection").on("click",".orderBtn",function(){
		itemPrice = $(this).parent().siblings(".itemPrice").children().attr("data-price");
		itemTitle = $(this).parent().siblings(".itemTitle").children().text();
		d = new Date();
		merchant_uid = "order" + d.getTime();
		iamport();
	});


function iamport(){
	IMP.init('imp28027601'); //iamport 대신 자신의 "가맹점 식별코드"를 사용하시면 됩니다
	IMP.request_pay({
		pg : 'html5_inicis',
		pay_method : 'card',
		merchant_uid : merchant_uid,
		name : itemTitle,
		amount : itemPrice,
		buyer_email : 'iamport@siot.do',
		buyer_name : '구매자',
		buyer_tel : '010-1234-5678',
		buyer_addr : '서울특별시 강남구 삼성동',
		buyer_postcode : '123-456'
	}, function(rsp) {
		if ( rsp.success ) {
			$.ajax({
				type:'post',
				url:'/order',
				headers:{
					"Content-Type":"application/json",
					"X-HTTP-Method-Override":"POST"
				},
				dataType:"text",
				data: JSON.stringify({
					itemname : itemTitle,
					amount:itemPrice,
					merchant_uid:merchant_uid
				}),
				success:function(){
					alert(itemTitle + "결제완료!");
				}	
			});
		} else {
			var msg = '결제에 실패하였습니다.';
			msg += '에러내용 : ' + rsp.error_msg;
		}
	});
}

</script>
</body>
</html>