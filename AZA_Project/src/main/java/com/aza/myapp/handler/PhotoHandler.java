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

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnails;

@Slf4j
@Component
@AllArgsConstructor
public class PhotoHandler {
	// 사진 저장 경로
	private final String UP_DIR = "C:\\_aza\\fileUpload";
	
	// 글 등록 시 사용하는 임시 저장 메서드
	public List<PhotoVO> tmpUploadPhotos(MultipartFile[] files){
		File folders = new File(UP_DIR, "/_tmp");
		
		// 폴더가 없으면 생성, 있으면 생성x
		if(!folders.exists()) {
			folders.mkdirs();
		}
		
		List<PhotoVO> pList = new ArrayList<PhotoVO>();
		for(MultipartFile file : files) {
			PhotoVO pvo = new PhotoVO();
			pvo.setSave_dir("/upload/_tmp");  // 경로
			pvo.setFile_size(file.getSize());  // 파일 용량
			
			String originalFileName = file.getOriginalFilename();  // 경로 포함 파일명
			log.info("original fileName : "+originalFileName);
			String onlyFileName = originalFileName.substring(originalFileName.lastIndexOf("\\")+1);  // 경로 제외 파일명
			log.info("only fileName : "+originalFileName);
			
			pvo.setFile_name(onlyFileName);  // 파일 이름 설정
			
			UUID uuid = UUID.randomUUID();
			pvo.setUuid(uuid.toString());  // uuid 설정
			
			// 디스크에 저장할 파일 객체 생성
			String fullFileName = uuid.toString()+"_"+onlyFileName;
			File tmpStoreFile = new File(folders, fullFileName);
			
			try {
				file.transferTo(tmpStoreFile);
				File thumbnail = new File(folders, uuid.toString()+"_th_"+onlyFileName);
				Thumbnails.of(tmpStoreFile).size(180, 180).toFile(thumbnail);
			} catch (Exception e) {
				log.info("File 생성 오류");
				e.printStackTrace();
			}
			pList.add(pvo);
		}
		
		return pList;
	}
	
	// 글 등록 시 사용할 실제 저장 메서드
	public List<PhotoVO> uploadPhotos(List<PhotoVO> rawPList, String index){
		index = index + "_";
		
		LocalDate date = LocalDate.now();
		log.info("date : "+date);
		String today = date.toString();
		today = today.replace("-", File.separator);
		
		File folders = new File(UP_DIR, today);
		
		// 폴더가 없으면 생성, 있으면 생성x
		if(!folders.exists()) {
			folders.mkdirs();
		}
		
		List<PhotoVO> pList = new ArrayList<PhotoVO>();
		
		for(PhotoVO pvo : rawPList) {
			pvo.setSave_dir("/upload/"+today);  // 경로
			
			try {
				for(int i=0; i<2; i++) {
					String tmpConnector = i==0? "_" : "_th_";
					String connector = i==0? "_"+index : "_th_"+index;
					String tmpFullFileName = pvo.getUuid()+tmpConnector+pvo.getFile_name();
					String fullFileName = pvo.getUuid()+connector+pvo.getFile_name();
					// 임시 저장 폴더에서 날짜 폴더로 파일 이동
					File tmpFile = new File("C:\\_aza\\fileUpload/_tmp/"+tmpFullFileName);
					File storeFile = new File(folders+"/"+fullFileName);
					log.info("tmp >>> C:\\_aza\\fileUpload/_tmp/"+tmpFullFileName);
					log.info("full >>> "+folders+"/"+fullFileName);
					tmpFile.renameTo(storeFile);
				}
				// file_name에 index를 포함시켜 저장
				pvo.setFile_name(index+pvo.getFile_name());
			} catch (Exception e) {
				log.info("File 이동 오류");
				e.printStackTrace();
			}
			pList.add(pvo);
		}
		
		return pList;
	}

	// 글 수정 시 _tmp 폴더에 임시 파일 만들어주는 메서드
	public List<PhotoVO> saveTmp(List<PhotoVO> rawPList) {
		log.info("PhotoHandler saveTmp");
		File folders = new File(UP_DIR, "/_tmp");

		List<PhotoVO> pList = new ArrayList<PhotoVO>();
		
		for(PhotoVO pvo : rawPList) {
			
			try {
				for(int i=0; i<2; i++) {
					String connector = i==0? "_" : "_th_";
					String savedFullFileName = pvo.getUuid()+connector+pvo.getFile_name();
					String fullFileName = 
							pvo.getUuid()+connector+pvo.getFile_name().substring(pvo.getFile_name().indexOf("_")+1);
					// 임시 저장 폴더에서 날짜 폴더로 파일 이동
					// 날짜 폴더에서 임시 저장 폴더로 파일 복사
					File savedFile = new File(pvo.getSave_dir().replace("/upload/", UP_DIR+"/"), savedFullFileName);
					File tmpStoreFile = new File(folders, fullFileName);
					
					log.info("saved >>> "+pvo.getSave_dir()+savedFullFileName);
					log.info("tmp >>> "+folders+"/"+fullFileName);
					
					Files.copy(savedFile.toPath(), tmpStoreFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
					
				}
			} catch (Exception e) {
				log.info("File 복사 오류");
				e.printStackTrace();
			}
			pList.add(pvo);
		}
		return pList;
	}

}
