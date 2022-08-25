package com.jeo.webapp.common.controller;

import com.jeo.common.config.Define;
import com.jeo.common.config.TypeVal;
import com.jeo.common.domain.LoginVO;
import com.jeo.common.util.SessionUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class CommonController {
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String rootGet(Model model) {
		LoginVO loginVO = (LoginVO) SessionUtils.getAttribute(Define.loginVO);
		if (loginVO.getUser_level() == TypeVal.LEVEL_SYSTEM_ADMIN)
			return "redirect:/admin/user/transform";
		else if (loginVO.getUser_level() == TypeVal.LEVEL_ADMIN)
			return "redirect:/admin/user/transform";
		else if (loginVO.getUser_level() == TypeVal.LEVEL_COMP_ADMIN || loginVO.getUser_level() == TypeVal.LEVEL_COMP_USER) {
			return "redirect:/home";
		}

		return "/error";
	}

	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String homeGet(Model model) {
		return "redirect:/comp/user";
	}
}
