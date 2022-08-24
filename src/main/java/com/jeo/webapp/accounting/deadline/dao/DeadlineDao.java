package com.jeo.webapp.accounting.deadline.dao;

import com.jeo.common.dao.AbstractDao;
import org.springframework.stereotype.Repository;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

@Repository
public class DeadlineDao extends AbstractDao {
	private static String namespace = "accounting.deadline";

	public <T> List<T> deadlinePage(Map<String, Object> map) {
		return selectList(namespace + ".deadlinePage", map);
	}

	public <T> List<T> deadlineList(Map<String, Object> map) {
		return selectList(namespace + ".deadlineList", map);
	}

	public BigInteger deadlineBalance(Map<String, Object> map) {
		return selectOne(namespace + ".deadlineBalance", map);
	}

	public int deadlineRegist(Map<String, Object> map) {
		return insert(namespace + ".deadlineRegist", map);
	}

	public <T> T deadlineItem(Map<String, Object> map) {
		return selectOne(namespace + ".deadlineList", map);
	}

	public int deadlineDelete(Map<String, Object> map) {
		return delete(namespace + ".deadlineDelete", map);
	}

}
