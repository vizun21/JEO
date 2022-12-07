package com.jeo.web.print.controller;

import com.jeo.facility.dto.FacilityPageCondition;
import com.jeo.facility.dto.RepairPageCondition;
import com.jeo.facility.service.FacilityService;
import com.jeo.facility.service.SubFacilityService;
import com.jeo.repair.service.RepairService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class PrintHtmlController {

	@Autowired
	FacilityService facilityService;

	@Autowired
	SubFacilityService subFacilityService;

	@Autowired
	RepairService repairService;

	@GetMapping(value = "/print/html/equipment-list")
	public void printEquipmentListGET(Model model, @ModelAttribute FacilityPageCondition condition) {
		model.addAttribute("facilities", facilityService.selectFacilityList(condition));
	}

	@GetMapping(value = "/print/html/equipment-card/{facility_tag_no}")
	public String printEquipmentCardGET(Model model, @PathVariable("facility_tag_no") String facility_tag_no) {
		model.addAttribute("facility", facilityService.selectFacility(facility_tag_no));
		model.addAttribute("subFacilities", subFacilityService.selectSubFacilityList(facility_tag_no));
		return "/print/html/equipment-card";
	}

	@GetMapping(value = "/print/html/repair-list")
	public void printRepairListGET(Model model, @ModelAttribute RepairPageCondition condition) {
		model.addAttribute("facility", facilityService.selectFacility(condition.getFacility_tag_no()));
		model.addAttribute("repairs", repairService.selectRepairList(condition));
	}

}
