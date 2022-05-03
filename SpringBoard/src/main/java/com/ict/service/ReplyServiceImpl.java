package com.ict.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ict.domain.ReplyVO;
import com.ict.mapper.BoardMapper;
import com.ict.mapper.ReplyMapper;

@Service
public class ReplyServiceImpl implements ReplyService{
	
	// 서비스가 매퍼를 호출하므로 매퍼를 위해 선언해야합니다.
	@Autowired
	private ReplyMapper replyMapper;
	
	// 댓글쓰기시 Board_tbl 쪽에도 관여해야 하므로 board테이블을 수정하는 Mapper를 추가선언합니다.
	@Autowired
	private BoardMapper boardMapper; 
	
	@Override
	public List<ReplyVO> listReply(Long bno) {
		return replyMapper.getList(bno);
	}
	
	@Transactional // 2개 이상의 DB접근 구문이 사용되면 트랜잭션 적용
	@Override
	public void addReply(ReplyVO vo) {
		replyMapper.create(vo);	
		// 댓글번호는 ReplyVO에 들어있으므로 getter를 활용
		boardMapper.updateReplyCount(vo.getBno(), 1);
	}

	@Override
	public void modifyReply(ReplyVO vo) {
		replyMapper.update(vo);
	}
	
	@Transactional
	@Override
	public void removeReply(Long rno) {
		Long bno = replyMapper.getBno(rno); // 1. 삭제한 댓글의 글번호 얻기
		replyMapper.delete(rno); // 2. 댓글삭제
		// DB에서 커밋안하면 pending 상태로 계속 지연되니 주의
		boardMapper.updateReplyCount(bno, -1);// 3. 그 글번호에서 댓글갯수 줄이기
	}
	

}
