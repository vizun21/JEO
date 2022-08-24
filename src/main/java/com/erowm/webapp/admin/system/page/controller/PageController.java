package com.erowm.webapp.admin.system.page.controller;

import com.erowm.common.config.Define;
import com.erowm.common.domain.HMap;
import com.erowm.webapp.admin.system.code.service.CodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class PageController {
	@Autowired CodeService codeService;
	@RequestMapping(value = "/admin/system/page/list", method = RequestMethod.GET)
	public void listGET(HMap hmap, Model model) {
		hmap.put(Define.CODE_ID, Define.BSNS_CATE);
		model.addAttribute("bsns_cate_list", codeService.codeDetailList(hmap));
	}
}
