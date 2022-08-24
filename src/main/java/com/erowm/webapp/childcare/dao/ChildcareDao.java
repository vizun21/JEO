package com.erowm.webapp.childcare.dao;

import com.erowm.common.dao.AbstractDao;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class ChildcareDao extends AbstractDao {
	private static String namespace = "childcare.report";

	public <T> T childcareReportItem(Map<String, Object> map) {
		return selectOne(namespace + ".childcareReportList", map);
	}

	public int childcareReportRegist(Map<String, Object> map) {
		return insert(namespace + ".childcareReportRegist", map);
	}

	public <T> List<T> monthlyPage(Map<String, Object> map) {
		return selectList(namespace + ".monthlyPage", map);
	}

	public <T> List<T> monthlyData(Map<String, Object> map) {
		return selectList(namespace + ".monthlyData", map);
	}

	public <T> List<T> budgetPage(Map<String, Object> map) {
		return selectList(namespace + ".budgetPage", map);
	}

	public <T> List<T> budgetData(Map<String, Object> map) {
		return selectList(namespace + ".budgetData", map);
	}

	public <T> List<T> settlementPage(Map<String, Object> map) {
		return selectList(namespace + ".settlementPage", map);
	}

	public <T> List<T> settlementData(Map<String, Object> map) {
		return selectList(namespace + ".settlementData", map);
	}

}
