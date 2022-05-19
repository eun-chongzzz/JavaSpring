package com.ict.mapper;

import java.util.List;

import com.ict.domain.BoardAttachVO;


public interface BoardAttachMapper {
	
	public void insert(BoardAttachVO vo);
	
	public void delete(String uuid);
	
	// 조회중인 글의 그림정보만 가져오는 findByBno를 선언
	public List<BoardAttachVO> findByBno(Long bno);
 }
