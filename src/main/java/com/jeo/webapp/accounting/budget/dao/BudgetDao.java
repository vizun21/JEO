package com.jeo.webapp.accounting.budget.dao;

import com.jeo.common.dao.AbstractDao;
import com.jeo.webapp.print.dto.BudgetAmountSearchCondition;
import org.springframework.stereotype.Repository;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

@Repository
public class BudgetDao extends AbstractDao {
	private static String namespace = "accounting.budget";

	public <T> List<T> budgetPage(Map<String, Object> map) {
		return selectList(namespace + ".budgetPage", map);
	}

	public <T> T budgetItem(Map<String, Object> map) {
		return selectOne(namespace + ".budgetList", map);
	}

	public int budgetRegist(Map<String, Object> map) {
		return insert(namespace + ".budgetRegist", map);
	}

	public <T> List<T> budgetDetailPage(Map<String, Object> map) {
		return selectList(namespace + ".budgetDetailPage", map);
	}

	public <T> List<T> budgetDetailList(Map<String, Object> map) {
		return selectList(namespace + ".budgetDetailList", map);
	}

	public int budgetDetailRegist(Map<String, Object> map) {
		return insert(namespace + ".budgetDetailRegist", map);
	}

	public int budgetDetailModify(Map<String, Object> map) {
		return update(namespace + ".budgetDetailModify", map);
	}

	public int budgetDetailDelete(Map<String, Object> map) {
		return delete(namespace + ".budgetDetailDelete", map);
	}

	public String getLastBudgetType(Map<String, Object> map) {
		return selectOne(namespace + ".getLastBudgetType", map);
	}

	public BigInteger getBudgetAmount(BudgetAmountSearchCondition budgetAmountSearchCondition) {
		return selectOne(namespace + ".getBudgetAmount", budgetAmountSearchCondition);
	}
}
