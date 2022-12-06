package com.jeo.web.facility.controller;

import com.jeo.category.domain.Category;
import com.jeo.category.service.CategoryService;
import com.jeo.constructionType.domain.ConstructionType;
import com.jeo.constructionType.service.ConstructionTypeService;
import com.jeo.facility.domain.Facility;
import com.jeo.facility.domain.SubFacility;
import com.jeo.facility.service.FacilityService;
import com.jeo.facility.service.SubFacilityService;
import com.jeo.repair.domain.Repair;
import com.jeo.repair.service.RepairService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@Controller
public class FacilityController {
	@Autowired
	FacilityService facilityService;
	@Autowired
	SubFacilityService subFacilityService;

	@Autowired
	ConstructionTypeService constructionTypeService;

	@Autowired
	CategoryService categoryService;

	@Autowired
	RepairService repairService;

	@GetMapping(value = "/facility/equipment/list")
	public void facilityGET(Model model) {
		List<Facility> resultList = facilityService.selectFacilityList();
		model.addAttribute("resultList", resultList);
	}

	@GetMapping(value = "/facility/equipment")
	public void facilityEquipmentGET(Model model) {
		List<ConstructionType> constructionTypes = constructionTypeService.selectConstructionTypeList();
		model.addAttribute("constructionTypes", constructionTypes);
		List<Category> categories = categoryService.selectCategoryList();
		model.addAttribute("categories", categories);
	}

	@GetMapping(value = "/facility/equipment/{facility_tag_no}")
	public String facilityEquipmentGET(Model model, @PathVariable("facility_tag_no") String facility_tag_no) {
		List<ConstructionType> constructionTypes = constructionTypeService.selectConstructionTypeList();
		model.addAttribute("constructionTypes", constructionTypes);
		List<Category> categories = categoryService.selectCategoryList();
		model.addAttribute("categories", categories);

		Facility facility = facilityService.selectFacility(facility_tag_no);
		model.addAttribute("facility", facility);

		List<SubFacility> subFacilities = subFacilityService.selectSubFacilityList(facility_tag_no);
		model.addAttribute("subFacilities", subFacilities);

		return "/facility/equipment";
	}

	@GetMapping(value = "/facility/repair")
	public void facilityRepairGET(Model model) {
	}

	@GetMapping(value = "/facility/repairList/{facility_tag_no}")
	public ResponseEntity<List<Repair>> facilityRepairListByTagNoGET(Model model, @PathVariable("facility_tag_no") String facility_tag_no) {
		ResponseEntity<List<Repair>> entity;

		try {
			List<Repair> repairList = repairService.facilityRepairListByTagNo(facility_tag_no);

			entity = new ResponseEntity<>(repairList, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@GetMapping(value = "/facility-list/equipment")
	public void facilityEquipmentListGET(Model model) {
		List<ConstructionType> constructionTypes = constructionTypeService.selectConstructionTypeList();
		model.addAttribute("constructionTypes", constructionTypes);
		List<Category> categories = categoryService.selectCategoryList();
		model.addAttribute("categories", categories);
	}

}
