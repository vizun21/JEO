package com.jeo.webapp.mypage.controller;

import com.jeo.common.config.Define;
import com.jeo.common.domain.HMap;
import com.jeo.webapp.admin.system.code.service.CodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MypageController {
	@Autowired
	CodeService codeService;

	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public void mypageGet(Model model) {
	}

	@RequestMapping(value = "/mybusiness", method = RequestMethod.GET)
	public void mybusinessGET(HMap hmap, Model model) {
		hmap.put(Define.CODE_ID, Define.BSNS_CATE);
		model.addAttribute("bsns_cate_list", codeService.codeDetailList(hmap));
	}

	@RequestMapping(value = "/myemployee", method = RequestMethod.GET)
	public void myemployeeGET(HMap hmap, Model model) {
	}
}
