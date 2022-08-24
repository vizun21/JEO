package com.jeo.webapp.accounting.tran.service;

import com.jeo.common.domain.HMap;
import com.jeo.webapp.accounting.tran.dao.BankTranDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigInteger;
import java.util.List;

@Service
public class BankTranService {
	@Autowired
	BankTranDao bankTranDao;

	public <T> List<T> bankTranPage(HMap hmap) {
		return bankTranDao.bankTranPage(hmap.getMap());
	}

	public <T> T bankTranItem(HMap hmap) {
		return bankTranDao.bankTranItem(hmap.getMap());
	}

	public BigInteger bankTranBalance(HMap hmap) {
		return bankTranDao.bankTranBalance(hmap.getMap());
	}

	public BigInteger bankTranCount(HMap hmap) {
		return bankTranDao.bankTranCount(hmap.getMap());
	}
}
