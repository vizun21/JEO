package com.jeo.webapp.user.service;

import com.jeo.common.config.Define;
import com.jeo.common.domain.HMap;
import com.jeo.common.domain.LoginDTO;
import com.jeo.common.domain.LoginVO;
import com.jeo.common.util.CommonUtils;
import com.jeo.user.domain.User;
import com.jeo.webapp.bankda.service.BankdaService;
import com.jeo.webapp.common.dao.CommonDao;
import com.jeo.webapp.comp.dao.CompDao;
import com.jeo.webapp.user.dao.UserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class UserService {
	@Autowired
	UserDao userDao;
	@Autowired
	CompDao compDao;
	@Autowired
	CommonDao commonDao;
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	@Autowired
	BankdaService bankdaService;

	public int userRegist(HMap hmap) {
		// 사용자 등록
		String encPassword = passwordEncoder.encode(hmap.getString(Define.USER_PW));
		hmap.put(Define.USER_ENC_PW, encPassword);
		return userDao.userRegist(hmap.getMap());
	}

	public int ceoRegist(HMap hmap) {
		// 대표자 등록
		return userDao.ceoRegist(hmap.getMap());
	}

	public <T> T userItem(HMap hmap) {
		return userDao.userItem(hmap.getMap());
	}

	public <T> List<T> userList(HMap hmap) {
		return userDao.userList(hmap.getMap());
	}

	public int userDelete(HMap hmap) {
		return userDao.userDelete(hmap.getMap());
	}

	public int ceoDelete(HMap hmap) {
		return userDao.ceoDelete(hmap.getMap());
	}

	public LoginVO userLogin(LoginDTO dto) {
		return userDao.userLogin(dto);
	}

	public LoginVO userTransform(LoginDTO dto) {
		return userDao.userTransform(dto);
	}

	public int login(HMap hmap) {
		return userDao.login(hmap.getMap());
	}

	public <T> List<T> overlapCheck(HMap hmap) {
		HMap param = new HMap();
		param.put(Define.USER_ID, hmap.getString(Define.USER_ID));
		return userDao.userList(param.getMap());
	}

	public <T> List<T> regNumbCheck(HMap hmap) {
		HMap param = new HMap();
		param.put(Define.USER_REG_NUMB_1, hmap.getString(Define.USER_REG_NUMB_1));
		param.put(Define.USER_REG_NUMB_2, hmap.getString(Define.USER_REG_NUMB_2));
		return userDao.userList(param.getMap());
	}


	public <T> List<T> userPage(HMap hmap) {
		return userDao.userPage(hmap.getMap());
	}

	@Transactional
	public void userApproval(HMap hmap) {
		List<String> user_id_list = hmap.getList("user_id_list");
		if (CommonUtils.isNotEmpty(user_id_list)) {
			for (String user_id : user_id_list) {
				HMap param = new HMap();
				param.put(Define.COMP_CODE, hmap.getString(Define.COMP_CODE));
				param.put(Define.USER_ID, hmap.getString(Define.USER_ID));
				param.put(Define.UPDATE_USER_ID, user_id);
				userDao.userApproval(param.getMap());
			}
		}
	}

	public int userModify(HMap hmap) {
		return userDao.userModify(hmap.getMap());
	}

	public int userChangePassword(HMap hmap) {
		String encPassword = passwordEncoder.encode(hmap.getString(Define.USER_PW));
		hmap.put(Define.USER_ENC_PW, encPassword);
		return userDao.userChangePassword(hmap.getMap());
	}

	public User selectUser(HMap hmap) {
		return userDao.selectUser(hmap.getMap());
	}

	public void userRetirement(User user) {
		user.retirement();
		userDao.updateUser(user);
	}
}
