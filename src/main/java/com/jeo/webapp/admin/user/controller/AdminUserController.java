package com.jeo.webapp.admin.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminUserController {
	@RequestMapping(value = "/admin/user/transform", method = RequestMethod.GET)
	public void transformGET() {
	}
}