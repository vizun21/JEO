package com.erowm.common.interceptor;

import com.erowm.common.config.Define;
import com.erowm.common.config.TypeVal;
import com.erowm.common.domain.BusinessVO;
import com.erowm.common.domain.HMap;
import com.erowm.common.domain.LoginVO;
import com.erowm.common.util.CommonUtils;
import com.erowm.common.util.SessionUtils;
import com.erowm.webapp.business.service.BusinessService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

public class BusinessInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(BusinessInterceptor.class);

	@Autowired BusinessService businessService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws IOException {
		logger.debug("===================================");
		logger.debug("=== BusinessInterceptor : preHandle ===");
		logger.debug(" Request URI: " + request.getRequestURI());


		if (CommonUtils.isEmpty(SessionUtils.getAttribute(Define.businessVO))) {
			// Session에 선택된 사업정보가 없으면 사업선택 페이지로 이동
			response.sendRedirect(Define.BUSINESS_LIST_PATH);

			return false;
		}

		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) {
		logger.debug("====================================");
		logger.debug("=== BusinessInterceptor : postHandle ===");

		if(CommonUtils.isNotEmpty(modelAndView)) {
			LoginVO loginVO = (LoginVO) SessionUtils.getAttribute(Define.loginVO);

			if (loginVO.getUser_level() < TypeVal.LEVEL_ADMIN) {
				BusinessVO businessVO = (BusinessVO) SessionUtils.getAttribute(Define.businessVO);
				HMap hmap = new HMap();
				hmap.put(Define.COMP_CODE, loginVO.getComp_code());
				if (loginVO.getUser_level() < TypeVal.LEVEL_COMP_ADMIN) {	// 사업근로자면 권한부여된 것만 조회
					hmap.put(Define.AUTH_USER, loginVO.getUser_id());
				}
				hmap.put(Define.EXCLUDE_BSNS_CODE, businessVO.getBsns_code());
				modelAndView.addObject("businessList", businessService.businessList(hmap));
			}
		}
	}

}
