package com.jeo.webapp.comp.service;

import com.jeo.common.config.Define;
import com.jeo.common.config.TypeVal;
import com.jeo.common.domain.HMap;
import com.jeo.common.util.CommonUtils;
import com.jeo.common.util.DateUtils;
import com.jeo.webapp.bankda.exception.BankdaException;
import com.jeo.webapp.common.dao.CommonDao;
import com.jeo.webapp.comp.dao.CompDao;
import com.jeo.webapp.user.dao.UserDao;
import com.jeo.webapp.user.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class CompService {
	@Autowired CompDao compDao;
	@Autowired CommonDao commonDao;
	@Autowired UserDao userDao;
	@Autowired UserService userService;
//	@Autowired BankdaService bankdaService;

	@Transactional
	public String compUserRegist(HMap hmap) {
		compRegist(hmap);
		userService.userRegist(hmap);
		userService.ceoRegist(hmap);

		// 뱅크다 유저(사업자) 등록 : erowm 정보 등록 후 뱅크다 사용자정보 등록
//		String result = bankdaService.compRegist(hmap);
//		if (!result.equals(Define.OK)) {
//			throw new BankdaException(result);
//		}

		return Define.SUCCESS;
	}

	@Transactional
	public int compRegist(HMap hmap) {
		hmap.put(Define.INDEX_TYPE, TypeVal.INDEX_COMP);
		hmap.put(Define.INDEX_DATE, DateUtils.getToday("yyyy-MM-dd"));
		commonDao.indexCheck(hmap.getMap());

		hmap.put(Define.COMP_CODE, genCompCode(hmap));
		hmap.put(Define.COMP_EXP_DATE, DateUtils.getLastDate());
		hmap.put(Define.COMP_BANKDA_PW, CommonUtils.genRandPassword(TypeVal.BANKDA_PW_LEN));
		return compDao.compRegist(hmap.getMap());
	}

	public <T> List<T> compList(HMap hmap) {
		return compDao.compList(hmap.getMap());
	}

	public <T> T compItem(HMap hmap) {
		return compDao.compItem(hmap.getMap());
	}

	public int compModify(HMap hmap) {
		// 수정항목 추가 시 뱅크다 연동확인 필요
		return compDao.compModify(hmap.getMap());
	}

	@Transactional
	public void compApproval(HMap hmap) {
		List<String> comp_code_list = hmap.getList("comp_code_list");
		List<String> ceo_id_list = hmap.getList("ceo_id_list");
		if (CommonUtils.isNotEmpty(comp_code_list)) {
			for (String comp_code : comp_code_list) {
				HMap param = new HMap();
				param.put(Define.COMP_CODE, comp_code);
				param.put(Define.USER_ID, hmap.getString(Define.USER_ID));
				param.put(Define.UPDATE_USER_ID, ceo_id_list.get(comp_code_list.indexOf(comp_code)));
				compDao.compApproval(param.getMap());
				userDao.userApproval(param.getMap());
			}
		}
	}

	@Transactional
	public void compDelete(HMap hmap) {
		Map<String, Object> comp = compDao.compItem(hmap.getMap());

		HMap param = new HMap();
		param.put(Define.COMP_CODE, hmap.getString(Define.COMP_CODE));
		param.put(Define.COMP_BANKDA_PW, comp.get(Define.COMP_BANKDA_PW));
		compDao.compDelete(param.getMap());

		// 뱅크다 유저(사업자) 삭제 : erowm 정보 삭제 후 뱅크다 사용자정보 삭제
//		String result = bankdaService.compDelete(param);
//		if (!result.equals(Define.OK)) {
//			throw new BankdaException(result);
//		}
	}

	public String genCompCode(HMap hmap) {
		return CommonUtils.genCode(hmap.getString(Define.INDEX_TYPE), hmap.getString(Define.INDEX_DATE), hmap.getInt(Define.INDEX_NUMB), 4);
	}

	public <T> List<T> regNumbCheck(HMap hmap) {
		HMap param = new HMap();
		param.put(Define.COMP_REG_NUMB_1, hmap.getString(Define.COMP_REG_NUMB_1));
		param.put(Define.COMP_REG_NUMB_2, hmap.getString(Define.COMP_REG_NUMB_2));
		param.put(Define.COMP_REG_NUMB_3, hmap.getString(Define.COMP_REG_NUMB_3));
		return compDao.compList(param.getMap());
	}
}
