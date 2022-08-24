package com.erowm.webapp.admin.user.controller;

import com.erowm.common.config.Define;
import com.erowm.common.config.TypeVal;
import com.erowm.common.domain.HMap;
import com.erowm.common.domain.LoginDTO;
import com.erowm.common.domain.LoginVO;
import com.erowm.common.util.SessionUtils;
import com.erowm.webapp.user.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.Map;

@Controller
public class AdminUserRestController {
	@Autowired
	UserService userService;

	@RequestMapping(value = "/admin/user/transform", method = RequestMethod.POST)
	public ResponseEntity<String> trasformPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			hmap.set(map);

			LoginVO adminVO = (LoginVO) SessionUtils.getAttribute(Define.loginVO);

			// 현재로그인 사용자가 관리자인지 체크
			if (adminVO.getUser_level() >= TypeVal.LEVEL_ADMIN) {
				// 현재로그인 정보 adminVO에 세팅
				SessionUtils.setAttribute(Define.adminVO, adminVO);

				// 전환할 사용자 정보를 조회하여 loginVO에 세팅
				LoginDTO dto = new LoginDTO();
				dto.setUser_id(hmap.getString(Define.USER_ID));
				LoginVO loginVO = userService.userTransform(dto);
				SessionUtils.setAttribute(Define.loginVO, loginVO);

				return new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
			}

			entity = new ResponseEntity<>("잘못된 접근입니다.", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/admin/user/retransform", method = RequestMethod.POST)
	public ResponseEntity<String> retransformPOST(HMap hmap) {
		ResponseEntity<String> entity = null;
		try {
			LoginVO adminVO = (LoginVO) SessionUtils.getAttribute(Define.adminVO);
			SessionUtils.setAttribute(Define.loginVO, adminVO);    // loginVO 관리자정보로 변경
			SessionUtils.removeAttribute(Define.adminVO);    // adminVO 제거
			SessionUtils.removeAttribute(Define.businessVO);    // businessVO 제거

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
