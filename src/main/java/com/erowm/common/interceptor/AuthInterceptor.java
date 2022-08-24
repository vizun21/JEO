package com.erowm.common.interceptor;

import com.erowm.common.config.Define;
import com.erowm.common.util.CommonUtils;
import com.erowm.common.util.SessionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AuthInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws IOException {
		logger.debug("===================================");
		logger.debug("=== AuthInterceptor : preHandle ===");
		logger.debug(" Request URI: " + request.getRequestURI());

		// 로그인 정보가 없으면
		if (CommonUtils.isEmpty(SessionUtils.getAttribute(Define.loginVO))) {
			CommonUtils.saveDestination(request);
			response.sendRedirect(Define.LOGIN_PATH);
			return false;
		}

		// 메뉴레벨 체크 및 등록/수정/조회 시 타사업장정보 접근체크

		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) {
		logger.debug("====================================");
		logger.debug("=== AuthInterceptor : postHandle ===");
	}

}
