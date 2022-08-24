package com.jeo.webapp.admin.notice;

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
public class AdminNoticeController {
	@Autowired CodeService codeService;
	@Autowired NoticeService noticeService;

	@RequestMapping(value = "/admin/notice/list", method = RequestMethod.GET)
	public void listGET() {
	}

	@RequestMapping(value = "/admin/notice/edit", method = RequestMethod.GET)
	public void editGET(HMap hmap, Model model) {
		hmap.put(Define.CODE_ID, Define.BSNS_CATE);
		model.addAttribute("bsns_cate_list", codeService.codeDetailList(hmap));
	}

	@RequestMapping(value = "/admin/notice/edit/{noti_code}", method = RequestMethod.GET)
	public String editItemGET(HMap hmap, Model model, @PathVariable("noti_code") String noti_code) {
		hmap.put(Define.CODE_ID, Define.BSNS_CATE);
		model.addAttribute("bsns_cate_list", codeService.codeDetailList(hmap));

		hmap.put(Define.NOTI_CODE, noti_code);
		model.addAttribute("notice", noticeService.noticeItem(hmap));

		return "/admin/notice/edit";
	}
}
