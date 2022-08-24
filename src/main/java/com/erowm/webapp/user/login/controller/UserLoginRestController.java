package com.erowm.webapp.user.login.controller;

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

import java.util.Map;

@Controller
public class UserLoginRestController {
	@Autowired UserService userService;
	@Autowired CompService compService;
	@Autowired BCryptPasswordEncoder passwordEncoder;

	@RequestMapping(value = "/user/loginCheck", method = RequestMethod.POST, produces = "application/text;charset=utf8")
	public ResponseEntity<String> loginCheckPOST(@RequestBody LoginDTO dto) {
		ResponseEntity<String> entity = null;
		try {
			String user_id = dto.getUser_id();
			String user_pw = dto.getUser_pw();

			HMap param = new HMap();
			param.put(Define.USER_ID, user_id);
			Map<String, Object> user = userService.userItem(param);

			String result = "아이디 혹은 패스워드가 일치하지 않습니다.";
			// 아이디 체크
			if (CommonUtils.isNotEmpty(user)) {
				// 패스워드 체크
				String encPassword = user.get(Define.USER_PW).toString();
				if (passwordEncoder.matches(user_pw, encPassword)) {
					// 로그인 정보 조회
					dto.setUser_pw(encPassword);
					LoginVO login = userService.userLogin(dto);

					if (CommonUtils.isNotEmpty(login)) {
						// 관리자가 아니면 로그인 체크
						if (login.getUser_level() < TypeVal.LEVEL_ADMIN) {
							// 기업 승인여부 체크
							if (login.getComp_appr_yn().equals("N")) {
								result = "기업승인 대기중 입니다. 잠시 후 다시 시도해주세요.\n승인이 지연될 경우 관리자에게 문의바랍니다.";
							}

							// 사용자 승인여부 체크
							else if (login.getUser_appr_yn().equals("N")) {
								result = "승인 대기중 입니다. 잠시 후 다시 시도해주세요.\n승인이 지연될 경우 사업장에 문의바랍니다.";
							}

							// 만료여부 체크
							else if (login.getComp_exp_date().compareTo(DateUtils.getToday("yyyy-MM-dd")) < 0) {
								result = "사용기간이 만료되었습니다.\n관리자에게 문의바랍니다.";
							}
							// 사용자로그인
							else {
								SessionUtils.setAttribute(Define.loginVO, login);
								result = Define.SUCCESS;
							}
						}
						// 관리자로그인
						else {
							SessionUtils.setAttribute(Define.loginVO, login);
							result = Define.SUCCESS;
						}
					}
				}
			}

			// 로그인시간 업데이트
			if (result.equals(Define.SUCCESS)) {
				userService.login(param);
			}

			entity = new ResponseEntity<>(result, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
