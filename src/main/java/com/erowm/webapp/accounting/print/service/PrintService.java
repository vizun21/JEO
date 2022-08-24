package com.erowm.webapp.accounting.print.service;

import com.erowm.common.domain.HMap;
import com.erowm.common.util.SessionDateUtils;
import com.erowm.webapp.accounting.print.dao.PrintDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PrintService {
	@Autowired PrintDao printDao;

	public <T> List<T> transactionList(HMap hmap) {
		SessionDateUtils.setSessionInfo(hmap);
		return printDao.transactionList(hmap.getMap());
	}

	public <T> List<T> voucher(HMap hmap) {
		SessionDateUtils.setSessionInfo(hmap);
		return printDao.voucher(hmap.getMap());
	}

	public <T> List<T> voucher2(HMap hmap) {
		return printDao.voucher(hmap.getMap());
	}

	public <T> List<T> budget(HMap hmap) {
		return printDao.budget(hmap.getMap());
	}
}
