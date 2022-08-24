package com.erowm.webapp.accounting.tran.controller;

import com.erowm.common.config.Define;
import com.erowm.common.domain.HMap;
import com.erowm.common.util.DateUtils;
import com.erowm.webapp.accounting.acnt.service.AcntService;
import com.erowm.webapp.admin.system.code.service.CodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class TranController {
	@Autowired AcntService acntService;
	@Autowired CodeService codeService;

	@RequestMapping(value = "/accounting/tran/list", method = RequestMethod.GET)
	public void listGET(HMap hmap, Model model) {
		model.addAttribute("acnt_list", acntService.acntList(hmap));

		hmap.put(Define.CODE_ID, Define.IO_TYPE);
		model.addAttribute("io_type_list", codeService.codeDetailList(hmap));
	}

	@RequestMapping(value = "/accounting/tran/view", method = RequestMethod.GET)
	public void viewGET(HMap hmap, Model model) {
		model.addAttribute(Define.START_DATE, DateUtils.getFirstDate());
		model.addAttribute(Define.END_DATE, DateUtils.getLastDate());
	}
}
