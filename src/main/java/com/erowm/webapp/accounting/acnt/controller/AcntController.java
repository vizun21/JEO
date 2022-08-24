package com.erowm.webapp.accounting.acnt.controller;

import com.erowm.common.domain.HMap;
import com.erowm.webapp.admin.system.bank.service.BankService;
import com.erowm.webapp.ghm.service.GhmService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AcntController {
	@Autowired GhmService ghmService;
	@Autowired BankService bankService;

	@RequestMapping(value = "/accounting/acnt/list", method = RequestMethod.GET)
	public void listGET(HMap hmap, Model model) {
		model.addAttribute("bank_list", bankService.bankList(hmap));
	}
}
