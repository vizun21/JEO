package com.erowm.webapp.accounting.budget.controller;

import com.erowm.common.config.Define;
import com.erowm.common.domain.BusinessVO;
import com.erowm.common.domain.HMap;
import com.erowm.common.util.SessionUtils;
import com.erowm.webapp.admin.system.code.service.CodeService;
import com.erowm.webapp.ghm.service.GhmService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class BudgetController {
	@Autowired CodeService codeService;
	@Autowired GhmService ghmService;

	@RequestMapping(value = "/accounting/budget/list", method = RequestMethod.GET)
	public void listGET(HMap hmap, Model model) {
//		hmap.put(Define.CODE_ID, Define.BUDG_TYPE);
//		model.addAttribute("budg_type_list", codeService.codeDetailList(hmap));

//		hmap.put(Define.CODE_ID, Define.BUDG_IO_TYPE);
//		model.addAttribute("budg_io_type_list", codeService.codeDetailList(hmap));

		BusinessVO businessVO = (BusinessVO) SessionUtils.getAttribute(Define.businessVO);
		hmap.put(Define.BSNS_CATE, businessVO.getBsns_cate());
		model.addAttribute("ghm_year_list", ghmService.ghmYear(hmap));
	}
}
