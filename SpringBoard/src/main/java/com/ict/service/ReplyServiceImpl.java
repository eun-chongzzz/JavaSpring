package com.ict.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.ict.domain.ReplyVO;
import com.ict.mapper.ReplyMapper;

public class ReplyServiceImpl implements ReplyService{
	
	// 서비스가 매퍼를 호출하므로 매퍼를 위해 선언해야합니다.
	@Autowired
	private ReplyMapper replyMapper;
	
	@Override
	public List<ReplyVO> listReply(Long bno) {
		return replyMapper.getList(bno);
	}

	@Override
	public void addReply(ReplyVO vo) {
		replyMapper.create(vo);	
	}

	@Override
	public void modifyReply(ReplyVO vo) {
		replyMapper.update(vo);
	}

	@Override
	public void removeReply(Long rno) {
		replyMapper.delete(rno);
	}
	

}
