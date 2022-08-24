package com.erowm.webapp.accounting.print.controller;

import com.erowm.common.domain.HMap;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class PrintController {
	@RequestMapping(value = "/accounting/print/book", method = RequestMethod.GET)
	public void bookGET(HMap hmap, Model model) {
	}

	@RequestMapping(value = "/accounting/print/settlement", method = RequestMethod.GET)
	public void settlementGET(HMap hmap, Model model) {
	}

	@RequestMapping(value = "/accounting/print/budget", method = RequestMethod.GET)
	public void budgetGET(HMap hmap, Model model) {
	}
}
