package com.jeo.category.service;

import com.jeo.category.dao.CategoryDao;
import com.jeo.category.domain.Category;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryService {
	@Autowired
	CategoryDao categoryDao;

	public List<Category> selectCategoryList() {
		return categoryDao.selectCategoryList();
	}

	public int insertCategory(Category category) {
		return categoryDao.insertCategory(category);
	}
}
