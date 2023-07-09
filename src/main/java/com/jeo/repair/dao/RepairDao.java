package com.jeo.repair.dao;

import com.jeo.common.dao.AbstractDao;
import com.jeo.facility.domain.FacilityRepairHistory;
import com.jeo.facility.dto.RepairPageCondition;
import com.jeo.repair.domain.Repair;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class RepairDao extends AbstractDao {
	private static String namespace = "repair";

	public int insert(Repair repair) {
		return insert(namespace + ".insert", repair);
	}

	public Repair selectRepair(String repair_no) {
		return selectOne(namespace + ".selectRepair", repair_no);
	}

	public List<Repair> facilityRepairListByTagNo(String facility_tag_no) {
		return selectList(namespace + ".facilityRepairListByTagNo", facility_tag_no);
	}

	public List<Repair> selectRepairList(RepairPageCondition condition) {
		return selectList(namespace + ".selectRepairList", condition);
	}

	public List<FacilityRepairHistory> selectFacilityRepairHistory(RepairPageCondition condition) {
		return selectList(namespace + ".selectFacilityRepairHistory", condition);
	}

	public int updateRepair(Repair repair) {
		return update(namespace + ".updateRepair", repair);
	}

	public int deleteRepair(String repair_no) {
		return delete(namespace + ".deleteRepair", repair_no);
	}

    public int deleteRepairs(String facilityTagNo) {
		return delete(namespace + ".deleteRepairs", facilityTagNo);
    }
}
