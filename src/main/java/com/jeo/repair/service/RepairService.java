package com.jeo.repair.service;

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

	public List<Repair> facilityRepairListByTagNo(String facility_tag_no) {
		return repairDao.facilityRepairListByTagNo(facility_tag_no);
	}
}