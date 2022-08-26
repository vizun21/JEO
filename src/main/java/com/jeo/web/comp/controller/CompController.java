package com.jeo.web.comp.controller;

import com.jeo.webapp.comp.service.CompService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CompController {
	@Autowired
	CompService compService;

	@GetMapping(value = "/comp")
	public String compGET() {
		return "redirect:/comp/user";
	}

	@GetMapping(value = "/comp/user")
	public void compUserGET() {
	}

	@GetMapping(value = "/comp/construction-type")
	public void compConstructionTypeGET() {
	}
}
