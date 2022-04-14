package com.ict.service;

import java.util.List;

import com.ict.domain.BoardVO;
import com.ict.domain.SearchCriteria;

// 구현 클래스 BoardServiceImpl의 뼈대가 됩니다.
public interface BoardService {

	// 인터페이스 내에 먼저 메서드를 선언하고, impl 클래스에서 구현합니다
	public List<BoardVO> getList(SearchCriteria cri); 
	
	// 그나마 쉽게 하는 방법 : BoardMapper.java에 있는거 복붙
	public int countPageNum(SearchCriteria cri);
	
	// 글 하나만 가져오는 로직
	public BoardVO select(long bno);
	
	// 글 삽입 로직
	public void insert(BoardVO vo);
	
	// 글 삭제 로직
	public void delete(long bno);
	
	// 글 수정 로직
	public void update(BoardVO vo);
}
