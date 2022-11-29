package com.jeo.facility.service;

import com.jeo.facility.dao.FacilityDao;
import com.jeo.facility.domain.Facility;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FacilityService {
	@Autowired
	FacilityDao facilityDao;

	public List<Facility> selectFacilityList() {
		return facilityDao.selectFacilityList();
	}

	public Facility selectFacility(String facility_tag_no) {
		return facilityDao.selectFacility(facility_tag_no);
	}

	public int insert(Facility facility) {
		return facilityDao.insert(facility);
	}

	public int update(Facility facility) {
		return facilityDao.update(facility);
	}
}
