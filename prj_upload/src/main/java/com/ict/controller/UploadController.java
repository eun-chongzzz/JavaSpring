package com.ict.controller;

import java.io.File;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j // pom.xml에서 junit 4.12로, log4j는 1.2.17버전, exclusions 태그 삭제, scope 주석
public class UploadController {
	
	@GetMapping("/uploadForm")
	public void uploadForm() {
		log.info("upload form");
	}
	
	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) {
		
		String uploadFolder = "C:\\upload_data\\temp";
		
		for(MultipartFile multipartFile : uploadFile) {
			log.info("----------------");
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("---------------- : " + multipartFile.getSize());
			
			File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());
			
			try {
				multipartFile.transferTo(saveFile);
			}catch(Exception e) {
				log.error(e.getMessage());
			}
			
		}//end for
	}
	
	/////////Ajax/////////
	@GetMapping("uploadAjax")
	public void uploadAjax() {
		
		log.info("upload ajax");
	}
	
	@PostMapping("/uploadAjaxAction")
	public void uploadAjaxPost(MultipartFile[] uploadFile) {
		
		log.info("ajax post update!");
		
		String uploadFolder = "C:\\upload_data\\temp";
		
		for(MultipartFile multipartFile : uploadFile) {
			
			log.info("----------------");
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload file size : " + multipartFile.getSize());
		
			String uploadFileName = multipartFile.getOriginalFilename();
			
			// 파일 경로가 이상하게 들어오는것을 대비해서 넣어 놓은 로직
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			
			log.info("last file name : " + uploadFileName);
			
			File saveFile = new File(uploadFolder, uploadFileName);
			
			try {
				multipartFile.transferTo(saveFile);
			}catch(Exception e) {
				log.error(e.getMessage());
			}
		}// end for
		
	}
}
