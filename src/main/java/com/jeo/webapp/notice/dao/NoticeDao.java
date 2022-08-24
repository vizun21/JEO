package com.jeo.webapp.notice.dao;

import com.jeo.common.dao.AbstractDao;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class NoticeDao extends AbstractDao {
	private static String namespace = "accounting.notice";

	public <T> List<T> noticePage(Map<String, Object> map) {
		return selectList(namespace + ".noticePage", map);
	}

	public int noticeRegist(Map<String, Object> map) {
		return insert(namespace + ".noticeRegist", map);
	}

	public <T> T noticeItem(Map<String, Object> map) {
		return selectOne(namespace + ".noticeList", map);
	}

	public int noticeModify(Map<String, Object> map) {
		return update(namespace + ".noticeModify", map);
	}
}
