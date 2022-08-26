package com.jeo.web.facility.controller;

import com.jeo.facility.domain.Facility;
import com.jeo.facility.service.FacilityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class FacilityController {
	@Autowired
	FacilityService facilityService;

	@GetMapping(value = "/facility/equipment/list")
	public void facilityGET(Model model) {
		List<Facility> resultList = facilityService.selectFacilityList();
		model.addAttribute("resultList", resultList);
	}
}
