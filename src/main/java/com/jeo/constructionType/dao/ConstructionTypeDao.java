package com.jeo.constructionType.dao;

import com.jeo.common.dao.AbstractDao;
import com.jeo.constructionType.domain.ConstructionType;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ConstructionTypeDao extends AbstractDao {
	private static String namespace = "construction.type";

	public int insertConstructionType(ConstructionType constructionType) {
		return insert(namespace + ".insert", constructionType);
	}

	public List<ConstructionType> selectConstructionTypeList() {
		return selectList(namespace + ".select");
	}
}
