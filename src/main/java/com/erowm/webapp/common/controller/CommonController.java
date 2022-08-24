package com.erowm.webapp.common.controller;

import com.erowm.common.config.Define;
import com.erowm.common.config.TypeVal;
import com.erowm.common.domain.BusinessVO;
import com.erowm.common.domain.LoginVO;
import com.erowm.common.util.CommonUtils;
import com.erowm.common.util.SessionUtils;
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
			BusinessVO businessVO = (BusinessVO) SessionUtils.getAttribute(Define.businessVO);
			if (CommonUtils.isEmpty(businessVO)) {
				return "redirect:/mybusiness";
			} else {
				return "redirect:/home";
			}
		}

		return "/error";
	}

	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public void homeGet(Model model) {
	}
}
