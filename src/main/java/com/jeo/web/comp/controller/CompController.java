package com.jeo.web.comp.controller;

import com.jeo.category.domain.Category;
import com.jeo.category.service.CategoryService;
import com.jeo.common.config.Define;
import com.jeo.common.domain.HMap;
import com.jeo.constructionType.domain.ConstructionType;
import com.jeo.constructionType.service.ConstructionTypeService;
import com.jeo.webapp.admin.system.code.service.CodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class CompController {
	@Autowired
	ConstructionTypeService constructionTypeService;

	@Autowired
	CategoryService categoryService;

	@Autowired
	CodeService codeService;

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
		List<Category> resultList = categoryService.selectCategoryList();
		model.addAttribute("resultList", resultList);
	}

	@GetMapping(value = "/comp/position")
	public void compPositionGET(HMap hmap, Model model) {
		hmap.put(Define.CODE_ID, Define.USER_POSITION);
		model.addAttribute("resultList", codeService.codeDetailList(hmap));
	}
}
