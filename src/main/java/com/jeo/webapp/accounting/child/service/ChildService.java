package com.jeo.webapp.accounting.child.service;

import com.jeo.common.domain.HMap;
import com.jeo.webapp.accounting.child.dao.ChildDao;
import com.jeo.webapp.accounting.parent.service.ParentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ChildService {
	@Autowired ChildDao childDao;
	@Autowired ParentService parentService;

	public <T> List<T> childPage(HMap hmap) {
		return childDao.childPage(hmap.getMap());
	}

	public <T> T childItem(HMap hmap) {
		return childDao.childItem(hmap.getMap());
	}

	@Transactional
	public void childRegist(HMap hmap) {
		childDao.childRegist(hmap.getMap());
		parentService.parentListModify(hmap);
	}

	@Transactional
	public void childModify(HMap hmap) {
		childDao.childModify(hmap.getMap());
		parentService.parentListModify(hmap);
	}
}
