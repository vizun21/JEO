package com.jeo.webapp.accounting.child.controller;

import com.jeo.common.domain.HMap;
import com.jeo.webapp.accounting.room.service.RoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ChildController {
	@Autowired RoomService roomService;
	@RequestMapping(value = "/accounting/child/list", method = RequestMethod.GET)
	public void listGET(HMap hmap, Model model) {
		model.addAttribute("room_list", roomService.roomList(hmap));
	}
}
