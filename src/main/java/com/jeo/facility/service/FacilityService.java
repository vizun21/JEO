package com.jeo.facility.service;

import com.jeo.facility.dao.FacilityDao;
import com.jeo.facility.dao.SubFacilityDao;
import com.jeo.facility.domain.Facility;
import com.jeo.facility.dto.FacilityPageCondition;
import com.jeo.repair.dao.RepairDao;
import com.jeo.repair.service.RepairService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FacilityService {
	@Autowired
	FacilityDao facilityDao;

	@Autowired
	SubFacilityDao subFacilityDao;

	@Autowired
	RepairDao repairDao;

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

	public List<Facility> findFacilitiesByKeywordInTagNoOrName(String keyword) {
		return facilityDao.findFacilitiesByKeywordInTagNoOrName(keyword);
	}

	public List<Facility> selectFacilityList(FacilityPageCondition condition) {
		return facilityDao.selectFacilityList(condition);
	}

	public int deleteFacility(String facility_tag_no) {
		subFacilityDao.deleteSubFacility(facility_tag_no);
		repairDao.deleteRepairs(facility_tag_no);
		return facilityDao.deleteFacility(facility_tag_no);
	}
}
