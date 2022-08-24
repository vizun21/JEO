package com.jeo.webapp.accounting.trial.balance.service;

import com.jeo.common.domain.HMap;
import com.jeo.common.util.SessionDateUtils;
import com.jeo.webapp.accounting.trial.balance.dao.TrialBalanceDao;
import com.jeo.webapp.print.dto.TrialBalanceSearchCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TrialBalanceService {
	@Autowired TrialBalanceDao trialBalanceDao;

	public <T> List<T> trialBalanceTotal(HMap hmap) {
		SessionDateUtils.setSessionInfo(hmap);
		return trialBalanceDao.trialBalanceTotal(hmap.getMap());
	}

	public <T> List<T> trialBalanceAnnual(HMap hmap) {
		return trialBalanceDao.trialBalanceAnnual(hmap.getMap());
	}

	public <T> List<T> trialBalanceAnnual(TrialBalanceSearchCondition searchCondition) {
		return trialBalanceDao.trialBalanceAnnual(searchCondition);
	}
}
