package com.jeo.facility.service;

import com.jeo.facility.dao.SubFacilityDao;
import com.jeo.facility.domain.SubFacility;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SubFacilityService {
	@Autowired
	SubFacilityDao subFacilityDao;

	public List<SubFacility> selectSubFacilityList(String facility_tag_no) {
		return subFacilityDao.selectSubFacilityList(facility_tag_no);
	}

	public int insert(SubFacility subFacility) {
		return subFacilityDao.insert(subFacility);
	}

	public int update(SubFacility subFacility) {
		return subFacilityDao.update(subFacility);
	}
}
