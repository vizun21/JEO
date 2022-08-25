package com.jeo.web.user.controller;

import com.jeo.common.config.Define;
import com.jeo.common.domain.HMap;
import com.jeo.webapp.admin.system.code.service.CodeService;
import com.jeo.webapp.comp.service.CompService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class WebUserController {
	@Autowired
	CompService compService;

	@Autowired
	CodeService codeService;

	@GetMapping("/user/searchPassword")
	public void userSearchPasswordGET(Model model) {
		HMap param = new HMap();
		param.put(Define.CODE_ID, Define.PASSWORD_HINT);
		List<?> passwordHintList =  codeService.codeDetailList(param);
		model.addAttribute("passwordHintList", passwordHintList);
	}
}
