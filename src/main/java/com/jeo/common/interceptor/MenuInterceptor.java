package com.jeo.common.interceptor;

import com.jeo.common.config.Define;
import com.jeo.common.domain.BusinessVO;
import com.jeo.common.domain.HMap;
import com.jeo.common.domain.LoginVO;
import com.jeo.common.util.CommonUtils;
import com.jeo.common.util.SessionUtils;
import com.jeo.webapp.admin.system.menu.service.MenuService;
import com.jeo.webapp.admin.system.page.service.PageService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class MenuInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(MenuInterceptor.class);

	@Autowired MenuService menuService;
	@Autowired PageService pageService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		logger.debug("===================================");
		logger.debug("=== MenuInterceptor : preHandle ===");
		logger.debug(" Request URI: " + request.getRequestURI());

		return super.preHandle(request, response, handler);
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) {
		logger.debug("====================================");
		logger.debug("=== MenuInterceptor : postHandle ===");

		/* modelAndView 가 있는 경우만 메뉴가져오도록 함 */
		if(CommonUtils.isNotEmpty(modelAndView)) {
			HMap param = new HMap();

			LoginVO loginVO = (LoginVO) SessionUtils.getAttribute(Define.loginVO);
			param.put(Define.USER_LEVEL, loginVO.getUser_level());

			BusinessVO businessVO = (BusinessVO) SessionUtils.getAttribute(Define.businessVO);
			if (CommonUtils.isNotEmpty(businessVO)) {	// 사업정보가 있으면 사업유형 세팅
				param.put(Define.BSNS_CATE, businessVO.getBsns_cate());
			}

			modelAndView.addObject(Define.MENU, menuService.menuTree(param));

			param.put(Define.PAGE_URL, request.getRequestURI());
			try {
				Map<String, Object> page = pageService.pageItem(param);
				modelAndView.addObject(Define.MENU_NAME, page.get(Define.PAGE_NAME));
				if (CommonUtils.isNotEmpty(page)) {
					param.put(Define.MENU_CODE, page.get(Define.PAGE_CODE));
					modelAndView.addObject(Define.BREADCRUMB, menuService.breadcrumb(param));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

}
