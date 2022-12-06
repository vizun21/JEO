package com.jeo.web.print.controller;

import com.jeo.facility.dto.FacilityPageCondition;
import com.jeo.facility.service.FacilityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

@Controller
public class PrintHtmlController {

	@Autowired
	FacilityService facilityService;

	@GetMapping(value = "/print/html/equipment-list")
	public void printEquipmentListGET(Model model, @ModelAttribute FacilityPageCondition condition) {
		model.addAttribute("facilities", facilityService.selectFacilityList(condition));
	}

}
