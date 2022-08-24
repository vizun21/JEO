package com.erowm.webapp.user.kakao;

import com.erowm.common.api.KakaoAPI;
import com.erowm.common.config.Define;
import com.erowm.common.util.CommonUtils;
import com.erowm.common.util.SessionUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

@Controller
public class kakaoController {
	private KakaoAPI kakaoAPI = new KakaoAPI();

	@RequestMapping(value = "/user/kakao/token", method = RequestMethod.GET)
	public String oauthTokenGET(@RequestParam("code") String code) {
		try {
			// 토큰이 없을 경우 토큰 받아오기
			if (CommonUtils.isEmpty(SessionUtils.getAttribute(Define.TOKEN))) {
				String access_token = kakaoAPI.getAccessToken(code);
				SessionUtils.setAttribute(Define.TOKEN, access_token);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:" + Define.LOGIN_PATH;
		}
		return "/user/kakao/token";
	}

	@RequestMapping(value = "/user/kakao/logout", method = RequestMethod.GET)
	public String logoutGET() {
		kakaoAPI.logout((String) SessionUtils.getAttribute(Define.TOKEN));
		SessionUtils.removeAttribute(Define.TOKEN);
		return "redirect:/";
	}

	@RequestMapping(value = "/user/kakao/unlink", method = RequestMethod.GET)
	public String unlinkGET() {
		kakaoAPI.unlink((String) SessionUtils.getAttribute(Define.TOKEN));
		SessionUtils.removeAttribute(Define.TOKEN);
		return "redirect:/";
	}

	@RequestMapping(value = "/user/kakao/info", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> infoPOST() {
		ResponseEntity<Map<String, Object>> entity = null;
		try {
			Map<String, Object> user = kakaoAPI.getUserInfo((String) SessionUtils.getAttribute(Define.TOKEN));
			entity = new ResponseEntity<>(user, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/user/kakao/update", method = RequestMethod.POST)
	public ResponseEntity<String> updatePOST(@RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			kakaoAPI.updateUserInfo((String) SessionUtils.getAttribute(Define.TOKEN), map);
			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

}
