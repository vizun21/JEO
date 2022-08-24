package com.jeo.webapp.user.join.controller;

import com.jeo.common.config.Define;
import com.jeo.common.domain.HMap;
import com.jeo.webapp.admin.system.code.service.CodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller
public class UserJoinController {
	@Autowired
	CodeService codeService;

	@RequestMapping(value = "/user/join/comp", method = RequestMethod.GET)
	public void joinCompGET(Map map, HttpServletRequest request) {
	}

	@RequestMapping(value = "/user/join/person", method = RequestMethod.GET)
	public void joinPersonGET(Map map, HttpServletRequest request, Model model) {
		HMap param = new HMap();
		param.put(Define.CODE_ID, Define.USER_POSITION);
		List<?> positionList =  codeService.codeDetailList(param);
		model.addAttribute("positionList", positionList);
	}
}
