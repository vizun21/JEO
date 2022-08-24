package com.jeo.webapp.accounting.trial.balance.dao;

import com.jeo.common.dao.AbstractDao;
import com.jeo.webapp.print.dto.TrialBalanceSearchCondition;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class TrialBalanceDao extends AbstractDao {
	private static String namespace = "accounting.trial.balance";

	public <T> List<T> trialBalanceTotal(Map<String, Object> map) {
		return selectList(namespace + ".trialBalanceTotal", map);
	}

	public <T> List<T> trialBalanceAnnual(Map<String, Object> map) {
		return selectList(namespace + ".trialBalanceAnnual", map);
	}

	public <T> List<T> trialBalanceAnnual(TrialBalanceSearchCondition searchCondition) {
		return selectList(namespace + ".trialBalanceAnnual", searchCondition);
	}
}
