package com.kh.common;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.oreilly.servlet.multipart.FileRenamePolicy;

public class MyFileRenamePolicy implements FileRenamePolicy {

	
	// 기존의 파일(원본 파일)을 전달 받아서 수정명 작업을 다 마친 수정된 파일 반환해주는 메소드
	@Override
	public File rename(File originFile) {
		// 	원본명			-->				수정명
		// "aaa.jpg"		-->		"20201023194810XXXXXX.jpg"	
		
		//원본 파일명
		String originName = originFile.getName();	// "aaa.jpg"
		
		// 수정명 : 파일 업로드한 시간(년월일시분초) + 5자리의 랜덤값(10000~99999) + "원본파일명에서 뽑은 확장자"
		
		// 1. 파일 업로드한 시간 (String currentTime)
		SimpleDateFormat sdf = new SimpleDateFormat("YYYYMMddHHmmss");
		String currentTime = sdf.format(new Date()); // "202010232007"
		
		// 2. 5자리 랜덤값 (int ranNum)
		int ranNom = (int)(Math.random()*90000 + 10000) ;
		
		
		// 3. 원본 파일명에서 확장자 뽑기 (String ext)
		
		int dot = originName.lastIndexOf(".");
		
		String ext = originName.substring(dot);		// ".jpg"
		
		String fileName = currentTime + ranNom + ext;
		
		
		// 전달받은 원본파일(originFile)을 수정된 파일명 (fileName)으로 파일객체 생성해서 리턴
		
		
		
		return new File(originFile.getParent(), fileName) ;
	}
	
	

}
