package com.jeo.webapp.admin.system.code.service;

import com.jeo.common.config.Define;
import com.jeo.common.domain.HMap;
import com.jeo.common.util.CommonUtils;
import com.jeo.position.domain.CodeDetail;
import com.jeo.webapp.admin.system.code.dao.CodeDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CodeService {
	@Autowired CodeDao codeDao;

	public <T> List<T> codePage(HMap hmap) {
		return codeDao.codePage(hmap.getMap());
	}

	public int codeRegist(HMap hmap) {
		return codeDao.codeRegist(hmap.getMap());
	}

	public <T> List<T> overlapCheck(HMap hmap) {
		return codeDao.codeList(hmap.getMap());
	}

	public <T> List<T> codeDetailList(HMap hmap) {
		return codeDao.codeDetailList(hmap.getMap());
	}

	public <T> List<T> datailOverlapCheck(HMap hmap) {
		return codeDao.codeDetailList(hmap.getMap());
	}

	public int codeDetailRegist(HMap hmap) {
		return codeDao.codeDetailRegist(hmap.getMap());
	}

	public int codeDetailRegist(CodeDetail codeDetail) {
		return codeDao.codeDetailRegist(codeDetail);
	}

	@Transactional
	public void codeDetailSort(HMap hmap) {
		List<String> cddt_val_list = hmap.getList("cddt_val_list");
		if (CommonUtils.isNotEmpty(cddt_val_list)) {
			for (int i = 0; i < cddt_val_list.size(); i++) {
				HMap param = new HMap();
				param.put(Define.CODE_ID, hmap.getString(Define.CODE_ID));
				param.put(Define.CDDT_SEQ, i+1);
				param.put(Define.CDDT_VAL, cddt_val_list.get(i));
				param.put(Define.USER_ID, hmap.getString(Define.USER_ID));
				codeDao.codeDetailSort(param.getMap());
			}
		}
	}
}
