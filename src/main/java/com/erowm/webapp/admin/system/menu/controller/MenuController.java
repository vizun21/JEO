package com.erowm.webapp.admin.system.menu.controller;

import com.erowm.common.config.Define;
import com.erowm.common.domain.HMap;
import com.erowm.webapp.admin.system.menu.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MenuController {
	@Autowired MenuService menuService;

	@RequestMapping(value = "/admin/system/menu/list", method = RequestMethod.GET)
	public void listGET(HMap hmap, Model model) {
		hmap.put(Define.MENU_CODE, Define.ROOT_MENU_CODE);
		model.addAttribute("root_menu_list", menuService.rootMenuList(hmap));
		model.addAttribute("not_add_root_level_list", menuService.notAddRootMenuList(hmap));
	}
}
