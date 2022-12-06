package com.jeo.facility.dao;

import com.jeo.common.dao.AbstractDao;
import com.jeo.facility.domain.Facility;
import com.jeo.facility.dto.FacilityPageCondition;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class FacilityDao extends AbstractDao {
	private static String namespace = "facility";

	public List<Facility> selectFacilityList() {
		return selectList(namespace + ".selectList");
	}

	public Facility selectFacility(String facility_tag_no) {
		return selectOne(namespace + ".select", facility_tag_no);
	}

	public int insert(Facility facility) {
		return insert(namespace + ".insert", facility);
	}

	public int update(Facility facility) {
		return update(namespace + ".update", facility);
	}

	public List<Facility> findFacilitiesByKeywordInTagNoOrName(String keyword) {
		return selectList(namespace + ".findFacilitiesByKeywordInTagNoOrName", keyword);
	}

	public List<Facility> selectFacilityList(FacilityPageCondition condition) {
		return selectList(namespace + ".selectList", condition);
	}
}
