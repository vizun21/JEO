package com.erowm.webapp.user.login.controller;

import com.erowm.common.config.Define;
import com.erowm.common.util.SessionUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@Controller
public class UserLoginController {
	@RequestMapping(value = "/user/login", method = RequestMethod.GET)
	public void loginGET() {
	}

	@RequestMapping(value = "/user/logout", method = RequestMethod.GET)
	public String logoutGET() {
		SessionUtils.removeAttribute(Define.loginVO);
		SessionUtils.removeAttribute(Define.adminVO);
		SessionUtils.removeAttribute(Define.businessVO);
		return "redirect:/";
	}
}
