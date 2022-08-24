package com.jeo.webapp.admin.system.menu.service;

import com.jeo.common.config.Define;
import com.jeo.common.domain.HMap;
import com.jeo.common.exception.AlertException;
import com.jeo.common.util.CommonUtils;
import com.jeo.webapp.admin.system.menu.dao.MenuDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class MenuService {
	@Autowired MenuDao menuDao;

	public <T> T menuItem(HMap hmap) {
		return menuDao.menuItem(hmap.getMap());
	}

	@Transactional
	public void menuSort(HMap hmap) {
		List<String> menu_code_list = hmap.getList("menu_code_list");
		if (CommonUtils.isNotEmpty(menu_code_list)) {
			for (int i = 0; i < menu_code_list.size(); i++) {
				HMap param = new HMap();
				param.put(Define.HIGH_MENU_CODE, hmap.getString(Define.HIGH_MENU_CODE));
				param.put(Define.MENU_SEQ, i+1);
				param.put(Define.MENU_CODE, menu_code_list.get(i));
				param.put(Define.USER_ID, hmap.getString(Define.USER_ID));
				menuDao.menuSort(param.getMap());
			}
		}
	}

	public int menuRegist(HMap hmap) {
		return menuDao.menuRegist(hmap.getMap());
	}

	public int menuDelete(HMap hmap) {
		HMap param = new HMap();
		param.put(Define.HIGH_MENU_CODE, hmap.getString(Define.MENU_CODE));
		param.put(Define.MENU_LEVEL, hmap.getString(Define.MENU_LEVEL));

		List<Map<String, Object>> list = menuDao.menuList(param.getMap());
		if (list.size() > 0) {
			throw new AlertException("하위메뉴가 등록되어 있어 삭제가 불가합니다.");
		}

		return menuDao.menuDelete(hmap.getMap());
	}

	public <T> List<T> menuTree(HMap hmap) {
		return menuDao.menuTree(hmap.getMap());
	}

	public <T> List<T> menuList(HMap hmap) {
		return menuDao.menuList(hmap.getMap());
	}

	public <T> List<T> breadcrumb(HMap hmap) {
		return menuDao.breadcrumb(hmap.getMap());
	}

	public <T> List<T> rootMenuList(HMap hmap) {
		return menuDao.rootMenuList(hmap.getMap());
	}

	public <T> List<T> notAddRootMenuList(HMap hmap) {
		return menuDao.notAddRootMenuList(hmap.getMap());
	}
}
