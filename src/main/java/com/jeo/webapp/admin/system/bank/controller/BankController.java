package com.jeo.webapp.admin.system.bank.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class BankController {
	@RequestMapping(value = "/admin/system/bank/list", method = RequestMethod.GET)
	public void listGET() {
	}
}
