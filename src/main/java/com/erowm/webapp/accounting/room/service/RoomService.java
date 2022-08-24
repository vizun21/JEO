package com.erowm.webapp.accounting.room.service;

import com.erowm.common.domain.HMap;
import com.erowm.webapp.accounting.room.dao.RoomDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoomService {
	@Autowired
	RoomDao roomDao;

	public <T> List<T> roomPage(HMap hmap) {
		return roomDao.roomPage(hmap.getMap());
	}

	public <T> T roomItem(HMap hmap) {
		return roomDao.roomItem(hmap.getMap());
	}

	public int roomRegist(HMap hmap) {
		return roomDao.roomRegist(hmap.getMap());
	}

	public int roomModify(HMap hmap) {
		return roomDao.roomModify(hmap.getMap());
	}

	public <T> List<T> roomList(HMap hmap) {
		return roomDao.roomList(hmap.getMap());
	}
}
