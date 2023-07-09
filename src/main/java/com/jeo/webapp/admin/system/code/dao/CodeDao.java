package com.jeo.webapp.admin.system.code.dao;

import com.jeo.common.dao.AbstractDao;
import com.jeo.position.domain.CodeDetail;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class CodeDao extends AbstractDao {
	private static String namespace = "system.code";

	public <T> List<T> codePage(Map<String, Object> map) {
		return selectList(namespace + ".codePage", map);
	}

	public int codeRegist(Map<String, Object> map) {
		return insert(namespace + ".codeRegist", map);
	}

	public <T> List<T> codeList(Map<String, Object> map) {
		return selectList(namespace + ".codeList", map);
	}

	public <T> List<T> codeDetailList(Map<String, Object> map) {
		return selectList(namespace + ".codeDetailList", map);
	}

	public int codeDetailRegist(Map<String, Object> map) {
		return insert(namespace + ".codeDetailRegist", map);
	}

	public int codeDetailRegist(CodeDetail codeDetail) {
		return insert(namespace + ".codeDetailRegist", codeDetail);
	}

	public int codeDetailSort(Map<String, Object> map) {
		return update(namespace + ".codeDetailSort", map);
	}
}
