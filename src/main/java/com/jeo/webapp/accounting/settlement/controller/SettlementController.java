package com.jeo.webapp.accounting.settlement.controller;

import com.jeo.common.domain.HMap;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class SettlementController {
	@RequestMapping(value = "/accounting/settlement/list", method = RequestMethod.GET)
	public void listGET(HMap hmap, Model model) {
	}
}
