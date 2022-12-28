package com.jeo.facility.controller;

import com.jeo.common.config.Define;
import com.jeo.common.domain.HMap;
import com.jeo.common.util.CommonUtils;
import com.jeo.facility.domain.Facility;
import com.jeo.facility.domain.SubFacility;
import com.jeo.facility.domain.SubFacilityList;
import com.jeo.facility.dto.FacilityPageCondition;
import com.jeo.facility.dto.RepairPageCondition;
import com.jeo.facility.service.FacilityService;
import com.jeo.facility.service.SubFacilityService;
import com.jeo.repair.domain.Repair;
import com.jeo.repair.service.RepairService;
import com.jeo.webapp.upload.image.service.UploadImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Map;

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

	@PostMapping(value = "/facilities")
	public ResponseEntity<List<Facility>> facilitiesPOST(@ModelAttribute FacilityPageCondition condition) {
		ResponseEntity<List<Facility>> entity;

		try {
			List<Facility> facilities = facilityService.selectFacilityList(condition);
			entity = new ResponseEntity<>(facilities, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}

		return entity;
	}

	@PostMapping("/facility/equipment")
	public String insert(HMap hmap, MultipartFile facility_image, Facility facility, SubFacilityList subFacilityList) throws IOException {
		facility.setFacility_mod_user(hmap.getString(Define.USER_ID));

		/* 이미지 업로드 및 업로드 경로받아오기 */
		if (facility_image.getSize() != 0) {
			facility.setFacility_image_path(uploadImageService.fileUpload(facility_image));
		}

		/* 설비등록 */
		facilityService.insert(facility);

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

	@PostMapping("/facility/equipment/modify")
	public String update(HMap hmap, MultipartFile facility_image, Facility facility, SubFacilityList subFacilityList) throws IOException {

		Facility origin = facilityService.selectFacility(facility.getFacility_tag_no());

		facility.setFacility_mod_user(hmap.getString(Define.USER_ID));

		/* 이미지 업로드 및 업로드 경로받아오기 */
		if (facility_image.getSize() != 0) {
			facility.setFacility_image_path(uploadImageService.fileUpload(facility_image));
		} else {
			facility.setFacility_image_path(origin.getFacility_image_path());
		}

		/* 설비정보 업데이트 */
		facilityService.update(facility);

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

	@RequestMapping(value = "/facility/equipment/overlapCheck", method = RequestMethod.POST)
	public ResponseEntity<Boolean> overlapCheckPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<Boolean> entity = null;
		try {
			hmap.set(map);

			Facility facility = facilityService.selectFacility(hmap.getString("facility_tag_no"));
			boolean overlap = facility != null;

			entity = new ResponseEntity<>(overlap, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
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
	public String insertRepair(Repair repair) {
		repairService.insert(repair);

		return "redirect:/facility/repair?facility_tag_no=" + repair.getFacility_tag_no();
	}

	@PostMapping(value = "/facility-list/equipment/page")
	public ResponseEntity<List<Facility>> facilityListEquipmentPageGET(@ModelAttribute FacilityPageCondition condition) {
		ResponseEntity<List<Facility>> entity;

		try {
			List<Facility> repairList = facilityService.selectFacilityList(condition);

			entity = new ResponseEntity<>(repairList, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@PostMapping(value = "/facility-list/repair/page")
	public ResponseEntity<List<Repair>> facilityListRepairPageGET(@ModelAttribute RepairPageCondition condition) {
		ResponseEntity<List<Repair>> entity;

		try {
			List<Repair> repairList = repairService.selectRepairList(condition);

			entity = new ResponseEntity<>(repairList, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
