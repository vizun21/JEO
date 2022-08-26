package com.jeo.web.facility.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class FacilityController {
	@GetMapping(value = "/facility/equipment/list")
	public void facilityGET() {
	}
}
