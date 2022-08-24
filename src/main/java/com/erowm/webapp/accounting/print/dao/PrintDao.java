package com.erowm.webapp.accounting.print.dao;

import com.erowm.common.dao.AbstractDao;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class PrintDao extends AbstractDao {
	private static String namespace = "accounting.print";

	/* 현금출납장 */
	public <T> List<T> transactionList(Map<String, Object> map) {
		return selectList(namespace + ".transactionList", map);
	}

	/* 결의서 */
	public <T> List<T> voucher(Map<String, Object> map) {
		return selectList(namespace + ".voucher", map);
	}

	/* 예산서 */
	public <T> List<T> budget(Map<String, Object> map) {
		return selectList(namespace + ".budget", map);
	}
}
