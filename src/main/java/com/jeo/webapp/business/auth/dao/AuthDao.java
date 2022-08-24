package com.jeo.webapp.business.auth.dao;

import com.jeo.common.dao.AbstractDao;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class AuthDao extends AbstractDao {
	private static String namespace = "business.auth";

	public <T> List<T> authUserList(Map<String, Object> map) {
		return selectList(namespace + ".authUserList", map);
	}

	public <T> List<T> unauthUserList(Map<String, Object> map) {
		return selectList(namespace + ".unauthUserList", map);
	}

	public int authRegist(Map<String, Object> map) {
		return insert(namespace + ".authRegist", map);
	}

	public int authDelete(Map<String, Object> map) {
		return delete(namespace + ".authDelete", map);
	}
}
