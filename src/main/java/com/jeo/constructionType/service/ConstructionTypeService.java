package com.jeo.constructionType.service;

import com.jeo.constructionType.dao.ConstructionTypeDao;
import com.jeo.constructionType.domain.ConstructionType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ConstructionTypeService {
	@Autowired
	ConstructionTypeDao constructionTypeDao;

	public int insertConstructionType(ConstructionType constructionType) {
		return constructionTypeDao.insertConstructionType(constructionType);
	}

	public List<ConstructionType> selectConstructionTypeList() {
		return constructionTypeDao.selectConstructionTypeList();
	}
}
