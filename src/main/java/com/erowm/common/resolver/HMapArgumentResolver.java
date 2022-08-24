package com.erowm.common.resolver;

import com.erowm.common.config.Define;
import com.erowm.common.config.TypeVal;
import com.erowm.common.domain.BusinessVO;
import com.erowm.common.domain.HMap;
import com.erowm.common.domain.LoginVO;
import com.erowm.common.util.CommonUtils;
import com.erowm.common.util.SessionUtils;
import org.springframework.core.MethodParameter;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

public class HMapArgumentResolver implements HandlerMethodArgumentResolver {
	@Override
	public boolean supportsParameter(MethodParameter parameter) {
		return parameter.getParameterType() == HMap.class;
	}

	@Override
	public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer, NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {
		HMap hmap = new HMap();

		// 로그인정보가 있으면
		if (CommonUtils.isNotEmpty(SessionUtils.getAttribute(Define.loginVO))) {
			// 사용자정보 세팅
			LoginVO loginVO = (LoginVO) SessionUtils.getAttribute(Define.loginVO);
			hmap.put(Define.USER_ID, loginVO.getUser_id());
			hmap.put(Define.USER_LEVEL, loginVO.getUser_level());
			hmap.put(Define.CEO_YN, loginVO.getCeo_yn());
			if (loginVO.getUser_level() < TypeVal.LEVEL_ADMIN) {	// 관리자 아닌 경우만 사업자코드 추가
				hmap.put(Define.COMP_CODE, loginVO.getComp_code());
			}

			// 사업정보 세팅
			BusinessVO businessVO = (BusinessVO) SessionUtils.getAttribute(Define.businessVO);
			if (CommonUtils.isNotEmpty(businessVO)) {
				hmap.put(Define.BSNS_CODE, businessVO.getBsns_code());
				hmap.put(Define.BSNS_CATE, businessVO.getBsns_cate());
				hmap.put(Define.BSNS_SESS_START_MONTH, businessVO.getBsns_sess_start_month());
				hmap.put(Define.S_AUTH_KEY, businessVO.getS_auth_key());
			}
		}

		return hmap;
	}
}
