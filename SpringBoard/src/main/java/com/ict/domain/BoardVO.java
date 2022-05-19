package com.ict.domain;

import java.sql.Date;
import java.util.List;

import lombok.Data;

// lombok 을 이용해 get-setter, 생성자, toString을 만들어주세요.
@Data
public class BoardVO {
	
	// board_tbl 구조에 맞게 멤버변수를 선언해주세요.
	private long bno;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	private Date updatedate;
	private int replyCount; // 댓글 표출 시 추가한 컬럼 
	
	// 이미지 정보는 글 하나에 여럿일수도 있으므로 List로 선언
	private List<BoardAttachVO>  attachList;
	
}
