package com.erowm.webapp.admin.comp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminCompController {
	@RequestMapping(value = "/admin/comp/list", method = RequestMethod.GET)
	public void listGET() {
	}
}
