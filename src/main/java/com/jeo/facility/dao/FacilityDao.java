package com.jeo.facility.dao;

import com.jeo.common.dao.AbstractDao;
import com.jeo.facility.domain.Facility;
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

	public List<Facility> findFacilitiesByTagNo(String facility_tag_no) {
		return selectList(namespace + ".findFacilitiesByTagNo", facility_tag_no);
	}
}
