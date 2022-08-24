package com.erowm.webapp.admin.system.bank.service;

import com.erowm.common.domain.HMap;
import com.erowm.webapp.admin.system.bank.dao.BankDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BankService {
	@Autowired
	BankDao bankDao;

	public <T> List<T> bankPage(HMap hmap) {
		return bankDao.bankPage(hmap.getMap());
	}

	public <T> List<T> bankList(HMap hmap) {
		return bankDao.bankList(hmap.getMap());
	}

	public <T> T bankItem(HMap hmap) {
		return bankDao.bankItem(hmap.getMap());
	}

	public <T> List<T> overlapCheck(HMap hmap) {
		return bankDao.overlapCheck(hmap.getMap());
	}

	public int bankRegist(HMap hmap) {
		return bankDao.bankRegist(hmap.getMap());
	}

	public int bankModify(HMap hmap) {
		return bankDao.bankModify(hmap.getMap());
	}
}
