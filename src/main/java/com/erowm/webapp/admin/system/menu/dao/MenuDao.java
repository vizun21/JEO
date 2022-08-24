package com.erowm.webapp.admin.system.menu.dao;

import com.erowm.common.dao.AbstractDao;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class MenuDao extends AbstractDao {
	private static String namespace = "system.menu";

	public <T> T menuItem(Map<String, Object> map) {
		return selectOne(namespace + ".menuList", map);
	}

	public int menuSort(Map<String, Object> map) {
		return update(namespace + ".menuSort", map);
	}

	public int menuRegist(Map<String, Object> map) {
		return insert(namespace + ".menuRegist", map);
	}

	public int menuDelete(Map<String, Object> map) {
		return delete(namespace + ".menuDelete", map);
	}

	public <T> List<T> menuList(Map<String, Object> map) {
		return selectList(namespace + ".menuList", map);
	}

	public <T> List<T> menuTree(Map<String, Object> map) {
		return selectList(namespace + ".menuTree", map);
	}

	public <T> List<T> breadcrumb(Map<String, Object> map) {
		return selectList(namespace + ".breadcrumb", map);
	}

	public <T> List<T> rootMenuList(Map<String, Object> map) {
		return selectList(namespace + ".rootMenuList", map);
	}

	public <T> List<T> notAddRootMenuList(Map<String, Object> map) {
		return selectList(namespace + ".notAddRootMenuList", map);
	}
}
