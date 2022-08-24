package com.jeo.webapp.upload.image.controller;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;

@Controller
public class UploadImageController {
	@Resource(name = "resourceUploadImgPath")
	private String resourceUploadImgPath;

	@RequestMapping(value = "/preview", method = RequestMethod.GET)
	public void previewGet(HttpServletResponse response, @RequestParam("fileName") String fileName) throws IOException {
		File image = new File(resourceUploadImgPath + File.separator + fileName);

		byte[] bytes = FileUtils.readFileToByteArray(image);
		response.setContentType(MediaType.IMAGE_PNG.toString());
		response.setContentLength(bytes.length);
		IOUtils.copy(FileUtils.openInputStream(image), response.getOutputStream());
	}
}
