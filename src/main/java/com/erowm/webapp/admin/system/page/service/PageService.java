package com.erowm.webapp.admin.system.page.service;

import com.erowm.common.config.Define;
import com.erowm.common.domain.HMap;
import com.erowm.common.exception.AlertException;
import com.erowm.webapp.admin.system.menu.service.MenuService;
import com.erowm.webapp.admin.system.page.dao.PageDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Service
public class PageService {
	@Autowired PageDao pageDao;
	@Autowired MenuService menuService;

	public <T> List<T> pageList(HMap hmap) {
		return pageDao.pageList(hmap.getMap());
	}

	public <T> T pageItem(HMap hmap) {
		return pageDao.pageItem(hmap.getMap());
	}

	public int pageRegist(HMap hmap) {
		return pageDao.pageRegist(hmap.getMap());
	}

	public int pageModify(HMap hmap) {
		return pageDao.pageModify(hmap.getMap());
	}

	public <T> List<T> overlapCheck(HMap hmap) {
		return pageDao.pageList(hmap.getMap());
	}

	public int pageDelete(HMap hmap) throws SQLException {
		hmap.put(Define.MENU_CODE, hmap.getString(Define.PAGE_CODE));
		List<Map<String, Object>> list = menuService.menuList(hmap);
		if (list.size() > 0) {
			throw new AlertException("메뉴에 등록되어 삭제가 불가합니다.");
		}
		return pageDao.pageDelete(hmap.getMap());
	}
}
