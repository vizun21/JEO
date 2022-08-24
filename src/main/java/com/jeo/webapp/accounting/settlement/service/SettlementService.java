package com.jeo.webapp.accounting.settlement.service;

import com.jeo.common.domain.HMap;
import com.jeo.common.util.SessionDateUtils;
import com.jeo.webapp.accounting.settlement.dao.SettlementDao;
import com.jeo.webapp.print.dto.SettlementAmountSearchCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigInteger;
import java.util.List;

@Service
public class SettlementService {
	@Autowired SettlementDao settlementDao;

	public <T> List<T> settlementPage(HMap hmap) {
		SessionDateUtils.setSessionInfo(hmap);
		return settlementDao.settlementPage(hmap.getMap());
	}

	public BigInteger getSettlementAmount(SettlementAmountSearchCondition searchCondition) {
		return settlementDao.getSettlementAmount(searchCondition);
	}
}
