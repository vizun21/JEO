package com.jeo.webapp.accounting.parent.dao;

import com.jeo.common.dao.AbstractDao;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class ParentDao extends AbstractDao {
	private static String namespace = "accounting.parent";

	public <T> List<T> parentList(Map<String, Object> map) {
		return selectList(namespace + ".parentList", map);
	}

	public int parentRegist(Map<String, Object> map) {
		return insert(namespace + ".parentRegist", map);
	}

	public int parentModify(Map<String, Object> map) {
		return update(namespace + ".parentModify", map);
	}

	public int parentDelete(Map<String, Object> map) {
		return delete(namespace + ".parentDelete", map);
	}
}
