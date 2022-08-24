package com.jeo.webapp.comp.dao;

import com.jeo.common.dao.AbstractDao;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class CompDao extends AbstractDao {
	private static String namespace = "comp.comp";

	public int compRegist(Map<String, Object> map) {
		return insert(namespace + ".compRegist", map);
	}

	public <T> List<T> compList(Map<String, Object> map) {
		return selectList(namespace + ".compList", map);
	}

	public <T> T compItem(Map<String, Object> map) {
		return selectOne(namespace + ".compList", map);
	}

	public int compModify(Map<String, Object> map) {
		return update(namespace + ".compModify", map);
	}

	public int compApproval(Map<String, Object> map) {
		return update(namespace + ".compApproval", map);
	}

	public int compDelete(Map<String, Object> map) {
		return delete(namespace + ".compDelete", map);
	}
}
