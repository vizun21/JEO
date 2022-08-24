package com.jeo.webapp.accounting.smok.dao;

import com.jeo.common.dao.AbstractDao;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class SmokDao extends AbstractDao {
	private static String namespace = "accounting.smok";

	public <T> List<T> smokPage(Map<String, Object> map) {
		return selectList(namespace + ".smokPage", map);
	}

	public <T> List<T> smokList(Map<String, Object> map) {
		return selectList(namespace + ".smokList", map);
	}

	public int smokRegist(Map<String, Object> map) {
		return insert(namespace + ".smokRegist", map);
	}

	public <T> T smokItem(Map<String, Object> map) {
		return selectOne(namespace + ".smokList", map);
	}

	public int smokModify(Map<String, Object> map) {
		return update(namespace + ".smokModify", map);
	}

	public int smokDelete(Map<String, Object> map) {
		return delete(namespace + ".smokDelete", map);
	}
}
