package com.jeo.webapp.user.join.controller;

import com.jeo.common.config.Define;
import com.jeo.common.config.TypeVal;
import com.jeo.common.domain.HMap;
import com.jeo.common.util.CommonUtils;
import com.jeo.webapp.comp.service.CompService;
import com.jeo.webapp.user.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller
public class UserJoinRestController {
	@Autowired UserService userService;
	@Autowired CompService compService;
	@Autowired BCryptPasswordEncoder passwordEncoder;

	@RequestMapping(value = "/user/join/comp", method = RequestMethod.POST)
	public String joinCompPOST(HMap hmap, HttpServletRequest request) {
		hmap.putRequestAll(request.getParameterMap());
		hmap.put(Define.USER_LEVEL, TypeVal.LEVEL_COMP_ADMIN);
		compService.compUserRegist(hmap);
		return "/user/join/complete";
	}

	@RequestMapping(value = "/user/join/person", method = RequestMethod.POST)
	public String joinPersonPOST(HMap hmap, HttpServletRequest request) {
		hmap.putRequestAll(request.getParameterMap());

		hmap.put(Define.COMP_CODE, "CP202208240001");	// 전주환경사업소 COMP_CODE로 고정

		// 직책이 팀장, 부장, 과장인 경우에는 관리자로 설정
		String position = hmap.getString(Define.USER_POSITION);
		if (position.equals("TJ") || position.equals("BJ") || position.equals("GJ")) {
			hmap.put(Define.USER_LEVEL, TypeVal.LEVEL_COMP_ADMIN);
		} else {
			hmap.put(Define.USER_LEVEL, TypeVal.LEVEL_COMP_USER);
		}

		userService.userRegist(hmap);
		return "/user/join/complete";
	}

	@RequestMapping(value = "/user/join/overlapCheck", method = RequestMethod.POST)
	public ResponseEntity<Boolean> overlapCheckPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<Boolean> entity = null;
		try {
			hmap.set(map);

			List<Map<String, Object>> list = userService.overlapCheck(hmap);
			boolean overlap = list.size() > 0;

			entity = new ResponseEntity<>(overlap, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/user/join/comp/list", method = RequestMethod.POST)
	public ResponseEntity<List<Map<Object, String>>> compSearchPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<List<Map<Object, String>>> entity = null;
		try {
			hmap.set(map);

			hmap.put(Define.KEYWORD_COLUMN, Define.COMP_NAME);

			List<Map<Object, String>> list = compService.compList(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/user/join/juminRegNumbCheck", method = RequestMethod.POST, produces = "application/text;charset=utf8")
	public ResponseEntity<String> juminRegNumbCheckPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		String result = "유효하지 않거나 중복된 주민등록번호입니다.";
		try {
			hmap.set(map);

			List<Map<String, Object>> list = userService.regNumbCheck(hmap);
			if(list.size() == 0) {
				String reg_numb_1 = hmap.getString(Define.USER_REG_NUMB_1);
				String reg_numb_2 = hmap.getString(Define.USER_REG_NUMB_2);
				if (CommonUtils.isValidJuminRegNumb(reg_numb_1, reg_numb_2)) {
					result = Define.SUCCESS;
				}
			}

			entity = new ResponseEntity<>(result, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/user/join/compRegNumbCheck", method = RequestMethod.POST, produces = "application/text;charset=utf8")
	public ResponseEntity<String> compRegNumbCheckPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		String result = "유효하지 않거나 중복된 사업자등록번호입니다.";
		try {
			hmap.set(map);

			List<Map<String, Object>> list = compService.regNumbCheck(hmap);
			if(list.size() == 0) {
				String reg_numb_1 = hmap.getString(Define.COMP_REG_NUMB_1);
				String reg_numb_2 = hmap.getString(Define.COMP_REG_NUMB_2);
				String reg_numb_3 = hmap.getString(Define.COMP_REG_NUMB_3);
				if (CommonUtils.isValidCompRegNumb(reg_numb_1, reg_numb_2, reg_numb_3)) {
					result = Define.SUCCESS;
				}
			}

			entity = new ResponseEntity<>(result, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
