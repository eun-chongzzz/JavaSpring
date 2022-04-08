package com.ict.persistance;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ict.domain.BoardVO;
import com.ict.mapper.BoardMapper;


import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {
	
	@Autowired
	private BoardMapper boardMapper;
	
	//@Test
	public void testGetList() {
		log.info(boardMapper.getList());
	}
	
	//@Test
	public void testInsert() {
		// 글 입력을 위해서 BoardVO 타입을 매개로 사용함
		// 따라서 BoardVO를 만들어놓고
		// setter로 글제목, 글본문, 글쓴이 만 저장해둔 채로
		// mapper.insert(vo);를 호출해서 실행여부를 확인해면 됩니다.
		// 위 설명을 토대로 아래 vo에 6번글에 대한 제목 본문 글쓴이를 넣고
		// 호출해주신 다음 실제로 DB에 글이 들어갔는지 확인
		BoardVO vo = new BoardVO();
		
		//log.info("채워넣기 전 :" + vo);
		
		// 입력할 글에 대한 제목, 글쓴이, 본문을 vo에 넣어줍니다.
		vo.setTitle("새로넣는글");
		vo.setContent("새로넣는본문");
		vo.setWriter("새로넣는글쓴이");
		
		//log.info("채워넣은 후 :" + vo);
		boardMapper.insert(vo);
	}
	
	//@Test
	public void getSelect() {
		// 가져오기
		BoardVO vo = boardMapper.select(5);
		// 로그찍기
		log.info(vo);
	}
	
	// delete 메서드에 대한 테스트 코드 작성 후 
	// 삭제여부를 sqldeveloper나 상단의 testGetList()로 확인해보세요.
	//@Test
	public void testDelete() {
		boardMapper.delete(27);
	}
	
	// update 메서드에 대한 테스트 코드를 작성해주신 다음
	// 수정여부를 testGetList()로 확인해보세요.
	@Test
	public void testUpdate() {
		BoardVO board = new BoardVO();
		log.info("전달 데이터 아직 입력 안된 vo : " + board);
		
		board.setTitle("테스트1");
		board.setContent("테스트1");
		board.setBno(1);
		
		log.info("전달 데이터가 입력된 vo : " + board);
		
		boardMapper.update(board);

	}
	
	//@Test
		public void testUpdate2() {
			boardMapper.update2("up2로 바꾼 제목","up2로 바꾼본문",2);
	}

}