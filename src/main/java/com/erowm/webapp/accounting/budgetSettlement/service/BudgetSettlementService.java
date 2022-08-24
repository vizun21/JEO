package com.erowm.webapp.accounting.budgetSettlement.service;

import com.erowm.webapp.accounting.budgetSettlement.dao.BudgetSettlementDao;
import com.erowm.webapp.accounting.budgetSettlement.domain.GeneralLedger;
import com.erowm.webapp.accounting.print.dto.GeneralLedgerSearchCondition;
import com.erowm.webapp.print.dto.BudgetSettlementSearchCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BudgetSettlementService {
	@Autowired
	BudgetSettlementDao budgetSettlementDao;

	public <T> List<T> budgetSettlementSummary(BudgetSettlementSearchCondition searchCondition) {
		return budgetSettlementDao.budgetSettlementSummary(searchCondition);
	}

	public <T> List<T> budgetSettlement(BudgetSettlementSearchCondition searchCondition) {
		return budgetSettlementDao.budgetSettlement(searchCondition);
	}

	public List<GeneralLedger> generalLedger(GeneralLedgerSearchCondition searchCondition) {
		return budgetSettlementDao.generalLedger(searchCondition);
	}
}
