package com.jeo.webapp.accounting.trial.balance.controller;

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
public class TrialBalanceController {
	@Autowired GhmService ghmService;

	@RequestMapping(value = "/accounting/trial/balance/total", method = RequestMethod.GET)
	public void totalGET(HMap hmap, Model model) {
	}

	@RequestMapping(value = "/accounting/trial/balance/annual", method = RequestMethod.GET)
	public void annualGET(HMap hmap, Model model) {
		BusinessVO businessVO = (BusinessVO) SessionUtils.getAttribute(Define.businessVO);
		hmap.put(Define.BSNS_CATE, businessVO.getBsns_cate());
		model.addAttribute("ghm_year_list", ghmService.ghmYear(hmap));
	}
}
