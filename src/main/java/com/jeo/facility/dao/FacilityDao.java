package com.jeo.facility.dao;

import com.jeo.common.dao.AbstractDao;
import com.jeo.facility.domain.Facility;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class FacilityDao extends AbstractDao {
	private static String namespace = "facility";

	public List<Facility> selectFacilityList() {
		return selectList(namespace + ".select");
	}
}
