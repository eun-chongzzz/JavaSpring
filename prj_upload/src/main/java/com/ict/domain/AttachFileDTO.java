package com.ict.domain;

import lombok.Data;

@Data
public class AttachFileDTO {
	private String fileName; // 업로드한파일이름
	private String uploadPath; // 파일경로
	private String uuid; // 
	private boolean image; // 이미지 여부
}
