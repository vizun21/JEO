package com.erowm.webapp.ghm.dao;

import com.erowm.common.dao.AbstractDao;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class GhmDao extends AbstractDao {
	private static String namespace = "system.ghm";

	public <T> List<T> ghmPage(Map<String, Object> map) {
		return selectList(namespace + ".ghmPage", map);
	}

	public <T> T ghmItem(Map<String, Object> map) {
		return selectOne(namespace + ".ghmList", map);
	}

	public <T> List<T> overlapCheck(Map<String, Object> map) {
		return selectList(namespace + ".ghmList", map);
	}

	public int ghmRegist(Map<String, Object> map) {
		return insert(namespace + ".ghmRegist", map);
	}

	public <T> List<T> ghmYear(Map<String, Object> map) {
		return selectList(namespace + ".ghmYear", map);
	}

	public <T> List<T> ghmSubPage(Map<String, Object> map) {
		return selectList(namespace + ".ghmSubPage", map);
	}

	public int ghmActivate(Map<String, Object> map) {
		return update(namespace + ".ghmActivate", map);
	}

	/* 관 관련 */
	public <T> List<T> gwanOverlapCheck(Map<String, Object> map) {
		return selectList(namespace + ".gwanList", map);
	}

	public int gwanRegist(Map<String, Object> map) {
		return insert(namespace + ".gwanRegist", map);
	}

	public <T> T gwanItem(Map<String, Object> map) {
		return selectOne(namespace + ".gwanList", map);
	}

	public int gwanModify(Map<String, Object> map) {
		return update(namespace + ".gwanModify", map);
	}

	public int gwanDelete(Map<String, Object> map) {
		return delete(namespace + ".gwanDelete", map);
	}

	public <T> List<T> gwanList(Map<String, Object> map) {
		return selectList(namespace + ".gwanList", map);
	}

	/* 항 관련 */
	public <T> List<T> hangOverlapCheck(Map<String, Object> map) {
		return selectList(namespace + ".hangList", map);
	}

	public int hangRegist(Map<String, Object> map) {
		return insert(namespace + ".hangRegist", map);
	}

	public <T> T hangItem(Map<String, Object> map) {
		return selectOne(namespace + ".hangList", map);
	}

	public int hangModify(Map<String, Object> map) {
		return update(namespace + ".hangModify", map);
	}

	public int hangDelete(Map<String, Object> map) {
		return delete(namespace + ".hangDelete", map);
	}

	public <T> List<T> hangList(Map<String, Object> map) {
		return selectList(namespace + ".hangList", map);
	}

	/* 목 관련 */
	public <T> List<T> mockOverlapCheck(Map<String, Object> map) {
		return selectList(namespace + ".mockList", map);
	}

	public int mockRegist(Map<String, Object> map) {
		return insert(namespace + ".mockRegist", map);
	}

	public <T> T mockItem(Map<String, Object> map) {
		return selectOne(namespace + ".mockList", map);
	}

	public int mockModify(Map<String, Object> map) {
		return update(namespace + ".mockModify", map);
	}

	public int mockDelete(Map<String, Object> map) {
		return delete(namespace + ".mockDelete", map);
	}

	public <T> List<T> mockList(Map<String, Object> map) {
		return selectList(namespace + ".mockList", map);
	}


	public <T> List<T> ghmReportList(Map<String, Object> map) {
		return selectList(namespace + ".ghmReportList", map);
	}

	public int ghmReportRegist(Map<String, Object> map) {
		return insert(namespace + ".ghmReportRegist", map);
	}

	public int ghmReportModify(Map<String, Object> map) {
		return update(namespace + ".ghmReportModify", map);
	}

	public int ghmReportDelete(Map<String, Object> map) {
		return delete(namespace + ".ghmReportDelete", map);
	}
}
