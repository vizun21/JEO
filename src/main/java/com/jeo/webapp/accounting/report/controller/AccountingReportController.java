package com.jeo.webapp.accounting.report.controller;

import com.jeo.common.config.Define;
import com.jeo.common.domain.BusinessVO;
import com.jeo.common.domain.HMap;
import com.jeo.common.util.SessionUtils;
import com.jeo.webapp.ghm.service.GhmService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AccountingReportController {
	@Autowired GhmService ghmService;

	@RequestMapping(value = "/accounting/report/monthly", method = RequestMethod.GET)
	public void monthlyGET(HMap hmap, Model model) {
		BusinessVO businessVO = (BusinessVO) SessionUtils.getAttribute(Define.businessVO);
		hmap.put(Define.BSNS_CATE, businessVO.getBsns_cate());
		model.addAttribute("ghm_year_list", ghmService.ghmYear(hmap));
	}

	@RequestMapping(value = "/accounting/report/budget", method = RequestMethod.GET)
	public void budgetGET(HMap hmap, Model model) {
		BusinessVO businessVO = (BusinessVO) SessionUtils.getAttribute(Define.businessVO);
		hmap.put(Define.BSNS_CATE, businessVO.getBsns_cate());
		model.addAttribute("ghm_year_list", ghmService.ghmYear(hmap));
	}

	@RequestMapping(value = "/accounting/report/settlement", method = RequestMethod.GET)
	public void settlement(HMap hmap, Model model) {
	}
}
