package com.jeo.constructionType.controller;

import com.jeo.common.config.Define;
import com.jeo.common.domain.HMap;
import com.jeo.constructionType.domain.ConstructionType;
import com.jeo.constructionType.service.ConstructionTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class ConstructionTypeController {
	@Autowired
	ConstructionTypeService constructionTypeService;

	@PostMapping("/construction-type")
	public String constructionPOST(HMap hmap, ConstructionType constructionType) {
		constructionType.setConstruction_mod_user(hmap.getString(Define.USER_ID));
		constructionTypeService.insertConstructionType(constructionType);
		return "redirect:/comp/construction-type";
	}
}
