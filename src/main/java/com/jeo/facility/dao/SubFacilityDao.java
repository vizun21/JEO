package com.jeo.facility.dao;

import com.jeo.common.dao.AbstractDao;
import com.jeo.facility.domain.SubFacility;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class SubFacilityDao extends AbstractDao {
	private static String namespace = "sub.facility";

	public List<SubFacility> selectSubFacilityList(String facility_tag_no) {
		return selectList(namespace + ".selectList", facility_tag_no);
	}

	public int insert(SubFacility subFacility) {
		return insert(namespace + ".insert", subFacility);
	}

	public int update(SubFacility subFacility) {
		return update(namespace + ".update", subFacility);
	}
}
