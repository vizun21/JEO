package com.erowm.webapp.accounting.budgetSettlement.controller;

import com.erowm.common.config.Define;
import com.erowm.common.domain.BusinessVO;
import com.erowm.common.domain.HMap;
import com.erowm.common.util.SessionUtils;
import com.erowm.webapp.accounting.budgetSettlement.domain.GeneralLedger;
import com.erowm.webapp.accounting.budgetSettlement.service.BudgetSettlementService;
import com.erowm.webapp.accounting.print.dto.GeneralLedgerSearchCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;

@Controller
public class BudgetSettlementController {

	private final BudgetSettlementService budgetSettlementService;

	@Autowired
	public BudgetSettlementController(BudgetSettlementService budgetSettlementService) {
		this.budgetSettlementService = budgetSettlementService;
	}

	@PostMapping("/accounting/budget-settlement/general-ledger/{year}/{month}")
	public ResponseEntity<List<GeneralLedger>> generalLedger2POST(HMap hmap, @PathVariable("year") int year, @PathVariable("month") int month) {

		ResponseEntity<List<GeneralLedger>> entity;

		try {
			BusinessVO businessVO = (BusinessVO) SessionUtils.getAttribute(Define.businessVO);

			GeneralLedgerSearchCondition searchCondition = GeneralLedgerSearchCondition.ByYearMonthBuilder()
					.business(businessVO)
					.year(year)
					.month(month)
					.build();
			List<GeneralLedger> list = budgetSettlementService.generalLedger(searchCondition);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@PostMapping("/accounting/budget-settlement/general-ledger/{start_year}/{start_month}/{end_year}/{end_month}")
	public ResponseEntity<List<GeneralLedger>> generalLedger2POST(HMap hmap, @PathVariable("start_year") int start_year, @PathVariable("start_month") int start_month, @PathVariable("end_year") int end_year, @PathVariable("end_month") int end_month) {

		ResponseEntity<List<GeneralLedger>> entity;

		try {
			BusinessVO businessVO = (BusinessVO) SessionUtils.getAttribute(Define.businessVO);

			GeneralLedgerSearchCondition searchCondition = GeneralLedgerSearchCondition.ByPeriodBuilder()
					.business(businessVO)
					.start_year(start_year)
					.start_month(start_month)
					.end_year(end_year)
					.end_month(end_month)
					.build();
			List<GeneralLedger> list = budgetSettlementService.generalLedger(searchCondition);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
