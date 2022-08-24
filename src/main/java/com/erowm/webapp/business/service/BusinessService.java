package com.erowm.webapp.business.service;

import com.erowm.common.domain.HMap;
import com.erowm.webapp.business.dao.BusinessDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BusinessService {
	@Autowired BusinessDao businessDao;

	public <T> T businessVO(HMap hmap) {
		return businessDao.businessVO(hmap.getMap());
	}

	public <T> List<T> businessPage(HMap hmap) {
		return businessDao.businessPage(hmap.getMap());
	}

	public <T> List<T> businessList(HMap hmap) {
		return businessDao.businessList(hmap.getMap());
	}

	public <T> T businessItem(HMap hmap) {
		return businessDao.businessItem(hmap.getMap());
	}

	public int businessRegist(HMap hmap) {
		return businessDao.businessRegist(hmap.getMap());
	}

	public int businessModify(HMap hmap) {
		return businessDao.businessModify(hmap.getMap());
	}
}
