package com.erowm.webapp.common.dao;

import com.erowm.common.dao.AbstractDao;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class CommonDao extends AbstractDao {
	private static String namespace = "common.common";

	public int indexCheck(Map<String, Object> map) {
		return insert(namespace + ".indexCheck", map);
	}

//	public <T> List<T> menuList(Map<String, Object> map) {
//		return selectList(namespace + ".menuList", map);
//	}
}
