package com.ict.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ict.domain.AttachFileDTO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j // pom.xml에서 junit 4.12로, log4j는 1.2.17버전, exclusions 태그 삭제, scope 주석
public class UploadController {
	
	
	// 썸네일인지 아닌지를 알려면 이미지파일인지 아닌지에 대한 판단
	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			
			return contentType.startsWith("image");
		}catch(IOException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		
		String str = sdf.format(date);
		
		return str.replace("-", File.separator);
	}
	
	
	@GetMapping("/uploadForm")
	public void uploadForm() {
		log.info("upload form");
	}
	
	
	
	//■■■■■ Form ■■■■■//
	@PostMapping(value="/uploadFormAction",
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody // .jsp대신 json데이터를 리턴하게 하고 싶다면 @ResponseBody를 사용
	public ResponseEntity<List<AttachFileDTO>> uploadFormPost(MultipartFile[] uploadFile) {
		
		// 그림파일의 정보 AttachFileDTO를 업로드된 파일 개수만큼 중첩해 저장
		// AttachFileDTO는 파일 한 개의 정보를 저장합니다.
		// 현재 파일 업로드는 여러 파일을 동시에 업로드하므로 List<AttachFileDTO>를 받도록 처리합니다.
		List<AttachFileDTO> list = new ArrayList<>();
		
		// 저장경로
		String uploadFolder = "C:\\upload_data\\temp"; 
		
		// 오늘 날짜 폴더와 파일 정보를 가져옴
		String uploadFolderPath = getFolder(); 
		
		// 폴더 생성
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		log.info("upload Path: " + uploadPath);
		
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}

		for(MultipartFile multipartFile : uploadFile) {
		/*	log.info("----------------");
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("---------------- : " + multipartFile.getSize()); */
			
			// 파일정보를 저장할 DTO 생성
			AttachFileDTO attachDTO = new AttachFileDTO();
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			uploadFileName = uploadFileName.substring(uploadFileName.indexOf("\\") + 1);
			
			log.info("only file name : " + uploadFileName);
			
			// 상단에 만든 DTO에 파일이름 저장
			attachDTO.setFileName(uploadFileName);
			
			// uuid 발급 부분
			UUID uuid = UUID.randomUUID();
			
			uploadFileName = uuid.toString() + "_" + uploadFileName;
		
			//File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());
			
			
			try {
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);
				
				// uuid와 저장할 폴더 경로를 setter로 입력받기
				attachDTO.setUuid(uuid.toString());
				attachDTO.setUploadPath(uploadFolderPath);				
				
				// 이 아래부터 썸네일 생성로직
				if(checkImageType(saveFile)) {
					
					attachDTO.setImage(true);
					
					FileOutputStream thumbnail = 
							new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
			
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
					
					thumbnail.close();
				}
				// ArrayList에 개별 DTO를 집어넣어줘야 출력됨
				list.add(attachDTO);
			}catch(Exception e) {
				log.error(e.getMessage());
			}
			
		}//end for
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	
	
	
	
	//■■■■■ Ajax ■■■■■//
	@GetMapping("uploadAjax")
	public void uploadAjax() {
		
		log.info("upload ajax");
	}
	
	
	
	@PostMapping(value="/uploadAjaxAction",
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody // .jsp대신 json데이터를 리턴하게 하고 싶다면 @ResponseBody를 사용
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		
		// log.info("ajax post update!");
		
		List<AttachFileDTO> list = new ArrayList<>();
		
		// 어떤 폴더에 저장할것인지 위치지정
		String uploadFolder = "C:\\upload_data\\temp";
		
		// 오늘 날짜 폴더와 파일 정보를 가져옴
		String uploadFolderPath = getFolder(); 
		
		// 폴더 생성
		File uploadPath = new File(uploadFolder, getFolder());
		log.info("upload Path: " + uploadPath);
		
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		for(MultipartFile multipartFile : uploadFile) {
			
			log.info("----------------");
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload file size : " + multipartFile.getSize());
			
			// 개별 파일에 대한 DTO생성
			AttachFileDTO attachDTO = new AttachFileDTO();
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			// 파일 경로가 이상하게 들어오는것을 대비해서 넣어 놓은 로직
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			
			log.info("last file name : " + uploadFileName);
			
			// uploadFileName에 의해 파일이름을 얻어왔으면 파일명을 attachDTO에 집어넣음
			attachDTO.setFileName(uploadFileName);
			
			//uuid 발급 부분
			UUID uuid = UUID.randomUUID();
			
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			//File saveFile = new File(uploadFolder, uploadFileName);
			
			
			try {
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);
				
				// uuid와 저장할 폴더 경로를 setter로 입력받기
				attachDTO.setUuid(uuid.toString());
				attachDTO.setUploadPath(uploadFolderPath);	
				
				// 이 아래부터 썸네일 생성로직
				if(checkImageType(saveFile)) {
					
					attachDTO.setImage(true);
					
					FileOutputStream thumbnail = 
							new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
			
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
					thumbnail.close();
				}
				// ArrayList에 개별 DTO를 집어넣어줘야 출력됨
				list.add(attachDTO);
			}catch(Exception e) {
				log.error(e.getMessage());
			}
		}// end for
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	
	//■■■■■ Thumbnail ■■■■■//
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		
		log.info("fileName: " + fileName);
		
		// 1. 파일 생성
		File file = new File("c:\\upload_data\\temp\\" + fileName);
		
		log.info("file: " + file);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			// 2. json대신 파일을 줘야하는데 http방식 통신이므로 헤더를 생성
			HttpHeaders header = new HttpHeaders();
			// 3. 컨텐츠 타입이 json이 아닌 파일임을 헤더에 명시
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			// 4. ResponseEntity에 파일을 포함시켜서 전달
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file),
											header, HttpStatus.OK);
		}catch(IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
	
	//■■■■■ Download ■■■■■//
	@GetMapping(value="/download",
			produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(String fileName){
		
		log.info("download file : " + fileName);
		
		Resource resource = new FileSystemResource("C:\\upload_data\\temp\\" + fileName);
		
		log.info("resource : " + resource);
		
		String resourceName = resource.getFilename();
		
		HttpHeaders headers = new HttpHeaders();
		
		try {
			headers.add("Content-Disposition", "attachment; filename=" + 
							new String(resourceName.getBytes("UTF-8"),"ISO-8859-1"));
			
		}catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
		
	}
	
	//■■■■■ Delete ■■■■■//
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type){
			
			log.info("delete file : " + fileName);
			
			File file = null;
			
			try {
				file = new File("C:\\upload_data\\temp\\" + URLDecoder.decode(fileName,"UTF-8"));
				
				file.delete();
				
				if(type.equals("image")) {
					
					String largeFileName = file.getAbsolutePath().replace("s_", "");
					
					log.info("largeFileName : " + largeFileName);
					
					file = new File(largeFileName);
					
					file.delete();
				}
			}catch(UnsupportedEncodingException e) {
				e.printStackTrace();
				return new ResponseEntity<>(HttpStatus.NOT_FOUND);
			}
			return new ResponseEntity<String>("deleted", HttpStatus.OK);
		}	
	
	
	
	
	
}
