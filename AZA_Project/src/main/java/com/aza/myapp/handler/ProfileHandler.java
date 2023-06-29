package com.aza.myapp.handler;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.aza.myapp.domain.PhotoVO;
import com.aza.myapp.domain.ProfileVO;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnails;

@Slf4j
@Component
@AllArgsConstructor
public class ProfileHandler {
	// 사진 저장 경로
	private final String UP_DIR = "C:\\_aza\\fileUpload";
	
	// 프로필사진 저장 메서드
	public ProfileVO uploadProfile(MultipartFile[] files, String member_id){
		File folders = new File(UP_DIR, "/_profile");
		
		// 폴더가 없으면 생성, 있으면 생성x
		if(!folders.exists()) {
			folders.mkdirs();
		}
		
		MultipartFile file = files[0];
		
		UUID uuid = UUID.randomUUID();

		String save_dir = "/upload/_profile";
		
		// 파일명 추출
		String originalFileName = file.getOriginalFilename();  // 경로 포함 파일명
		String fileName = originalFileName.substring(originalFileName.lastIndexOf("/")+1);  // 경로 제외 파일명
		
		long fileSize = file.getSize();
		
		ProfileVO profile = new ProfileVO(uuid.toString(), member_id, save_dir, fileName, fileSize);
		
		// 디스크에 저장할 파일명
		String saveFileName = uuid.toString() + "_" + fileName;
		File saveFile = new File(folders, saveFileName);
		
		try {
			file.transferTo(saveFile);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return profile;
	}

	public void deleteProfile(ProfileVO exstPfvo) {
		// TODO Auto-generated method stub
		
	}

}