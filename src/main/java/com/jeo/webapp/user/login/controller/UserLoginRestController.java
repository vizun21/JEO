package com.jeo.webapp.user.login.controller;

import com.jeo.common.config.Define;
import com.jeo.common.config.TypeVal;
import com.jeo.common.domain.HMap;
import com.jeo.common.domain.LoginDTO;
import com.jeo.common.domain.LoginVO;
import com.jeo.common.util.CommonUtils;
import com.jeo.common.util.DateUtils;
import com.jeo.common.util.SessionUtils;
import com.jeo.webapp.business.service.BusinessService;
import com.jeo.webapp.comp.service.CompService;
import com.jeo.webapp.user.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.Map;

@Controller
public class UserLoginRestController {
	@Autowired
	UserService userService;
	@Autowired
	CompService compService;
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	@Autowired
	BusinessService businessService;

	@PostMapping(value = "/user/login")
	public String loginCheckPOST(@ModelAttribute("dto") LoginDTO dto, Model model) {
		String user_id = dto.getUser_id();
		String user_pw = dto.getUser_pw();

		HMap param = new HMap();
		param.put(Define.USER_ID, user_id);
		Map<String, Object> user = userService.userItem(param);

		// 회원존재여부 체크
		if (CommonUtils.isEmpty(user)) {
			model.addAttribute("loginErrorMessage", "아이디 혹은 패스워드가 일치하지 않습니다.");
			return "/user/login";
		}

		// 패스워드 체크
		String encPassword = user.get(Define.USER_PW).toString();
		if (!passwordEncoder.matches(user_pw, encPassword)) {
			model.addAttribute("loginErrorMessage", "아이디 혹은 패스워드가 일치하지 않습니다.");
			return "/user/login";
		}

		// 로그인 정보 조회
		dto.setUser_pw(encPassword);
		LoginVO login = userService.userLogin(dto);
		if (CommonUtils.isNotEmpty(login)) {
			// 관리자가 아니면 승인여부 및 만료여부 체크
			if (login.getUser_level() < TypeVal.LEVEL_ADMIN) {
				// 기업 승인여부 체크
				if (login.getComp_appr_yn().equals("N")) {
					model.addAttribute("loginErrorMessage", "기업승인 대기중 입니다. 잠시 후 다시 시도해주세요.\\n승인이 지연될 경우 관리자에게 문의바랍니다.");
					return "/user/login";
				}

				// 사용자 승인여부 체크
				if (login.getUser_appr_yn().equals("N")) {
					model.addAttribute("loginErrorMessage", "승인 대기중 입니다. 잠시 후 다시 시도해주세요.\\n승인이 지연될 경우 사업장에 문의바랍니다.");
					return "/user/login";
				}

				// 만료여부 체크
				if (login.getComp_exp_date().compareTo(DateUtils.getToday("yyyy-MM-dd")) < 0) {
					model.addAttribute("loginErrorMessage", "사용기간이 만료되었습니다.\\n관리자에게 문의바랍니다.");
					return "/user/login";
				}

				// 사용자로그인
				SessionUtils.setAttribute(Define.loginVO, login);    // 로그인정보
				HMap param2 = new HMap();
				param2.put(Define.COMP_CODE, login.getComp_code());
				param2.put(Define.BSNS_CODE, TypeVal.BSNS_CODE);
				SessionUtils.setAttribute(Define.businessVO, businessService.businessVO(param2));    // 사업정보
			}
			// 관리자로그인
			else {
				SessionUtils.setAttribute(Define.loginVO, login);
			}
		}

		// 로그인시간 업데이트
		userService.login(param);

		return "redirect:/";
	}
}
