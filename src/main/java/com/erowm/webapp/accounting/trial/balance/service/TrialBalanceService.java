package com.erowm.webapp.accounting.trial.balance.service;

import com.erowm.common.domain.HMap;
import com.erowm.common.util.CommonUtils;
import com.erowm.common.util.SessionDateUtils;
import com.erowm.webapp.accounting.trial.balance.dao.TrialBalanceDao;
import com.erowm.webapp.print.dto.TrialBalanceSearchCondition;
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
