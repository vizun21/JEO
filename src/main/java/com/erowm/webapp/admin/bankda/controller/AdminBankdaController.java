package com.erowm.webapp.admin.bankda.controller;

import com.erowm.common.domain.HMap;
import com.erowm.webapp.admin.system.bank.service.BankService;
import com.erowm.webapp.ghm.service.GhmService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminBankdaController {
	@Autowired GhmService ghmService;
	@Autowired BankService bankService;

	@RequestMapping(value = "/admin/bankda/account/list", method = RequestMethod.GET)
	public void listGET(HMap hmap, Model model) {
		model.addAttribute("bank_list", bankService.bankList(hmap));
	}

	@RequestMapping(value = "/admin/bankda/account/popup/list", method = RequestMethod.GET)
	public void popupListGET(HMap hmap, Model model) {
	}
}
