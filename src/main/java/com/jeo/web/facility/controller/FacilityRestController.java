package com.jeo.web.facility.controller;

import com.jeo.common.config.Define;
import com.jeo.common.domain.HMap;
import com.jeo.facility.domain.Facility;
import com.jeo.facility.service.FacilityService;
import com.jeo.webapp.upload.image.service.UploadImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@Controller
public class FacilityRestController {
	@Autowired
	FacilityService facilityService;

	@Autowired
	UploadImageService uploadImageService;

	@PostMapping("/facility/equipment")
	public String insert(HMap hmap, MultipartFile facility_image, Facility facility) throws IOException {
		facility.setFacility_mod_user(hmap.getString(Define.USER_ID));
		if (facility_image.getSize() != 0) {
			facility.setFacility_image_path(uploadImageService.fileUpload(facility_image));
		}
		facilityService.insert(facility);

		return "redirect:/facility/equipment/list";
	}
}
