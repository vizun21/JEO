package com.erowm.webapp.business.auth.service;

import com.erowm.common.config.Define;
import com.erowm.common.domain.HMap;
import com.erowm.common.util.CommonUtils;
import com.erowm.webapp.business.auth.dao.AuthDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AuthService {
	@Autowired AuthDao authDao;

	public <T> List<T> authUserList(HMap hmap) {
		return authDao.authUserList(hmap.getMap());
	}

	public <T> List<T> unauthUserList(HMap hmap) {
		return authDao.unauthUserList(hmap.getMap());
	}

	public void authRegist(HMap hmap) {
		List<String> user_id_list = hmap.getList("user_id_list");
		if (CommonUtils.isNotEmpty(user_id_list)) {
			for (String user_id : user_id_list) {
				HMap param = new HMap();
				param.put(Define.COMP_CODE, hmap.getString(Define.COMP_CODE));
				param.put(Define.BSNS_CODE, hmap.getString(Define.BSNS_CODE));
				param.put(Define.USER_ID, user_id);
				authDao.authRegist(param.getMap());
			}
		}
	}

	public void authDelete(HMap hmap) {
		List<String> user_id_list = hmap.getList("user_id_list");
		if (CommonUtils.isNotEmpty(user_id_list)) {
			for (String user_id : user_id_list) {
				HMap param = new HMap();
				param.put(Define.COMP_CODE, hmap.getString(Define.COMP_CODE));
				param.put(Define.BSNS_CODE, hmap.getString(Define.BSNS_CODE));
				param.put(Define.USER_ID, user_id);
				authDao.authDelete(param.getMap());
			}
		}
	}
}
