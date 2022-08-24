package com.erowm.webapp.business.dao;

import com.erowm.common.dao.AbstractDao;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class BusinessDao extends AbstractDao {
	private static String namespace = "business.business";

	public <T> T businessVO(Map<String, Object> map) {
		return selectOne(namespace + ".businessVO", map);
	}

	public <T> List<T> businessPage(Map<String, Object> map) {
		return selectList(namespace + ".businessPage", map);
	}

	public <T> List<T> businessList(Map<String, Object> map) {
		return selectList(namespace + ".businessList", map);
	}

	public <T> T businessItem(Map<String, Object> map) {
		return selectOne(namespace + ".businessList", map);
	}

	public int businessRegist(Map<String, Object> map) {
		return insert(namespace + ".businessRegist", map);
	}

	public int businessModify(Map<String, Object> map) {
		return update(namespace + ".businessModify", map);
	}
}
