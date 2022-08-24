package com.jeo.webapp.upload.image.service;

import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

@Service
public class UploadImageService {
	@Resource(name = "resourceUploadImgPath")
	private String resourceUploadImgPath;

	/**
	 * @param file
	 * @return fileName
	 * @throws IOException
	 */
	public String fileUpload(MultipartFile file) throws IOException {
		UUID uid = UUID.randomUUID();

		String newFileName = uid + "_" + file.getOriginalFilename();

		// uploadPath 폴더생성
		File uploadPath = new File(resourceUploadImgPath);
		if (!uploadPath.exists()) uploadPath.mkdirs();

		// 파일저장
		File target = new File(resourceUploadImgPath, newFileName);
		FileCopyUtils.copy(file.getBytes(), target);

		return newFileName;
	}
}
