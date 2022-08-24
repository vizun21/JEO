package com.erowm.webapp.admin.system.bank.dao;

import com.erowm.common.dao.AbstractDao;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class BankDao extends AbstractDao {
	private static String namespace = "system.bank";

	public <T> List<T> bankPage(Map<String, Object> map) {
		return selectList(namespace + ".bankPage", map);
	}

	public <T> List<T> bankList(Map<String, Object> map) {
		return selectList(namespace + ".bankList", map);
	}

	public <T> T bankItem(Map<String, Object> map) {
		return selectOne(namespace + ".bankList", map);
	}

	public <T> List<T> overlapCheck(Map<String, Object> map) {
		return selectList(namespace + ".bankList", map);
	}

	public int bankRegist(Map<String, Object> map) {
		return insert(namespace + ".bankRegist", map);
	}

	public int bankModify(Map<String, Object> map) {
		return update(namespace + ".bankModify", map);
	}
}
