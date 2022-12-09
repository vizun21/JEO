package com.jeo.report.dao;

import com.jeo.common.dao.AbstractDao;
import com.jeo.report.dto.Report;
import org.springframework.stereotype.Repository;

@Repository
public class ReportDao extends AbstractDao {
	private static String namespace = "print";

	public int insert(Report report) {
		return insert(namespace + ".insert", report);
	}
}
