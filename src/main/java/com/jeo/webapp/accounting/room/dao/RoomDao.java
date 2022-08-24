package com.jeo.webapp.accounting.room.dao;

import com.jeo.common.dao.AbstractDao;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class RoomDao extends AbstractDao {
	private static String namespace = "accounting.room";

	public <T> List<T> roomPage(Map<String, Object> map) {
		return selectList(namespace + ".roomPage", map);
	}

	public <T> T roomItem(Map<String, Object> map) {
		return selectOne(namespace + ".roomList", map);
	}

	public int roomRegist(Map<String, Object> map) {
		return insert(namespace + ".roomRegist", map);
	}

	public int roomModify(Map<String, Object> map) {
		return update(namespace + ".roomModify", map);
	}

	public <T> List<T> roomList(Map<String, Object> map) {
		return selectList(namespace + ".roomList", map);
	}
}
