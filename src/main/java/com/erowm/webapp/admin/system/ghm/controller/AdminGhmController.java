package com.erowm.webapp.admin.system.ghm.controller;

import com.erowm.common.config.Define;
import com.erowm.common.domain.HMap;
import com.erowm.webapp.admin.system.code.service.CodeService;
import com.erowm.webapp.ghm.service.GhmService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminGhmController {
	@Autowired CodeService codeService;
	@Autowired GhmService ghmService;

	@RequestMapping(value = "/admin/system/ghm/list", method = RequestMethod.GET)
	public void listGET(HMap hmap, Model model) {
		hmap.put(Define.CODE_ID, Define.BSNS_CATE);
		model.addAttribute("bsns_cate_list", codeService.codeDetailList(hmap));

		model.addAttribute("year_list", ghmService.ghmYear(hmap));

		hmap.put(Define.CODE_ID, Define.IO_TYPE);
		model.addAttribute("io_type_list", codeService.codeDetailList(hmap));
	}
}
