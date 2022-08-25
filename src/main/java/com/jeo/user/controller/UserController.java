package com.jeo.user.controller;

import com.jeo.common.config.Define;
import com.jeo.common.domain.HMap;
import com.jeo.user.domain.User;
import com.jeo.webapp.business.auth.service.AuthService;
import com.jeo.webapp.user.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;
import java.util.Map;

@Controller
public class UserController {
	@Autowired
	AuthService authService;
	@Autowired
	UserService userService;

	@RequestMapping(value = "/user/batch-retirement", method = RequestMethod.POST)
	public ResponseEntity<String> approvalPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			hmap.set(map);

			List<String> userIDList = (List<String>) map.get("user_id_list");
			for (String userID : userIDList) {
				HMap param = new HMap();
				param.put(Define.COMP_CODE, hmap.getString(Define.COMP_CODE));
				param.put(Define.USER_ID, userID);
				User user = userService.selectUser(param);
				userService.userRetirement(user);
			}

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
