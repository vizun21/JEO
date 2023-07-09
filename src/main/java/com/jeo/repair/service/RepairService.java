package com.jeo.repair.service;

import com.jeo.facility.domain.FacilityRepairHistory;
import com.jeo.facility.dto.RepairPageCondition;
import com.jeo.repair.dao.RepairDao;
import com.jeo.repair.domain.Repair;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RepairService {
	@Autowired
	RepairDao repairDao;

	public int insert(Repair repair) {
		return repairDao.insert(repair);
	}

	public Repair selectRepair(String repair_no) {
		return repairDao.selectRepair(repair_no);
	}

	public List<Repair> facilityRepairListByTagNo(String facility_tag_no) {
		return repairDao.facilityRepairListByTagNo(facility_tag_no);
	}

	public List<Repair> selectRepairList(RepairPageCondition condition) {
		return repairDao.selectRepairList(condition);
	}

	public List<FacilityRepairHistory> selectFacilityRepairHistory(RepairPageCondition condition) {
		return repairDao.selectFacilityRepairHistory(condition);
	}

	public int updateRepair(Repair repair) {
		return repairDao.updateRepair(repair);
	}

	public int deleteRepair(String repair_no) {
		return repairDao.deleteRepair(repair_no);
	}
}
