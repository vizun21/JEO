package com.jeo.position.controller;

import com.jeo.common.config.Define;
import com.jeo.common.domain.HMap;
import com.jeo.position.domain.CodeDetail;
import com.jeo.webapp.admin.system.code.service.CodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class PositionController {
	@Autowired
	CodeService codeService;

	@PostMapping("/position")
	public String positionPOST(HMap hmap, CodeDetail codeDetail) {
		codeDetail.setCode_id("USER_POSITION");
		codeDetail.setUser_id(hmap.getString(Define.USER_ID));
		codeService.codeDetailRegist(codeDetail);
		return "redirect:/comp/position";
	}
}
