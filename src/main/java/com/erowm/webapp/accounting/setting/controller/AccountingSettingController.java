package com.erowm.webapp.accounting.setting.controller;

import com.erowm.common.domain.HMap;
import com.erowm.webapp.ghm.service.GhmService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AccountingSettingController {
	@Autowired
	GhmService ghmService;

	@RequestMapping(value = "/accounting/setting/ghm", method = RequestMethod.GET)
	public void listGET(HMap hmap, Model model) {
		model.addAttribute("ghm_year_list", ghmService.ghmYear(hmap));
	}
}
