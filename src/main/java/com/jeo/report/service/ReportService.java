package com.jeo.report.service;

import com.jeo.report.dao.ReportDao;
import com.jeo.report.dto.Report;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReportService {
	@Autowired
	ReportDao reportDao;

	public int insert(Report report) {
		return reportDao.insert(report);
	}
}
