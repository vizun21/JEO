package com.jeo.category.dao;

import com.jeo.category.domain.Category;
import com.jeo.common.dao.AbstractDao;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CategoryDao extends AbstractDao {
	private static String namespace = "category";

	public List<Category> selectCategoryList() {
		return selectList(namespace + ".select");
	}
}
