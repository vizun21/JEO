package com.erowm.webapp.admin.system.page.dao;

import com.erowm.common.dao.AbstractDao;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class PageDao extends AbstractDao {
	private static String namespace = "system.page";

	public <T> List<T> pageList(Map<String, Object> map) {
		return selectList(namespace + ".pageList", map);
	}

	public <T> T pageItem(Map<String, Object> map) {
		return selectOne(namespace + ".pageList", map);
	}

	public int pageRegist(Map<String, Object> map) {
		return insert(namespace + ".pageRegist", map);
	}

	public int pageModify(Map<String, Object> map) {
		return update(namespace + ".pageModify", map);
	}

	public int pageDelete(Map<String, Object> map) {
		return delete(namespace + ".pageDelete", map);
	}
}
