package com.erowm.webapp.accounting.room.controller;

import com.erowm.common.domain.HMap;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class RoomController {
	@RequestMapping(value = "/accounting/room/list", method = RequestMethod.GET)
	public void listGET(HMap hmap, Model model) {
	}
}
