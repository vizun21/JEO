package com.jeo.repair.dao;

import com.jeo.common.dao.AbstractDao;
import com.jeo.repair.domain.Repair;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class RepairDao extends AbstractDao {
	private static String namespace = "repair";

	public int insert(Repair repair) {
		return insert(namespace + ".insert", repair);
	}

	public List<Repair> facilityRepairListByTagNo(String facility_tag_no) {
		return selectList(namespace + ".facilityRepairListByTagNo", facility_tag_no);
	}
}
