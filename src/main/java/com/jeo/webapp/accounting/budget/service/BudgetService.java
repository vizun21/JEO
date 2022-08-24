package com.jeo.webapp.accounting.budget.service;

import com.jeo.common.config.Define;
import com.jeo.common.config.TypeVal;
import com.jeo.common.domain.HMap;
import com.jeo.common.exception.AlertException;
import com.jeo.common.util.CommonUtils;
import com.jeo.webapp.accounting.budget.dao.BudgetDao;
import com.jeo.webapp.print.dto.BudgetAmountSearchCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigInteger;
import java.util.List;

@Service
public class BudgetService {
	@Autowired BudgetDao budgetDao;

	public <T> List<T> budgetPage(HMap hmap) {
		return budgetDao.budgetPage(hmap.getMap());
	}

	public <T> T budgetItem(HMap hmap) {
		return budgetDao.budgetItem(hmap.getMap());
	}

	@Transactional
	public void budgetRegist(HMap hmap) {
		budgetDao.budgetRegist(hmap.getMap());
		if (hmap.getInt(Define.BUDG_TYPE) > TypeVal.MAX_BUDG_TYPE) {
			throw new AlertException("추경예산은 9차까지만 추가가능합니다.");
		}
	}

	public <T> List<T> budgetDetailPage(HMap hmap) {
		return budgetDao.budgetDetailPage(hmap.getMap());
	}

	public void budgetDetailRegist(HMap hmap) {
		List<String> mock_code_list = hmap.getList("mock_code_list");
		List<String> bgdt_code_list = hmap.getList("bgdt_code_list");
		List<String> bgdt_content_list = hmap.getList("bgdt_content_list");
		List<String> bgdt_price_list = hmap.getList("bgdt_price_list");
		List<String> bgdt_qty_list = hmap.getList("bgdt_qty_list");
		List<String> bgdt_month_list = hmap.getList("bgdt_month_list");
		List<String> bgdt_per_list = hmap.getList("bgdt_per_list");
		List<String> delete_bgdt_code_list = hmap.getList("delete_bgdt_code_list");

		if (CommonUtils.isNotEmpty(delete_bgdt_code_list)) {
			for (String bgdt_code : delete_bgdt_code_list) {
				HMap param = new HMap();
				param.put(Define.COMP_CODE, hmap.getString(Define.COMP_CODE));
				param.put(Define.BSNS_CODE, hmap.getString(Define.BSNS_CODE));
				param.put(Define.BUDG_CODE, hmap.getString(Define.BUDG_CODE));
				param.put(Define.BGDT_CODE, bgdt_code);
				budgetDao.budgetDetailDelete(param.getMap());
			}
		}

		if (CommonUtils.isNotEmpty(mock_code_list)) {
			for (int i = 0; i < mock_code_list.size(); i++) {
				hmap.put(Define.MOCK_CODE, mock_code_list.get(i));
				hmap.put(Define.BGDT_CODE, bgdt_code_list.get(i));
				hmap.put(Define.BGDT_CONTENT, bgdt_content_list.get(i));
				hmap.put(Define.BGDT_PRICE, bgdt_price_list.get(i));
				hmap.put(Define.BGDT_QTY, bgdt_qty_list.get(i));
				hmap.put(Define.BGDT_MONTH, bgdt_month_list.get(i));
				hmap.put(Define.BGDT_PER, bgdt_per_list.get(i));

				if (CommonUtils.isEmpty(bgdt_code_list.get(i))) {	// bgdt_code 가 없으면 신규 등록
					budgetDao.budgetDetailRegist(hmap.getMap());
				} else {
					// bgdt_code 가 있고, 값들이 공백이면 해당 데이터 삭제
					if (CommonUtils.isEmpty(bgdt_content_list.get(i)) && CommonUtils.isEmpty(bgdt_price_list.get(i)) && CommonUtils.isEmpty(bgdt_qty_list.get(i))
							&& CommonUtils.isEmpty(bgdt_month_list.get(i)) && CommonUtils.isEmpty(bgdt_per_list.get(i))) {
						budgetDao.budgetDetailDelete(hmap.getMap());
					} else {	// 수정
						budgetDao.budgetDetailModify(hmap.getMap());
					}
				}
			}
		}
	}

	public String getLastBudgetType(HMap hmap) {
		return budgetDao.getLastBudgetType(hmap.getMap());
	}

	public BigInteger getBudgetAmount(BudgetAmountSearchCondition budgetAmountSearchCondition) {
		return budgetDao.getBudgetAmount(budgetAmountSearchCondition);
	}
}
