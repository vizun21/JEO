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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;
import java.util.Map;

@Controller
public class UserController {
	@Autowired
	AuthService authService;
	@Autowired
	UserService userService;

	@PostMapping("/user/batch-retirement")
	public ResponseEntity<String> batchRetirementPOST(HMap hmap, @RequestBody Map<String, Object> map) {
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

	@PostMapping("/user/searchPassword")
	public String searchPasswordPOST(@ModelAttribute("user") User user, Model model) {
		model.addAttribute("user", user);

		if (user == null || user.getUser_id() == null || user.getUser_id().equals("")
				|| user.getPassword_hint() == null || user.getPassword_hint().equals("")
				|| user.getPassword_hint_answer() == null || user.getPassword_hint_answer().equals("")) {
			model.addAttribute("resultInfo", "잘못된 접근입니다.");
			return "/user/searchPasswordResult";
		}

		String password = userService.searchPassword(user);
		if (password == null || password.equals("")) {
			model.addAttribute("resultInfo", "비밀번호를 찾을 수 없습니다.");
			return "/user/searchPasswordResult";
		}

		return "/user/setNewPassword";
	}
}
