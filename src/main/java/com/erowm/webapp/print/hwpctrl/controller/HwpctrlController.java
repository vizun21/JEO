package com.erowm.webapp.print.hwpctrl.controller;

import com.erowm.common.config.Define;
import com.erowm.common.config.TypeVal;
import com.erowm.common.domain.HMap;
import com.erowm.common.util.SessionDateUtils;
import com.erowm.webapp.accounting.budget.service.BudgetService;
import com.erowm.webapp.accounting.budgetSettlement.service.BudgetSettlementService;
import com.erowm.webapp.accounting.print.service.PrintService;
import com.erowm.webapp.accounting.settlement.service.SettlementService;
import com.erowm.webapp.accounting.tran.service.TranService;
import com.erowm.webapp.accounting.trial.balance.service.TrialBalanceService;
import com.erowm.webapp.print.dto.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.math.BigInteger;
import java.util.List;

@Controller
public class HwpctrlController {
	@Autowired
	SettlementService settlementService;
	@Autowired
	PrintService printService;
	@Autowired
	BudgetService budgetService;
	@Autowired
	BudgetSettlementService budgetSettlementService;
	@Autowired
	TrialBalanceService trialBalanceService;
	@Autowired
	TranService tranService;

	private static final int NONE = -1;
	private static final String SNONE = "-1";

	@RequestMapping(value = "/print/hwpctrl/book", method = RequestMethod.GET)
	public void bookGET(HMap hmap, Model model, @RequestParam("start_year") int start_year, @RequestParam("start_month") int start_month
			, @RequestParam(value = "end_year", required = false, defaultValue = SNONE) int end_year, @RequestParam(value = "end_month", required = false, defaultValue = SNONE) int end_month) {
		end_year = end_year == NONE ? start_year : end_year;
		end_month = end_month == NONE ? start_month : end_month;

		model.addAttribute(Define.START_YEAR, start_year);
		model.addAttribute(Define.START_MONTH, start_month);
		model.addAttribute(Define.END_YEAR, end_year);
		model.addAttribute(Define.END_MONTH, end_month);
		model.addAttribute(Define.SESSION_YEAR, SessionDateUtils.getSessionYear(start_year, start_month, hmap.getInt(Define.BSNS_SESS_START_MONTH)));
	}

	@RequestMapping(value = "/print/hwpctrl/settlement/revenue", method = RequestMethod.GET)
	public void settlementRevenueGET(HMap hmap, Model model, @RequestParam("start_year") int start_year, @RequestParam("start_month") int start_month
			, @RequestParam(value = "end_year", required = false, defaultValue = SNONE) int end_year, @RequestParam(value = "end_month", required = false, defaultValue = SNONE) int end_month) {
		end_year = end_year == NONE ? start_year : end_year;
		end_month = end_month == NONE ? start_month : end_month;

		model.addAttribute(Define.START_YEAR, start_year);
		model.addAttribute(Define.START_MONTH, start_month);
		model.addAttribute(Define.END_YEAR, end_year);
		model.addAttribute(Define.END_MONTH, end_month);
		model.addAttribute(Define.SESSION_YEAR, SessionDateUtils.getSessionYear(start_year, start_month, hmap.getInt(Define.BSNS_SESS_START_MONTH)));
	}

	@RequestMapping(value = "/print/hwpctrl/settlement/expenditure", method = RequestMethod.GET)
	public void settlementExpenditureGET(HMap hmap, Model model, @RequestParam("start_year") int start_year, @RequestParam("start_month") int start_month
			, @RequestParam(value = "end_year", required = false, defaultValue = SNONE) int end_year, @RequestParam(value = "end_month", required = false, defaultValue = SNONE) int end_month) {
		end_year = end_year == NONE ? start_year : end_year;
		end_month = end_month == NONE ? start_month : end_month;

		model.addAttribute(Define.START_YEAR, start_year);
		model.addAttribute(Define.START_MONTH, start_month);
		model.addAttribute(Define.END_YEAR, end_year);
		model.addAttribute(Define.END_MONTH, end_month);
		model.addAttribute(Define.SESSION_YEAR, SessionDateUtils.getSessionYear(start_year, start_month, hmap.getInt(Define.BSNS_SESS_START_MONTH)));
	}

	@RequestMapping(value = "/print/hwpctrl/transaction", method = RequestMethod.GET)
	public void transactionGET(HMap hmap, Model model, @RequestParam("start_year") int start_year, @RequestParam("start_month") int start_month
			, @RequestParam(value = "end_year", required = false, defaultValue = SNONE) int end_year, @RequestParam(value = "end_month", required = false, defaultValue = SNONE) int end_month) {
		end_year = end_year == NONE ? start_year : end_year;
		end_month = end_month == NONE ? start_month : end_month;

		model.addAttribute(Define.START_YEAR, start_year);
		model.addAttribute(Define.START_MONTH, start_month);
		model.addAttribute(Define.END_YEAR, end_year);
		model.addAttribute(Define.END_MONTH, end_month);
		model.addAttribute(Define.SESSION_YEAR, SessionDateUtils.getSessionYear(start_year, start_month, hmap.getInt(Define.BSNS_SESS_START_MONTH)));
	}

	@RequestMapping(value = "/print/hwpctrl/general_ledger", method = RequestMethod.GET)
	public void generalLedgerGET(HMap hmap, Model model, @RequestParam("start_year") int start_year, @RequestParam("start_month") int start_month
			, @RequestParam(value = "end_year", required = false, defaultValue = SNONE) int end_year, @RequestParam(value = "end_month", required = false, defaultValue = SNONE) int end_month) {
		end_year = end_year == NONE ? start_year : end_year;
		end_month = end_month == NONE ? start_month : end_month;

		model.addAttribute(Define.START_YEAR, start_year);
		model.addAttribute(Define.START_MONTH, start_month);
		model.addAttribute(Define.END_YEAR, end_year);
		model.addAttribute(Define.END_MONTH, end_month);
		model.addAttribute(Define.SESSION_YEAR, SessionDateUtils.getSessionYear(start_year, start_month, hmap.getInt(Define.BSNS_SESS_START_MONTH)));
	}

	@RequestMapping(value = "/print/hwpctrl/voucher/revenue", method = RequestMethod.GET)
	public String voucherRevenueGET(HMap hmap, Model model, @RequestParam("start_year") int start_year, @RequestParam("start_month") int start_month
			, @RequestParam(value = "end_year", required = false, defaultValue = SNONE) int end_year, @RequestParam(value = "end_month", required = false, defaultValue = SNONE) int end_month) {
		end_year = end_year == NONE ? start_year : end_year;
		end_month = end_month == NONE ? start_month : end_month;

		model.addAttribute(Define.START_YEAR, start_year);
		model.addAttribute(Define.START_MONTH, start_month);
		model.addAttribute(Define.END_YEAR, end_year);
		model.addAttribute(Define.END_MONTH, end_month);
		model.addAttribute(Define.SESSION_YEAR, SessionDateUtils.getSessionYear(start_year, start_month, hmap.getInt(Define.BSNS_SESS_START_MONTH)));

		model.addAttribute(Define.IO_TYPE, "I");
		model.addAttribute(Define.RETURN_VOUCHER, "N");
		model.addAttribute(Define.VOUCHER_TYPE, "수입");
		return "/print/hwpctrl/voucher";
	}

	@RequestMapping(value = "/print/hwpctrl/voucher/expenditure", method = RequestMethod.GET)
	public String voucherExpenditureGET(HMap hmap, Model model, @RequestParam("start_year") int start_year, @RequestParam("start_month") int start_month
			, @RequestParam(value = "end_year", required = false, defaultValue = SNONE) int end_year, @RequestParam(value = "end_month", required = false, defaultValue = SNONE) int end_month) {
		end_year = end_year == NONE ? start_year : end_year;
		end_month = end_month == NONE ? start_month : end_month;

		model.addAttribute(Define.START_YEAR, start_year);
		model.addAttribute(Define.START_MONTH, start_month);
		model.addAttribute(Define.END_YEAR, end_year);
		model.addAttribute(Define.END_MONTH, end_month);
		model.addAttribute(Define.SESSION_YEAR, SessionDateUtils.getSessionYear(start_year, start_month, hmap.getInt(Define.BSNS_SESS_START_MONTH)));

		model.addAttribute(Define.IO_TYPE, "O");
		model.addAttribute(Define.RETURN_VOUCHER, "N");
		model.addAttribute(Define.VOUCHER_TYPE, "지출");
		return "/print/hwpctrl/voucher";
	}

	@RequestMapping(value = "/print/hwpctrl/return/voucher/revenue", method = RequestMethod.GET)
	public String returnVoucherRevenueGET(HMap hmap, Model model, @RequestParam("start_year") int start_year, @RequestParam("start_month") int start_month
			, @RequestParam(value = "end_year", required = false, defaultValue = SNONE) int end_year, @RequestParam(value = "end_month", required = false, defaultValue = SNONE) int end_month) {
		end_year = end_year == NONE ? start_year : end_year;
		end_month = end_month == NONE ? start_month : end_month;

		model.addAttribute(Define.START_YEAR, start_year);
		model.addAttribute(Define.START_MONTH, start_month);
		model.addAttribute(Define.END_YEAR, end_year);
		model.addAttribute(Define.END_MONTH, end_month);
		model.addAttribute(Define.SESSION_YEAR, SessionDateUtils.getSessionYear(start_year, start_month, hmap.getInt(Define.BSNS_SESS_START_MONTH)));

		model.addAttribute(Define.IO_TYPE, "I");
		model.addAttribute(Define.RETURN_VOUCHER, "Y");
		model.addAttribute(Define.VOUCHER_TYPE, "수입반납");
		return "/print/hwpctrl/voucher";
	}

	@RequestMapping(value = "/print/hwpctrl/return/voucher/expenditure", method = RequestMethod.GET)
	public String returnVoucherExpenditureGET(HMap hmap, Model model, @RequestParam("start_year") int start_year, @RequestParam("start_month") int start_month
			, @RequestParam(value = "end_year", required = false, defaultValue = SNONE) int end_year, @RequestParam(value = "end_month", required = false, defaultValue = SNONE) int end_month) {
		end_year = end_year == NONE ? start_year : end_year;
		end_month = end_month == NONE ? start_month : end_month;

		model.addAttribute(Define.START_YEAR, start_year);
		model.addAttribute(Define.START_MONTH, start_month);
		model.addAttribute(Define.END_YEAR, end_year);
		model.addAttribute(Define.END_MONTH, end_month);
		model.addAttribute(Define.SESSION_YEAR, SessionDateUtils.getSessionYear(start_year, start_month, hmap.getInt(Define.BSNS_SESS_START_MONTH)));

		model.addAttribute(Define.IO_TYPE, "O");
		model.addAttribute(Define.RETURN_VOUCHER, "Y");
		model.addAttribute(Define.VOUCHER_TYPE, "지출반납");
		return "/print/hwpctrl/voucher";
	}

	@RequestMapping(value = "/print/hwpctrl/voucher", method = RequestMethod.GET)
	public String voucherGET(HMap hmap, Model model, @RequestParam("tran_code_list") List tran_code_list) {
		model.addAttribute("tran_code_list", tran_code_list);
		return "/print/hwpctrl/voucher2";
	}

	@RequestMapping(value = "/print/hwpctrl/trial_balance", method = RequestMethod.GET)
	public void trialBalanceGET(HMap hmap, Model model, @RequestParam("start_year") int start_year, @RequestParam("start_month") int start_month
			, @RequestParam(value = "end_year", required = false, defaultValue = SNONE) int end_year, @RequestParam(value = "end_month", required = false, defaultValue = SNONE) int end_month) {
		end_year = end_year == NONE ? start_year : end_year;
		end_month = end_month == NONE ? start_month : end_month;

		model.addAttribute(Define.START_YEAR, start_year);
		model.addAttribute(Define.START_MONTH, start_month);
		model.addAttribute(Define.END_YEAR, end_year);
		model.addAttribute(Define.END_MONTH, end_month);
		model.addAttribute(Define.SESSION_YEAR, SessionDateUtils.getSessionYear(start_year, start_month, hmap.getInt(Define.BSNS_SESS_START_MONTH)));
	}


	@RequestMapping(value = "/print/hwpctrl/annual_settlement_report", method = RequestMethod.GET)
	public void annualSettlementReportGET(HMap hmap, Model model, @RequestParam("year") int year) {
		model.addAttribute(Define.SESSION_YEAR, year);

		/* 세입예산액 */
		BigInteger revenueBudgetAmount = budgetService.getBudgetAmount(BudgetAmountSearchCondition.builder()
				.comp_code(hmap.getString(Define.COMP_CODE)).bsns_code(hmap.getString(Define.BSNS_CODE))
				.session_year(year).io_type(IOType.I).build());
		model.addAttribute("revenueBudgetAmount", revenueBudgetAmount);
		/* 세출예산액 */
		BigInteger expenditureBudgetAmount = budgetService.getBudgetAmount(BudgetAmountSearchCondition.builder()
				.comp_code(hmap.getString(Define.COMP_CODE)).bsns_code(hmap.getString(Define.BSNS_CODE))
				.session_year(year).io_type(IOType.O).build());
		model.addAttribute("expenditureBudgetAmount", expenditureBudgetAmount);

		/* 세입총액 */
		BigInteger revenueSettlementAmount = settlementService.getSettlementAmount(SettlementAmountSearchCondition.builder()
				.comp_code(hmap.getString(Define.COMP_CODE)).bsns_code(hmap.getString(Define.BSNS_CODE))
				.session_year(year).io_type(IOType.I).build());
		model.addAttribute("revenueSettlementAmount", revenueSettlementAmount);
		/* 세출총액 */
		BigInteger expenditureSettlementAmount = settlementService.getSettlementAmount(SettlementAmountSearchCondition.builder()
				.comp_code(hmap.getString(Define.COMP_CODE)).bsns_code(hmap.getString(Define.BSNS_CODE))
				.session_year(year).io_type(IOType.O).build());
		model.addAttribute("expenditureSettlementAmount", expenditureSettlementAmount);

		/* 예산차액 */
		model.addAttribute("budgetDifference", revenueBudgetAmount.subtract(expenditureBudgetAmount));
		/* 결산차액 */
		model.addAttribute("settlementDifference", revenueSettlementAmount.subtract(expenditureSettlementAmount));
		/* 미납액 */
		model.addAttribute("revenueDifference", revenueBudgetAmount.subtract(revenueSettlementAmount));
		/* 잔액 */
		model.addAttribute("expenditureDifference", expenditureBudgetAmount.subtract(expenditureSettlementAmount));

		/* 세입 예결산 총괄표 */
		model.addAttribute("revenueBudgetSettlementSummary", budgetSettlementService.budgetSettlementSummary(BudgetSettlementSearchCondition.builder()
				.comp_code(hmap.getString(Define.COMP_CODE)).bsns_code(hmap.getString(Define.BSNS_CODE))
				.session_year(year).bsns_cate(hmap.getString(Define.BSNS_CATE)).io_type(IOType.I).build()));
		/* 세출 예결산 총괄표 */
		model.addAttribute("expenditureBudgetSettlementSummary", budgetSettlementService.budgetSettlementSummary(BudgetSettlementSearchCondition.builder()
				.comp_code(hmap.getString(Define.COMP_CODE)).bsns_code(hmap.getString(Define.BSNS_CODE))
				.session_year(year).bsns_cate(hmap.getString(Define.BSNS_CATE)).io_type(IOType.O).build()));

		/* 세입결산서 */
		model.addAttribute("revenueBudgetSettlement", budgetSettlementService.budgetSettlement(BudgetSettlementSearchCondition.builder()
				.comp_code(hmap.getString(Define.COMP_CODE)).bsns_code(hmap.getString(Define.BSNS_CODE))
				.session_year(year).bsns_cate(hmap.getString(Define.BSNS_CATE)).io_type(IOType.I).build()));
		/* 세출결산서 */
		model.addAttribute("expenditureBudgetSettlement", budgetSettlementService.budgetSettlement(BudgetSettlementSearchCondition.builder()
				.comp_code(hmap.getString(Define.COMP_CODE)).bsns_code(hmap.getString(Define.BSNS_CODE))
				.session_year(year).bsns_cate(hmap.getString(Define.BSNS_CATE)).io_type(IOType.O).build()));

		/* 월별시산표 */
		model.addAttribute("trialBalance", trialBalanceService.trialBalanceAnnual(TrialBalanceSearchCondition.builder()
				.comp_code(hmap.getString(Define.COMP_CODE)).bsns_code(hmap.getString(Define.BSNS_CODE))
				.session_year(year).session_start_month(hmap.getInt(Define.BSNS_SESS_START_MONTH))
				.bsns_cate(hmap.getString(Define.BSNS_CATE)).build()));

		/* 정부보조금명세서 */
		HMap param = new HMap();
		param.put(Define.COMP_CODE, hmap.getString(Define.COMP_CODE));
		param.put(Define.BSNS_CODE, hmap.getString(Define.BSNS_CODE));
		param.put(Define.START_YEAR, year);
		param.put(Define.START_MONTH, hmap.getInt(Define.BSNS_SESS_START_MONTH));
		param.put(Define.END_YEAR, year + 1);
		param.put(Define.END_MONTH, hmap.getInt(Define.BSNS_SESS_START_MONTH));
		param.put(Define.BSNS_SESS_START_MONTH, hmap.getInt(Define.BSNS_SESS_START_MONTH));
		param.put(Define.TRAN_IO_TYPE, IOType.I);
		param.put("ghm_name", "보조금");
		SessionDateUtils.setSessionInfo(param);
		model.addAttribute("grantStatement", tranService.tranList(param));
	}

	@RequestMapping(value = "/print/hwpctrl/annual_settlement_revenue", method = RequestMethod.GET)
	public void annualSettlementRevenueGET(HMap hmap, Model model, @RequestParam("year") int year) {
		model.addAttribute(Define.SESSION_YEAR, year);
	}

	@RequestMapping(value = "/print/hwpctrl/annual_settlement_expenditure", method = RequestMethod.GET)
	public void annualSettlementExpenditureGET(HMap hmap, Model model, @RequestParam("year") int year) {
		model.addAttribute(Define.SESSION_YEAR, year);
	}

	@RequestMapping(value = "/print/hwpctrl/annual_trial_balance", method = RequestMethod.GET)
	public void annualTrialBalanceGET(HMap hmap, Model model, @RequestParam("year") int year) {
		model.addAttribute(Define.SESSION_YEAR, year);
	}


	@RequestMapping(value = "/print/hwpctrl/budget_report", method = RequestMethod.GET)
	public String budgetReportGET(HMap hmap, Model model, @RequestParam("year") int year) {
		model.addAttribute(Define.BUDG_YEAR, year);
		hmap.put(Define.BUDG_YEAR, year);
		model.addAttribute("last_budg_type", budgetService.getLastBudgetType(hmap));

		model.addAttribute("prev_budg_year", year - 1);
		hmap.put(Define.BUDG_YEAR, year - 1);
		model.addAttribute("prev_last_budg_type", budgetService.getLastBudgetType(hmap));
		return "/print/hwpctrl/budget_report";
	}

	@RequestMapping(value = "/print/hwpctrl/budget_revenue", method = RequestMethod.GET)
	public String originBudgetRevenueGET(HMap hmap, Model model, @RequestParam("year") int year) {
		model.addAttribute(Define.SESSION_YEAR, year);
		hmap.put(Define.BUDG_YEAR, year);
		model.addAttribute("last_budg_type", budgetService.getLastBudgetType(hmap));

		model.addAttribute("prev_budg_year", year - 1);
		hmap.put(Define.BUDG_YEAR, year - 1);
		model.addAttribute("prev_last_budg_type", budgetService.getLastBudgetType(hmap));
		model.addAttribute(Define.IO_TYPE, TypeVal.INPUT_TYPE);
		return "/print/hwpctrl/budget_revenue";
	}

	@RequestMapping(value = "/print/hwpctrl/budget_expenditure", method = RequestMethod.GET)
	public String originBudgetExpenditureGET(HMap hmap, Model model, @RequestParam("year") int year) {
		model.addAttribute(Define.SESSION_YEAR, year);
		hmap.put(Define.BUDG_YEAR, year);
		model.addAttribute("last_budg_type", budgetService.getLastBudgetType(hmap));

		model.addAttribute("prev_budg_year", year - 1);
		hmap.put(Define.BUDG_YEAR, year - 1);
		model.addAttribute("prev_last_budg_type", budgetService.getLastBudgetType(hmap));
		model.addAttribute(Define.IO_TYPE, TypeVal.OUTPUT_TYPE);
		return "/print/hwpctrl/budget_expenditure";
	}

	@RequestMapping(value = "/print/hwpctrl/supplementary_budget_revenue", method = RequestMethod.GET)
	public String supplementaryBudgetRevenueGET(HMap hmap, Model model, @RequestParam("year") int year, @RequestParam("budg_type") int budg_type) {
		model.addAttribute(Define.BUDG_YEAR, year);
		model.addAttribute(Define.BUDG_TYPE, budg_type);

		int compare_budg_year;
		int compare_budg_type;
		if (budg_type == 0) {
			compare_budg_year = year - 1;
			HMap param = new HMap();
			param.put(Define.COMP_CODE, hmap.getString(Define.COMP_CODE));
			param.put(Define.BSNS_CODE, hmap.getString(Define.BSNS_CODE));
			param.put(Define.BUDG_YEAR, compare_budg_year);
			compare_budg_type = Integer.parseInt(budgetService.getLastBudgetType(param));
		} else {
			compare_budg_year = year;
			compare_budg_type = budg_type - 1;
		}
		model.addAttribute("compare_budg_year", compare_budg_year);
		model.addAttribute("compare_budg_type", compare_budg_type);
		model.addAttribute(Define.IO_TYPE, TypeVal.INPUT_TYPE);
		return "/print/hwpctrl/supplementary_budget";
	}

	@RequestMapping(value = "/print/hwpctrl/supplementary_budget_expenditure", method = RequestMethod.GET)
	public String supplementaryBudgetExpenditureGET(HMap hmap, Model model, @RequestParam("year") int year, @RequestParam("budg_type") int budg_type) {
		model.addAttribute(Define.BUDG_YEAR, year);
		model.addAttribute(Define.BUDG_TYPE, budg_type);

		int compare_budg_year;
		int compare_budg_type;
		if (budg_type == 0) {
			compare_budg_year = year - 1;
			HMap param = new HMap();
			param.put(Define.COMP_CODE, hmap.getString(Define.COMP_CODE));
			param.put(Define.BSNS_CODE, hmap.getString(Define.BSNS_CODE));
			param.put(Define.BUDG_YEAR, compare_budg_year);
			compare_budg_type = Integer.parseInt(budgetService.getLastBudgetType(param));
		} else {
			compare_budg_year = year;
			compare_budg_type = budg_type - 1;
		}
		model.addAttribute("compare_budg_year", compare_budg_year);
		model.addAttribute("compare_budg_type", compare_budg_type);
		model.addAttribute(Define.IO_TYPE, TypeVal.OUTPUT_TYPE);
		return "/print/hwpctrl/supplementary_budget";
	}
}
