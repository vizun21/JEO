package com.jeo.webapp.accounting.child.dao;

import com.jeo.common.dao.AbstractDao;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class ChildDao extends AbstractDao {
	private static String namespace = "accounting.child";

	public <T> List<T> childPage(Map<String, Object> map) {
		return selectList(namespace + ".childPage", map);
	}

	public <T> T childItem(Map<String, Object> map) {
		return selectOne(namespace + ".childList", map);
	}

	public int childRegist(Map<String, Object> map) {
		return insert(namespace + ".childRegist", map);
	}

	public int childModify(Map<String, Object> map) {
		return update(namespace + ".childModify", map);
	}
}
