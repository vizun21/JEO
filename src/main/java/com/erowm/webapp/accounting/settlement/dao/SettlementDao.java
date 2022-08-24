package com.erowm.webapp.accounting.settlement.dao;

import com.erowm.common.dao.AbstractDao;
import com.erowm.webapp.print.dto.SettlementAmountSearchCondition;
import org.springframework.stereotype.Repository;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

@Repository
public class SettlementDao extends AbstractDao {
	private static String namespace = "accounting.settlement";

	public <T> List<T> settlementPage(Map<String, Object> map) {
		return selectList(namespace + ".settlementPage", map);
	}

	public BigInteger getSettlementAmount(SettlementAmountSearchCondition searchCondition) {
		return selectOne(namespace + ".getSettlementAmount", searchCondition);
	}
}
