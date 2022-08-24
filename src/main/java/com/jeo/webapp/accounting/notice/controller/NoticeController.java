package com.jeo.webapp.accounting.notice.controller;

import com.jeo.common.config.Define;
import com.jeo.common.domain.HMap;
import com.jeo.webapp.notice.service.NoticeService;
import com.jeo.webapp.admin.system.code.service.CodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class NoticeController {
	@Autowired CodeService codeService;
	@Autowired NoticeService noticeService;

	@RequestMapping(value = "/accounting/notice/list", method = RequestMethod.GET)
	public void listGET() {
	}

	@RequestMapping(value = "/accounting/notice/view/{noti_code}", method = RequestMethod.GET)
	public String viewGET(HMap hmap, Model model, @PathVariable("noti_code") String noti_code) {
		hmap.put(Define.NOTI_CODE, noti_code);
		model.addAttribute("notice", noticeService.noticeItem(hmap));

		return "/accounting/notice/view";
	}
}
