package com.jeo.web.facility.controller;

import com.jeo.common.config.Define;
import com.jeo.common.domain.HMap;
import com.jeo.common.util.CommonUtils;
import com.jeo.facility.domain.Facility;
import com.jeo.facility.domain.SubFacility;
import com.jeo.facility.domain.SubFacilityList;
import com.jeo.facility.service.FacilityService;
import com.jeo.facility.service.SubFacilityService;
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
	SubFacilityService subFacilityService;

	@Autowired
	UploadImageService uploadImageService;

	@PostMapping("/facility/equipment")
	public String insert(HMap hmap, MultipartFile facility_image, Facility facility, SubFacilityList subFacilityList) throws IOException {
		facility.setFacility_mod_user(hmap.getString(Define.USER_ID));

		/* 이미지 업로드 및 업로드 경로받아오기 */
		if (facility_image.getSize() != 0) {
			facility.setFacility_image_path(uploadImageService.fileUpload(facility_image));
		}

		/* 설비등록 */
		if (CommonUtils.isEmpty(facility.getFacility_tag_no())) {
			facilityService.insert(facility);
		} else {
			facilityService.update(facility);
		}

		/* 기타설비 및 부속설비 등록 */
		if (subFacilityList.getSubFacilities() != null) {
			for (SubFacility subFacility : subFacilityList.getSubFacilities()) {
				subFacility.setFacility_tag_no(facility.getFacility_tag_no());

				if (CommonUtils.isEmpty(subFacility.getSub_facility_no())) {
					subFacilityService.insert(subFacility);
				} else {
					subFacilityService.update(subFacility);
				}
			}
		}

		return "redirect:/facility/equipment/list";
	}
}
