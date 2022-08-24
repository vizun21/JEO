package com.erowm.webapp.ghm.service;

import com.erowm.common.config.Define;
import com.erowm.common.domain.HMap;
import com.erowm.common.util.CommonUtils;
import com.erowm.webapp.accounting.budget.dao.BudgetDao;
import com.erowm.webapp.accounting.tran.dao.TranDao;
import com.erowm.webapp.ghm.dao.GhmDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Service
public class GhmService {
	@Autowired GhmDao ghmDao;
	@Autowired TranDao tranDao;
	@Autowired BudgetDao budgetDao;

	public <T> List<T> ghmPage(HMap hmap) {
		return ghmDao.ghmPage(hmap.getMap());
	}

	public <T> T ghmItem(HMap hmap) {
		return ghmDao.ghmItem(hmap.getMap());
	}

	public <T> List<T> overlapCheck(HMap hmap) {
		return ghmDao.overlapCheck(hmap.getMap());
	}

	public int ghmRegist(HMap hmap) {
		return ghmDao.ghmRegist(hmap.getMap());
	}

	public <T> List<T> ghmYear(HMap hmap) {
		return ghmDao.ghmYear(hmap.getMap());
	}

	public <T> List<T> ghmSubPage(HMap hmap) {
		return ghmDao.ghmSubPage(hmap.getMap());
	}

	public void ghmActivate(HMap hmap) {
		List<String> ghm_code_list = hmap.getList("ghm_code_list");
		if (CommonUtils.isNotEmpty(ghm_code_list)) {
			for (String ghm_code : ghm_code_list) {
				HMap param = new HMap();
				param.put(Define.GHM_CODE, ghm_code);
				param.put(Define.USER_ID, hmap.getString(Define.USER_ID));
				ghmDao.ghmActivate(param.getMap());
			}
		}
	}

	/* 관 관련 */
	public <T> List<T> gwanOverlapCheck(HMap hmap) {
		return ghmDao.gwanOverlapCheck(hmap.getMap());
	}

	public int gwanRegist(HMap hmap) {
		String bsns_cate = hmap.getString(Define.BSNS_CATE);
		String ghm_year = hmap.getString(Define.GHM_YEAR);
		String gwan_io_type = hmap.getString(Define.GWAN_IO_TYPE);
		String gwan_numb = String.format("%02d", hmap.getInt(Define.GWAN_NUMB));

		hmap.put(Define.GWAN_CODE, bsns_cate + ghm_year + "_" + gwan_io_type + gwan_numb);
		return ghmDao.gwanRegist(hmap.getMap());
	}

	public <T> T gwanItem(HMap hmap) {
		return ghmDao.gwanItem(hmap.getMap());
	}

	public int gwanModify(HMap hmap) {
		return ghmDao.gwanModify(hmap.getMap());
	}

	public int gwanDelete(HMap hmap) throws SQLException {
		List<Map<String, Object>> hang_list = ghmDao.hangList(hmap.getMap());

		if (hang_list.size() > 0) {
			throw new SQLException("하위 항이 등록되어 있어 삭제할 수 없습니다.\n하위 항을 먼저 삭제 후 다시 시도해주세요.");
		} else {
			return ghmDao.gwanDelete(hmap.getMap());
		}
	}

	public <T> List<T> gwanList(HMap hmap) {
		return ghmDao.gwanList(hmap.getMap());
	}

	/* 항 관련 */
	public <T> List<T> hangOverlapCheck(HMap hmap) {
		return ghmDao.hangOverlapCheck(hmap.getMap());
	}

	public int hangRegist(HMap hmap) {
		String gwan_code = hmap.getString(Define.GWAN_CODE);
		String hang_numb = String.format("%02d", hmap.getInt(Define.HANG_NUMB));

		hmap.put(Define.HANG_CODE, gwan_code + hang_numb);
		return ghmDao.hangRegist(hmap.getMap());
	}

	public <T> T hangItem(HMap hmap) {
		return ghmDao.hangItem(hmap.getMap());
	}

	public int hangModify(HMap hmap) {
		return ghmDao.hangModify(hmap.getMap());
	}

	public int hangDelete(HMap hmap) throws SQLException {
		List<Map<String, Object>> mock_list = ghmDao.mockList(hmap.getMap());

		if (mock_list.size() > 0) {
			throw new SQLException("하위 목이 등록되어 있어 삭제할 수 없습니다.\n하위 목을 먼저 삭제 후 다시 시도해주세요.");
		} else {
			return ghmDao.hangDelete(hmap.getMap());
		}
	}

	public <T> List<T> hangList(HMap hmap) {
		return ghmDao.hangList(hmap.getMap());
	}

	/* 목 관련 */
	public <T> List<T> mockOverlapCheck(HMap hmap) {
		return ghmDao.mockOverlapCheck(hmap.getMap());
	}

	public int mockRegist(HMap hmap) {
		String hang_code = hmap.getString(Define.HANG_CODE);
		String mock_numb = String.format("%02d", hmap.getInt(Define.MOCK_NUMB));

		hmap.put(Define.MOCK_CODE, hang_code + mock_numb);
		return ghmDao.mockRegist(hmap.getMap());
	}

	public <T> T mockItem(HMap hmap) {
		return ghmDao.mockItem(hmap.getMap());
	}

	public int mockModify(HMap hmap) {
		return ghmDao.mockModify(hmap.getMap());
	}

	public int mockDelete(HMap hmap) throws SQLException {
		List<Map<String, Object>> mock_list = tranDao.tranList(hmap.getMap());

		HMap param = new HMap();
		param.put(Define.REL_MOCK_CODE, hmap.getString(Define.MOCK_CODE));
		List<Map<String, Object>> rel_mock_list = tranDao.tranList(param.getMap());

		List<Map<String, Object>> budget_detail_list = budgetDao.budgetDetailList(hmap.getMap());

		if (mock_list.size() > 0) {
			throw new SQLException("거래등록에 사용되어 삭제할 수 없습니다.");
		} else if (rel_mock_list.size() > 0) {
			throw new SQLException("거래등록에 사용되어 삭제할 수 없습니다.");
		} else if (budget_detail_list.size() > 0) {
			throw new SQLException("예산등록에 사용되어 삭제할 수 없습니다.");
		} else {
			return ghmDao.mockDelete(hmap.getMap());
		}
	}

	public <T> List<T> mockList(HMap hmap) {
		return ghmDao.mockList(hmap.getMap());
	}


	public <T> List<T> ghmReportList(HMap hmap) {
		return ghmDao.ghmReportList(hmap.getMap());
	}

	@Transactional
	public void ghmReportRegist(HMap hmap) {
		List<String> ghmr_code_list = hmap.getList("ghmr_code_list");
		List<String> ghmr_name_list = hmap.getList("ghmr_name_list");
		List<String> i_mock_code_list = hmap.getList("i_mock_code_list");
		List<String> o_mock_code_list = hmap.getList("o_mock_code_list");

		if (CommonUtils.isNotEmpty(ghmr_name_list)) {
			for (int i = 0; i < ghmr_name_list.size(); i++) {
				hmap.put(Define.GHM_CODE, hmap.getString(Define.GHM_CODE));
				hmap.put(Define.GHMR_CODE, ghmr_code_list.get(i));
				hmap.put(Define.GHMR_NAME, ghmr_name_list.get(i));
				hmap.put(Define.I_MOCK_CODE, i_mock_code_list.get(i));
				hmap.put(Define.O_MOCK_CODE, o_mock_code_list.get(i));

				if (CommonUtils.isEmpty(ghmr_code_list.get(i))) {
					ghmDao.ghmReportRegist(hmap.getMap());
				} else {
					ghmDao.ghmReportModify(hmap.getMap());
				}
			}
		}
	}

	public int ghmReportDelete(HMap hmap) {
		return ghmDao.ghmReportDelete(hmap.getMap());
	}
}
