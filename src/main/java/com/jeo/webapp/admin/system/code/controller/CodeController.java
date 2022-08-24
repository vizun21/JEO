package com.jeo.webapp.admin.system.code.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class CodeController {
	@RequestMapping(value = "/admin/system/code/list", method = RequestMethod.GET)
	public void listGET() {
	}
}
