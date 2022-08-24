package com.erowm.webapp.accounting.notice.controller;

import com.erowm.common.domain.HMap;
import com.erowm.webapp.admin.system.code.service.CodeService;
import com.erowm.webapp.notice.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;
import java.util.Map;

@Controller
public class NoticeRestController {
	@Autowired
	CodeService codeService;
	@Autowired
	NoticeService noticeService;

	@RequestMapping(value = "/accounting/notice/page", method = RequestMethod.POST)
	public ResponseEntity<List<Map<Object, String>>> pagePOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<List<Map<Object, String>>> entity = null;
		try {
			hmap.set(map);

			List<Map<Object, String>> list = noticeService.noticePage(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
