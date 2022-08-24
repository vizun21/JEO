package com.erowm.webapp.accounting.budgetSettlement.dao;

import com.erowm.common.dao.AbstractDao;
import com.erowm.webapp.accounting.budgetSettlement.domain.GeneralLedger;
import com.erowm.webapp.accounting.print.dto.GeneralLedgerSearchCondition;
import com.erowm.webapp.print.dto.BudgetSettlementSearchCondition;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class BudgetSettlementDao extends AbstractDao {
	private static String namespace = "accounting.budget.settlement";

	public <T> List<T> budgetSettlementSummary(BudgetSettlementSearchCondition searchCondition) {
		return selectList(namespace + ".budgetSettlementSummary", searchCondition);
	}

	public <T> List<T> budgetSettlement(BudgetSettlementSearchCondition searchCondition) {
		return selectList(namespace + ".budgetSettlement", searchCondition);
	}

	public List<GeneralLedger> generalLedger(GeneralLedgerSearchCondition searchCondition) {
		return selectList(namespace + ".generalLedger", searchCondition);
	}
}
