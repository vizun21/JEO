package com.jeo.webapp.accounting.smok.service;

import com.jeo.common.config.Define;
import com.jeo.common.domain.HMap;
import com.jeo.common.exception.AlertException;
import com.jeo.webapp.accounting.smok.dao.SmokDao;
import com.jeo.webapp.accounting.tran.dao.TranDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class SmokService {
	@Autowired SmokDao smokDao;
	@Autowired TranDao tranDao;

	public <T> List<T> smokPage(HMap hmap) {
		return smokDao.smokPage(hmap.getMap());
	}

	public <T> List<T> smokList(HMap hmap) {
		return smokDao.smokList(hmap.getMap());
	}

	public int smokRegist(HMap hmap) {
		String mock_code = hmap.getString(Define.MOCK_CODE);
		String smok_numb = String.format("%02d", hmap.getInt(Define.SMOK_NUMB));

		hmap.put(Define.SMOK_CODE, mock_code + smok_numb);
		return smokDao.smokRegist(hmap.getMap());
	}

	public <T> T smokItem(HMap hmap) {
		return smokDao.smokItem(hmap.getMap());
	}

	public int smokModify(HMap hmap) {
		return smokDao.smokModify(hmap.getMap());
	}

	public int smokDelete(HMap hmap) {
		List<Map<String, Object>> list = tranDao.tranList(hmap.getMap());
		if (list.size() > 0) {
			throw new AlertException("거래등록에 사용되어 삭제할 수 없습니다.");
		}
		return smokDao.smokDelete(hmap.getMap());
	}
}
