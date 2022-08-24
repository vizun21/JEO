package com.erowm.webapp.user.controller;

import com.erowm.common.config.Define;
import com.erowm.common.config.TypeVal;
import com.erowm.common.domain.HMap;
import com.erowm.common.domain.LoginDTO;
import com.erowm.common.domain.LoginVO;
import com.erowm.common.util.CommonUtils;
import com.erowm.common.util.DateUtils;
import com.erowm.common.util.SessionUtils;
import com.erowm.webapp.comp.service.CompService;
import com.erowm.webapp.user.service.UserService;
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
public class UserRestController {
	@Autowired UserService userService;
	@Autowired CompService compService;
	@Autowired BCryptPasswordEncoder passwordEncoder;

	@RequestMapping(value = "/user/item", method = RequestMethod.POST)
	public ResponseEntity<Map<Object, String>> itemPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<Map<Object, String>> entity = null;
		try {
			hmap.set(map);

			Map<Object, String> list = userService.userItem(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/user/modify", method = { RequestMethod.PUT, RequestMethod.PATCH })
	public ResponseEntity<String> modifyPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			hmap.set(map);

			userService.userModify(hmap);

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/user/change/password", method = { RequestMethod.PUT, RequestMethod.PATCH })
	public ResponseEntity<String> changePasswordPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			hmap.set(map);

			userService.userChangePassword(hmap);

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
