package com.jeo.webapp.accounting.tran.dao;

import com.jeo.common.dao.AbstractDao;
import org.springframework.stereotype.Repository;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

@Repository
public class TranDao extends AbstractDao {
	private static String namespace = "accounting.tran";

	public <T> List<T> tranPage(Map<String, Object> map) {
		return selectList(namespace + ".tranPage", map);
	}

	public <T> List<T> tranList(Map<String, Object> map) {
		return selectList(namespace + ".tranList", map);
	}

	public int tranRegist(Map<String, Object> map) {
		return insert(namespace + ".tranRegist", map);
	}

	public int tranModify(Map<String, Object> map) {
		return update(namespace + ".tranModify", map);
	}

	public int tranDelete(Map<String, Object> map) {
		return delete(namespace + ".tranDelete", map);
	}

	public int tranBktrSetNull(Map<String, Object> map) {
		return update(namespace + ".tranBktrSetNull", map);
	}

	public <T> T tranItem(Map<String, Object> map) {
		return selectOne(namespace + ".tranList", map);
	}

	public BigInteger tranAmount(Map<String, Object> map) {
		return selectOne(namespace + ".tranAmount", map);
	}

	public <T> List<T> tranDuplicateList(Map<String, Object> map) {
		return selectList(namespace + ".tranDuplicateList", map);
	}

	public <T> List<T> ghmReportList(Map<String, Object> map) {
		return selectList(namespace + ".ghmReportList", map);
	}
}
