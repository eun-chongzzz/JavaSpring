package com.ict.mapper;

import java.util.List;

import com.ict.domain.ReplyVO;

public interface ReplyMapper {
	
	// 특정 게시판 bno번 글의 전체 댓글 목록 가져오기
	// bno번 글에 대한 정보가 있어야함.
	public List<ReplyVO> getList(Long bno);
	
	public void create(ReplyVO vo);
	
	public void update(ReplyVO vo);
	
	// 댓글 삭제시는 단일 댓글 하나만 삭제해야 하므로 댓글번호를 받는다.
	public void delete(Long rno);
	
	// rno만으로 bno를 유추해야하기 때문에 getBno선언
	public Long getBno(Long rno);
	
	// bno번글에 달린 댓글을 다 삭제하는 쿼리문 생성
	public void replyAllDelete(Long bno);
}
