package com.jeo.web.comp.controller;

import com.jeo.constructionType.domain.ConstructionType;
import com.jeo.constructionType.service.ConstructionTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class CompController {
	@Autowired
	ConstructionTypeService constructionTypeService;

	@GetMapping(value = "/comp")
	public String compGET() {
		return "redirect:/comp/user";
	}

	@GetMapping(value = "/comp/user")
	public void compUserGET() {
	}

	@GetMapping(value = "/comp/construction-type")
	public void compConstructionTypeGET(Model model) {
		List<ConstructionType> resultList = constructionTypeService.selectConstructionTypeList();
		model.addAttribute("resultList", resultList);
	}

	@GetMapping(value = "/comp/category")
	public void compCategoryGET(Model model) {
	}
}
