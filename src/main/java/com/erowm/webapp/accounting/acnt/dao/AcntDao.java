package com.erowm.webapp.accounting.acnt.dao;

import com.erowm.common.dao.AbstractDao;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class AcntDao extends AbstractDao {
	private static String namespace = "accounting.acnt";

	public <T> List<T> acntPage(Map<String, Object> map) {
		return selectList(namespace + ".acntPage", map);
	}

	public <T> List<T> acntList(Map<String, Object> map) {
		return selectList(namespace + ".acntList", map);
	}

	public int acntRegist(Map<String, Object> map) {
		return insert(namespace + ".acntRegist", map);
	}

	public <T> T acntItem(Map<String, Object> map) {
		return selectOne(namespace + ".acntList", map);
	}

	public int acntModify(Map<String, Object> map) {
		return update(namespace + ".acntModify", map);
	}

	public int acntDelete(Map<String, Object> map) {
		return delete(namespace + ".acntDelete", map);
	}
}
