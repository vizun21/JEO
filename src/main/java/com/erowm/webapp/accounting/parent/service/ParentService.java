package com.erowm.webapp.accounting.parent.service;

import com.erowm.common.config.Define;
import com.erowm.common.domain.HMap;
import com.erowm.common.util.CommonUtils;
import com.erowm.webapp.accounting.parent.dao.ParentDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ParentService {
	@Autowired
	ParentDao parentDao;

	public <T> List<T> parentList(HMap hmap) {
		return parentDao.parentList(hmap.getMap());
	}

	@Transactional
	public void parentListModify(HMap hmap) {
		List<String> parent_code_list = hmap.getList("parent_code_list");
		List<String> parent_type_list = hmap.getList("parent_type_list");
		List<String> parent_name_list = hmap.getList("parent_name_list");
		List<String> parent_reg_numb_1_list = hmap.getList("parent_reg_numb_1_list");
		List<String> parent_reg_numb_2_list = hmap.getList("parent_reg_numb_2_list");
		List<String> parent_mobile_list = hmap.getList("parent_mobile_list");
		List<String> delete_parent_code_list = hmap.getList("delete_parent_code_list");

		if (CommonUtils.isNotEmpty(delete_parent_code_list)) {
			for (String parent_code : delete_parent_code_list) {
				HMap param = new HMap();
				param.put(Define.COMP_CODE, hmap.getString(Define.COMP_CODE));
				param.put(Define.BSNS_CODE, hmap.getString(Define.BSNS_CODE));
				param.put(Define.CHILD_CODE, hmap.getString(Define.CHILD_CODE));
				param.put(Define.PARENT_CODE, parent_code);
				parentDao.parentDelete(param.getMap());
			}
		}

		if (CommonUtils.isNotEmpty(parent_code_list)) {
			for (int i = 0; i < parent_code_list.size(); i++) {
				hmap.put(Define.PARENT_CODE, parent_code_list.get(i));
				hmap.put(Define.PARENT_TYPE, parent_type_list.get(i));
				hmap.put(Define.PARENT_NAME, parent_name_list.get(i));
				hmap.put(Define.PARENT_REG_NUMB_1, parent_reg_numb_1_list.get(i));
				hmap.put(Define.PARENT_REG_NUMB_2, parent_reg_numb_2_list.get(i));
				hmap.put(Define.PARENT_MOBILE, parent_mobile_list.get(i));
				if (CommonUtils.isEmpty(parent_code_list.get(i))) {
					parentRegist(hmap);
				} else {
					parentModify(hmap);
				}
			}
		}
	}

	public int parentRegist(HMap hmap) {
		return parentDao.parentRegist(hmap.getMap());
	}

	public int parentModify(HMap hmap) {
		return parentDao.parentModify(hmap.getMap());
	}
}
