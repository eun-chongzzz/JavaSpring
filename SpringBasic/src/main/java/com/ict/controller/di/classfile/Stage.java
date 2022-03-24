package com.ict.controller.di.classfile;

public class Stage {
	// 무대는 가수이 있어야 성립하며, 그때그때 다른 가수를 세울수도 있습니다.
	private Singer singer;// 가수 멤버변수
	
	public Stage(Singer singer) {
		this.singer = singer;// 무대에 설 가수를 입력해야 생성자가 호출되도록 처리
	}
	
	public void perform() {
		System.out.print("무대에서 ");
		this.singer.sing();
	}
}
