package com.aza.myapp.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aza.myapp.domain.PhotoVO;
import com.aza.myapp.handler.PhotoHandler;
import com.aza.myapp.service.PhotoService;
import com.aza.myapp.service.ProfileService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/photo/*")
@Controller
public class PhotoController {
	
	@Inject
	private PhotoService psv;
	@Inject
	private PhotoHandler pth;
	
	private int isOk;
	int isSaved = 0;
	
	// 글 등록 중 사용하는 파일 임시 저장 메서드
	@PostMapping(value="tmpRegister", consumes="multipart/form-data", produces = {MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<List<PhotoVO>> tmpRegisterPost(@RequestParam(name="files", required = false) MultipartFile[] files,
			@RequestParam("type") String type) {
		List<PhotoVO> pList = new ArrayList<PhotoVO>(); // 사진을 담을 리스트
		log.info("tmpRegister");
		if(files[0].getSize()>0) { // 파일이 선택되었을 때만 실행
			pList = pth.tmpUploadPhotos(files); // 파일을 PhotoVO 형태의 리스트로 변환
			for(PhotoVO pvo : pList) pvo.setType(type);
		}
		log.info(pList.get(0).toString());
		isOk = 1;
		return isOk>0? new ResponseEntity<List<PhotoVO>>(pList,HttpStatus.OK)
				: new ResponseEntity<List<PhotoVO>>(pList,HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 글 등록 시 파일 등록 메서드
	@PostMapping(value="register", consumes="application/json", produces = {MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<List<PhotoVO>> registerPost(@RequestBody HashMap<String, List<PhotoVO>> pList) {
		log.info("Photo register pList >>> "+pList.toString());
		isOk = 1;
		pList.forEach((k, v) -> {
			if(v.size() > 0) {
				v = pth.uploadPhotos(v, k);
				for (PhotoVO pvo : v) {
					pvo.setPost_no(psv.selectLastNo(pvo));
					log.info("post_no"+pvo.getPost_no());
					isOk *= psv.insert(pvo);
					log.info("등록 결과 >> "+isOk);
				}
			}else log.info("파일이 없습니다.");
		});
		return isOk>0? new ResponseEntity<List<PhotoVO>>(HttpStatus.OK)
				: new ResponseEntity<List<PhotoVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 글 수정 시 파일 수정, 등록 메서드
	@PutMapping(value="update{no}", consumes="application/json", produces = {MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<String> updatePut(@RequestBody HashMap<String, HashMap<String, List<PhotoVO>>> combindList,
			@PathVariable("no") int post_no){
		log.info("Photo update pList >>> "+combindList.toString());
		HashMap<String, List<PhotoVO>> pList = combindList.get("pListObj");
		HashMap<String, List<PhotoVO>> savedPList = combindList.get("savedPListObj");
		HashMap<String, List<PhotoVO>> deletePList = new HashMap<>(); // pList에서 지울 파일 리스트
		isOk = 1;
		savedPList.forEach((sk, sv) -> {
			for (PhotoVO spvo : sv) {
				log.info("spvo > "+spvo.toString());
				isSaved = 0;
				pList.forEach((k, v) -> {
					for (PhotoVO pvo : v) {
						if (spvo.getUuid().equals(pvo.getUuid())) {
							isSaved = 1;
							// 기존에 저장되어있던 파일은 삭제할 리스트에 추가
							if(!deletePList.containsKey(k)) { // 해당 key가 없는 경우
								deletePList.put(k, new ArrayList<PhotoVO>());
							}
							deletePList.get(k).add(pvo);
						}
					}
				});
				// 기존 파일을 수정 중 삭제했다면 해당 원본 파일 및 DB 삭제
				if (isSaved == 0) {
					log.info("사진파일 삭제");
					// DB 삭제
					isOk = psv.delete(spvo);
					// 사진 객체 원본, 썸네일 가져오기
					File file = new File(spvo.getSave_dir()+"/"+spvo.getUuid()+"_"+spvo.getFile_name());
					File fileTh = new File(spvo.getSave_dir()+"/"+spvo.getUuid()+"_th_"+spvo.getFile_name());
					// 파일이 있다면 삭제
					if(file.exists()) file.delete();
					if(fileTh.exists()) fileTh.delete();
				}else {
					log.info("파일 삭제 안함");
				}
			}
		});
		// 기존에 있던 파일을 추가할 리스트에서 제거
		deletePList.forEach((k, v) -> {
			for (PhotoVO pvo : v) {pList.get(k).remove(pvo);}
		});
		
		// 새로 등록되는 파일 저장
		pList.forEach((k, v) -> {
			if(v.size() > 0) {
				v = pth.uploadPhotos(v, k);
				for (PhotoVO pvo : v) {
					pvo.setPost_no(post_no);
					log.info("photo update insert >> "+pvo.toString());
					isOk *= psv.insert(pvo);
				}
			}else log.info("파일이 없습니다.");
		});
		
		return isOk>0? new ResponseEntity<String>(HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@DeleteMapping(value="deleteFile", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> deleteFileDelete(@RequestBody PhotoVO pvo){
		log.info("pvo >> "+pvo.toString());
		// 사진 객체 원본, 썸네일 가져오기
		File file = new File("C:\\_aza\\fileUpload\\_tmp\\"+pvo.getUuid()+"_"+pvo.getFile_name());
		File fileTh = new File("C:\\_aza\\fileUpload\\_tmp\\"+pvo.getUuid()+"_th_"+pvo.getFile_name());
		// 파일이 있다면 삭제
		if(file.exists()) file.delete();
		if(fileTh.exists()) fileTh.delete();
		
		return new ResponseEntity<String>(HttpStatus.OK);
	}
	
	@GetMapping("delete")
	public String deleteGet(RedirectAttributes reAttr, @RequestParam("list") String list,
			@RequestParam("type") String type,
			@RequestParam("no") int no) {
		log.info("photo delete");
		PhotoVO pvo = new PhotoVO();
		pvo.setPost_no(no);
		pvo.setType(type);
		List<PhotoVO> pList = psv.getList(pvo);
		for (PhotoVO tmpPvo : pList) {
			log.info("파일 삭제 중");
			log.info(tmpPvo.getSave_dir()+"/"+tmpPvo.getUuid()+"_"+tmpPvo.getFile_name());
			log.info(tmpPvo.getSave_dir()+"/"+tmpPvo.getUuid()+"_th_"+tmpPvo.getFile_name());
			// 사진 객체 원본, 썸네일 가져오기
			File file = new File(tmpPvo.getSave_dir()+"/"+tmpPvo.getUuid()+"_"+tmpPvo.getFile_name());
			File fileTh = new File(tmpPvo.getSave_dir()+"/"+tmpPvo.getUuid()+"_th_"+tmpPvo.getFile_name());
			// 파일이 있다면 삭제
			if(file.exists()) file.delete();
			if(fileTh.exists()) fileTh.delete();
		}
		
		return list;
	}

}
