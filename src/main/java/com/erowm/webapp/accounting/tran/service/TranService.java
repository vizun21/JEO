package com.erowm.webapp.accounting.tran.service;

import com.erowm.common.config.Define;
import com.erowm.common.domain.HMap;
import com.erowm.common.exception.AlertException;
import com.erowm.common.util.CommonUtils;
import com.erowm.webapp.accounting.deadline.service.DeadlineService;
import com.erowm.webapp.accounting.tran.dao.TranDao;
import com.erowm.webapp.ghm.dao.GhmDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigInteger;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

@Service
public class TranService {
	@Autowired TranDao tranDao;
	@Autowired DeadlineService deadlineService;
	@Autowired GhmDao ghmDao;

	public <T> List<T> tranPage(HMap hmap) {
		int year = hmap.getInt(Define.YEAR);
		int month = hmap.getInt(Define.MONTH);
		hmap.put("balance_year", month == 1 ? year - 1 : year);
		hmap.put("balance_month", month == 1 ? 12 : month - 1);
		return tranDao.tranPage(hmap.getMap());
	}

	public <T> List<T> tranList(HMap hmap) {
		return tranDao.tranList(hmap.getMap());
	}

	public void tranRegist(HMap hmap) {
		String tran_date[] = hmap.getString(Define.TRAN_DATE).split("-");
		hmap.put(Define.YEAR, tran_date[0]);
		hmap.put(Define.MONTH, tran_date[1]);

		if (!deadlineService.prevIsClosed(hmap)) throw new AlertException("전월 마감처리 후 등록가능합니다.");
		if (deadlineService.isClosed(hmap)) throw new AlertException("해당월은 마감처리되어 거래등록이 불가합니다.");

		tranDao.tranRegist(hmap.getMap());
	}

	public void tranModify(HMap hmap) {
		String tran_date[] = hmap.getString(Define.TRAN_DATE).split("-");
		hmap.put(Define.YEAR, tran_date[0]);
		hmap.put(Define.MONTH, tran_date[1]);

		if (!deadlineService.prevIsClosed(hmap)) throw new AlertException("전월 마감처리 후 등록가능합니다.");
		if (deadlineService.isClosed(hmap)) throw new AlertException("해당월은 마감처리되어 거래수정이 불가합니다.");

		tranDao.tranModify(hmap.getMap());
	}

	public void tranDelete(HMap hmap) {
		String tran_date[] = hmap.getString(Define.TRAN_DATE).split("-");
		hmap.put(Define.YEAR, tran_date[0]);
		hmap.put(Define.MONTH, tran_date[1]);

		if (deadlineService.isClosed(hmap)) throw new AlertException("해당월은 마감처리되어 거래삭제가 불가합니다.");

		tranDao.tranDelete(hmap.getMap());
	}

	@Transactional
	public void tranListRegist(HMap hmap) {
		List<String> bktr_code_list = hmap.getList("bktr_code_list");
		List<String> tran_date_list = hmap.getList("tran_date_list");
		List<String> tran_io_type_list = hmap.getList("tran_io_type_list");
		List<String> tran_price_list = hmap.getList("tran_price_list");
		List<String> tran_jukyo_list = hmap.getList("tran_jukyo_list");
		List<String> mock_code_list = hmap.getList("mock_code_list");
		List<String> smok_code_list = hmap.getList("smok_code_list");
		List<String> rel_gwan_code_list = hmap.getList("rel_gwan_code_list");
		List<String> rel_mock_code_list = hmap.getList("rel_mock_code_list");
		List<String> tran_note_list = hmap.getList("tran_note_list");

		if (CommonUtils.isNotEmpty(bktr_code_list)) {
			for (int i = 0; i < bktr_code_list.size(); i++) {
				hmap.put(Define.BKTR_CODE, bktr_code_list.get(i));
				hmap.put(Define.TRAN_DATE, tran_date_list.get(i));
				hmap.put(Define.TRAN_IO_TYPE, tran_io_type_list.get(i));
				hmap.put(Define.TRAN_PRICE, tran_price_list.get(i));
				hmap.put(Define.TRAN_JUKYO, tran_jukyo_list.get(i));
				hmap.put(Define.MOCK_CODE, mock_code_list.get(i));
				hmap.put(Define.SMOK_CODE, smok_code_list.get(i).equals("") ? null : smok_code_list.get(i));
				hmap.put(Define.REL_GWAN_CODE, rel_gwan_code_list.get(i).equals("") ? null : rel_gwan_code_list.get(i));
				hmap.put(Define.REL_MOCK_CODE, rel_mock_code_list.get(i).equals("") ? null : rel_mock_code_list.get(i));
				if (CommonUtils.isNotEmpty(tran_note_list)) {
					hmap.put(Define.TRAN_NOTE, tran_note_list.get(i).equals("") ? null : tran_note_list.get(i));
				}
				tranRegist(hmap);
			}
		}
	}

	@Transactional
	public void tranListModify(HMap hmap) {
		List<String> tran_code_list = hmap.getList("tran_code_list");
		List<String> bktr_code_list = hmap.getList("bktr_code_list");
		List<String> tran_date_list = hmap.getList("tran_date_list");
		List<String> tran_io_type_list = hmap.getList("tran_io_type_list");
		List<String> tran_price_list = hmap.getList("tran_price_list");
		List<String> tran_jukyo_list = hmap.getList("tran_jukyo_list");
		List<String> mock_code_list = hmap.getList("mock_code_list");
		List<String> smok_code_list = hmap.getList("smok_code_list");
		List<String> rel_gwan_code_list = hmap.getList("rel_gwan_code_list");
		List<String> rel_mock_code_list = hmap.getList("rel_mock_code_list");
		List<String> tran_note_list = hmap.getList("tran_note_list");
		List<String> delete_tran_code_list = hmap.getList("delete_tran_code_list");

		if (CommonUtils.isNotEmpty(delete_tran_code_list)) {
			for (String tran_code : delete_tran_code_list) {
				HMap param = new HMap();
				param.put(Define.COMP_CODE, hmap.getString(Define.COMP_CODE));
				param.put(Define.BSNS_CODE, hmap.getString(Define.BSNS_CODE));
				param.put(Define.TRAN_CODE, tran_code);
				tranDao.tranDelete(param.getMap());
			}
		}

		if (CommonUtils.isNotEmpty(bktr_code_list)) {
			for (int i = 0; i < bktr_code_list.size(); i++) {
				hmap.put(Define.TRAN_CODE, tran_code_list.get(i));
				hmap.put(Define.BKTR_CODE, bktr_code_list.get(i));
				hmap.put(Define.TRAN_DATE, tran_date_list.get(i));
				hmap.put(Define.TRAN_IO_TYPE, tran_io_type_list.get(i));
				hmap.put(Define.TRAN_PRICE, tran_price_list.get(i));
				hmap.put(Define.TRAN_JUKYO, tran_jukyo_list.get(i));
				hmap.put(Define.MOCK_CODE, mock_code_list.get(i));
				hmap.put(Define.SMOK_CODE, smok_code_list.get(i).equals("") ? null : smok_code_list.get(i));
				hmap.put(Define.REL_GWAN_CODE, rel_gwan_code_list.get(i).equals("") ? null : rel_gwan_code_list.get(i));
				hmap.put(Define.REL_MOCK_CODE, rel_mock_code_list.get(i).equals("") ? null : rel_mock_code_list.get(i));
				hmap.put(Define.TRAN_NOTE, tran_note_list.get(i).equals("") ? null : tran_note_list.get(i));

				if (CommonUtils.isEmpty(tran_code_list.get(i))) {
					tranRegist(hmap);
				} else {
					tranModify(hmap);
				}
			}
		}
	}

	@Transactional
	public void tranListDelete(HMap hmap) {
		List<String> bktr_code_list = hmap.getList("bktr_code_list");
		List<String> tran_code_list = hmap.getList("tran_code_list");

		if (CommonUtils.isNotEmpty(bktr_code_list)) {
			for (int i = 0; i < bktr_code_list.size(); i++) {
				HMap param = new HMap();
				param.put(Define.COMP_CODE, hmap.getString(Define.COMP_CODE));
				param.put(Define.BSNS_CODE, hmap.getString(Define.BSNS_CODE));

				if (CommonUtils.isNotEmpty(bktr_code_list.get(i))) {
					// 은행거래내역 참조항목인 경우 BKTR_CODE로 일괄삭제
					param.put(Define.BKTR_CODE, bktr_code_list.get(i));

					List<Map<String, Object>> list = tranList(param);
					for (Map<String, Object> tran : list) {
						param.put(Define.TRAN_CODE, tran.get(Define.TRAN_CODE));
						param.put(Define.TRAN_DATE, tran.get(Define.TRAN_DATE));
						tranDelete(param);
					}
				} else {
					// 은행거래내역 미참조항목인 경우 TRAN_CODE 개별삭제
					param.put(Define.TRAN_CODE, tran_code_list.get(i));
					Map<String, Object> tran = tranItem(param);
					param.put(Define.TRAN_DATE, tran.get(Define.TRAN_DATE));
					tranDelete(param);
				}
			}
		}
	}

	public void tranDirectRegist(HMap hmap) {
		hmap.put(Define.SMOK_CODE, hmap.getString(Define.SMOK_CODE).equals("") ? null : hmap.getString(Define.SMOK_CODE));
		hmap.put(Define.REL_GWAN_CODE, hmap.getString(Define.REL_GWAN_CODE).equals("") ? null : hmap.getString(Define.REL_GWAN_CODE));
		hmap.put(Define.REL_MOCK_CODE, hmap.getString(Define.REL_MOCK_CODE).equals("") ? null : hmap.getString(Define.REL_MOCK_CODE));
		tranRegist(hmap);
	}

	public void tranDirectModify(HMap hmap) {
		hmap.put(Define.SMOK_CODE, hmap.getString(Define.SMOK_CODE).equals("") ? null : hmap.getString(Define.SMOK_CODE));
		hmap.put(Define.REL_GWAN_CODE, hmap.getString(Define.REL_GWAN_CODE).equals("") ? null : hmap.getString(Define.REL_GWAN_CODE));
		hmap.put(Define.REL_MOCK_CODE, hmap.getString(Define.REL_MOCK_CODE).equals("") ? null : hmap.getString(Define.REL_MOCK_CODE));
		tranModify(hmap);
	}

	public <T> T tranItem(HMap hmap) {
		return tranDao.tranItem(hmap.getMap());
	}

	public BigInteger tranAmount(HMap hmap) {
		return tranDao.tranAmount(hmap.getMap());
	}

	public <T> List<T> tranDuplicateList(HMap hmap) {
		return tranDao.tranDuplicateList(hmap.getMap());
	}

	public <T> List<T> ghmReportList(HMap hmap) {
		int start_year = hmap.getInt(Define.YEAR);
		int start_month = hmap.getInt(Define.MONTH);
		int bsns_sess_start_month = hmap.getInt(Define.BSNS_SESS_START_MONTH);

		int session_year = bsns_sess_start_month <= start_month ? start_year : start_year-1;
		hmap.put(Define.SESSION_YEAR, session_year);
		hmap.put("ghm_year", session_year);

		try {
			Map<String, Object> ghmItem = ghmDao.ghmItem(hmap.getMap());
			hmap.put(Define.GHM_CODE, ghmItem.get(Define.GHM_CODE));

			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cal = Calendar.getInstance();
			cal.set(start_year, start_month-1, 1);
			hmap.put(Define.START_DATE, df.format(cal.getTime()));

			cal.add(Calendar.MONTH, 1);
			hmap.put(Define.END_DATE, df.format(cal.getTime()));
			return tranDao.ghmReportList(hmap.getMap());
		} catch (NullPointerException e) {
			return new LinkedList<>();
		}
	}
}
