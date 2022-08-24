package com.jeo.webapp.accounting.tran.dao;

import com.jeo.common.dao.AbstractDao;
import org.springframework.stereotype.Repository;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

@Repository
public class BankTranDao extends AbstractDao {
	private static String namespace = "accounting.bank.tran";

	public <T> List<T> bankTranPage(Map<String, Object> map) {
		return selectList(namespace + ".bankTranPage", map);
	}

	public <T> T bankTranItem(Map<String, Object> map) {
		return selectOne(namespace + ".bankTranList", map);
	}

	public BigInteger bankTranBalance(Map<String, Object> map) {
		return selectOne(namespace + ".bankTranBalance", map);
	}

	public BigInteger bankTranCount(Map<String, Object> map) {
		return selectOne(namespace + ".bankTranCount", map);
	}
}
