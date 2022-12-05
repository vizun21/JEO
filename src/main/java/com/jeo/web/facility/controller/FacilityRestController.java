package com.jeo.web.facility.controller;

import com.jeo.common.config.Define;
import com.jeo.common.domain.HMap;
import com.jeo.common.util.CommonUtils;
import com.jeo.facility.domain.Facility;
import com.jeo.facility.domain.SubFacility;
import com.jeo.facility.domain.SubFacilityList;
import com.jeo.facility.service.FacilityService;
import com.jeo.facility.service.SubFacilityService;
import com.jeo.repair.domain.Repair;
import com.jeo.repair.service.RepairService;
import com.jeo.webapp.upload.image.service.UploadImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@Controller
public class FacilityRestController {
	@Autowired
	FacilityService facilityService;

	@Autowired
	SubFacilityService subFacilityService;

	@Autowired
	UploadImageService uploadImageService;

	@Autowired
	RepairService repairService;

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

	@PostMapping(value = "/facility/equipment/{keyword}")
	public ResponseEntity<List<Facility>> findFacilitiesByKeywordInTagNoOrNamePOST(HMap hmap, @PathVariable("keyword") String keyword) {
		ResponseEntity<List<Facility>> entity;

		try {
			List<Facility> facilities = facilityService.findFacilitiesByKeywordInTagNoOrName(keyword);

			entity = new ResponseEntity<>(facilities, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}


	@PostMapping("/facility/repair")
	public String insertRepair(HMap hmap, Repair repair) {
		repairService.insert(repair);

		return "redirect:/facility/repair?facility_tag_no=" + repair.getFacility_tag_no();
	}
}
