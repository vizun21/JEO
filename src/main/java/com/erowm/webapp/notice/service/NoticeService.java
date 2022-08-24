package com.erowm.webapp.notice.service;

import com.erowm.common.domain.HMap;
import com.erowm.webapp.notice.dao.NoticeDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NoticeService {
	@Autowired NoticeDao noticeDao;

	public <T> List<T> noticePage(HMap hmap) {
		return noticeDao.noticePage(hmap.getMap());
	}

	public int noticeRegist(HMap hmap) {
		return noticeDao.noticeRegist(hmap.getMap());
	}

	public <T> T noticeItem(HMap hmap) {
		return noticeDao.noticeItem(hmap.getMap());
	}

	public int noticeModify(HMap hmap) {
		return noticeDao.noticeModify(hmap.getMap());
	}
}
