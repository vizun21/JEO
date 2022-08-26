package com.jeo.category.controller;

import com.jeo.category.domain.Category;
import com.jeo.category.service.CategoryService;
import com.jeo.common.config.Define;
import com.jeo.common.domain.HMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class CategoryController {
	@Autowired
	CategoryService categoryService;

	@PostMapping("/category")
	public String categoryPOST(HMap hmap, Category category) {
		category.setCategory_mod_user(hmap.getString(Define.USER_ID));
		categoryService.insertCategory(category);
		return "redirect:/comp/category";
	}
}
