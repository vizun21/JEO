package com.erowm.webapp.bankda.service;

import com.erowm.common.config.BankdaAccount;
import com.erowm.common.config.Define;
import com.erowm.common.config.TypeVal;
import com.erowm.common.domain.HMap;
import com.erowm.common.domain.LoginVO;
import com.erowm.common.util.CommonUtils;
import com.erowm.common.util.SessionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

@Service
public class BankdaService {
	@Autowired
	private BankdaAccount bankdaAccount;

	private static final String POST = "POST";
	private static final String DIRECT_ACCESS = "directAccess";
	private static final String SERVICE_TYPE = "service_type";
	private static final String PARTNER_ID = "partner_id";
	private static final String PARTNER_PW = "partner_pw";
	private static final String PARTNER_NAME = "partner_name";

	private static final String EXECUTE = "execute";
	private static final String UPDATE = "update";
	private static final String CHAR_SET = "char_set";
	private static final String UTF_8 = "utf-8";

	private static final String USER_ID = "user_id";
	private static final String USER_PW = "user_pw";
	private static final String USER_NAME = "user_name";

	private static final String BKDIV = "bkdiv";
	private static final String BKCODE = "bkcode";
	private static final String BKACCTNO = "bkacctno";
	private static final String BKACCTPNO_PW = "bkacctpno_pw";
	private static final String MJUMIN_1 = "Mjumin_1";
	private static final String MJUMIN_2 = "Mjumin_2";
	private static final String BJUMIN_1 = "Bjumin_1";
	private static final String BJUMIN_2 = "Bjumin_2";
	private static final String BJUMIN_3 = "Bjumin_3";
	private static final String WEBID = "webid";
	private static final String WEBPW = "webpw";
	private static final String RENAMES = "renames";

	/* 뱅크다유저(사업자) 관련 */
	public String compRegist(HMap hmap) {
		String urlPath = "https://ssl.bankda.com/partnership/user/user_join_prs.php";

		String param = "";
		param += DIRECT_ACCESS + "=y";
		param += "&" + SERVICE_TYPE + "=" + bankdaAccount.getSERVICE_TYPE();
		param += "&" + PARTNER_ID + "=" + bankdaAccount.getPARTNER_ID();
		param += "&" + PARTNER_NAME + "=" + bankdaAccount.getPARTNER_NAME();
		param += "&" + USER_ID + "=" + hmap.getString(Define.COMP_CODE);
		param += "&" + USER_PW + "=" + hmap.getString(Define.COMP_BANKDA_PW);
		param += "&" + USER_NAME + "=" + hmap.getString(Define.COMP_NAME);
		param += "&" + CHAR_SET + "=" + UTF_8;

		return postTemplate(urlPath, param);
	}

	/*
	 * Bankda 회원탈퇴 기능으로, 사용자정보 및 계좌정보 일괄삭제됨
	 */
	public String compDelete(HMap hmap) {
		String urlPath = "https://ssl.bankda.com/partnership/user/user_withdraw.php";

		String param = "";
		param += DIRECT_ACCESS + "=y";
		param += "&" + SERVICE_TYPE + "=" + bankdaAccount.getSERVICE_TYPE();
		param += "&" + PARTNER_ID + "=" + bankdaAccount.getPARTNER_ID();
		param += "&" + USER_ID + "=" + hmap.getString(Define.COMP_CODE);
		param += "&" + USER_PW + "=" + hmap.getString(Define.COMP_BANKDA_PW);
		param += "&command=" + EXECUTE;

		return postTemplate(urlPath, param);
	}

	/* 계좌 관련 */
	/*
	 * 계좌번호는 고유번호로, 사용자가 달라도 중복등록 불가함
	 */
	public String acntRegist(HMap hmap) {
		LoginVO loginVO = (LoginVO) SessionUtils.getAttribute(Define.loginVO);

		String urlPath = "https://ssl.bankda.com/partnership/user/account_add.php";

		String param = "";
		param += DIRECT_ACCESS + "=y";
		param += "&" + SERVICE_TYPE + "=" + bankdaAccount.getSERVICE_TYPE();
		param += "&" + PARTNER_ID + "=" + bankdaAccount.getPARTNER_ID();
		param += "&" + USER_ID + "=" + loginVO.getComp_code();
		param += "&" + USER_PW + "=" + loginVO.getComp_bankda_pw();
		param += "&Command=" + UPDATE;
		param += "&" + BKDIV + "=" + loginVO.getComp_type();
		param += "&" + BKCODE + "=" + hmap.getString(Define.BANK_CODE);
		param += "&" + BKACCTNO + "=" + hmap.getString(Define.ACNT_NUMB);
		param += "&" + BKACCTPNO_PW + "=" + hmap.getString(Define.ACNT_PW);
		if (loginVO.getComp_type().equals(TypeVal.PERSON)) {
			param += "&" + MJUMIN_1 + "=" + loginVO.getUser_reg_numb_1();
			param += "&" + MJUMIN_2 + "=0000000";
		} else if (loginVO.getComp_type().equals(TypeVal.COMP)) {
			param += "&" + BJUMIN_1 + "=" + loginVO.getComp_reg_numb_1();
			param += "&" + BJUMIN_2 + "=" + loginVO.getComp_reg_numb_2();
			param += "&" + BJUMIN_3 + "=" + loginVO.getComp_reg_numb_3();
		}
		param += "&" + WEBID + "=" + hmap.getString(Define.ACNT_WEB_ID);
		param += "&" + WEBPW + "=" + hmap.getString(Define.ACNT_WEB_PW);
		param += "&" + RENAMES + "=" + hmap.getString(Define.ACNT_NAME);
		param += "&" + CHAR_SET + "=" + UTF_8;

		return postTemplate(urlPath, param);
	}

	public String acntModify(HMap hmap) {
		LoginVO loginVO = (LoginVO) SessionUtils.getAttribute(Define.loginVO);

		String urlPath = "https://ssl.bankda.com/partnership/user/account_fix.php";

		String param = "";
		param += DIRECT_ACCESS + "=y";
		param += "&" + SERVICE_TYPE + "=" + bankdaAccount.getSERVICE_TYPE();
		param += "&" + PARTNER_ID + "=" + bankdaAccount.getPARTNER_ID();
		param += "&" + USER_ID + "=" + loginVO.getComp_code();
		param += "&" + USER_PW + "=" + loginVO.getComp_bankda_pw();
		param += "&Command=" + UPDATE;
		param += "&" + BKDIV + "=" + loginVO.getComp_type();
		param += "&" + BKACCTNO + "=" + hmap.getString(Define.ACNT_NUMB);
		if (CommonUtils.isNotEmpty(hmap.getString(Define.ACNT_PW))) {
			param += "&" + BKACCTPNO_PW + "=" + hmap.getString(Define.ACNT_PW);
		}
		if (loginVO.getComp_type().equals(TypeVal.PERSON)) {
			param += "&" + MJUMIN_1 + "=" + loginVO.getUser_reg_numb_1();
			param += "&" + MJUMIN_2 + "=0000000";
		} else if (loginVO.getComp_type().equals(TypeVal.COMP)) {
			param += "&" + BJUMIN_1 + "=" + loginVO.getComp_reg_numb_1();
			param += "&" + BJUMIN_2 + "=" + loginVO.getComp_reg_numb_2();
			param += "&" + BJUMIN_3 + "=" + loginVO.getComp_reg_numb_3();
		}
		param += "&" + WEBID + "=" + hmap.getString(Define.ACNT_WEB_ID);
		param += "&" + WEBPW + "=" + hmap.getString(Define.ACNT_WEB_PW);
		param += "&" + RENAMES + "=" + hmap.getString(Define.ACNT_NAME);
		param += "&" + CHAR_SET + "=" + UTF_8;

		return postTemplate(urlPath, param);
	}

	public String acntDelete(HMap hmap) {
		LoginVO loginVO = (LoginVO) SessionUtils.getAttribute(Define.loginVO);

		String urlPath = "https://ssl.bankda.com/partnership/user/account_del.php";

		String param = "";
		param += DIRECT_ACCESS + "=y";
		param += "&" + SERVICE_TYPE + "=" + bankdaAccount.getSERVICE_TYPE();
		param += "&" + PARTNER_ID + "=" + bankdaAccount.getPARTNER_ID();
		param += "&" + USER_ID + "=" + loginVO.getComp_code();
		param += "&" + USER_PW + "=" + loginVO.getComp_bankda_pw();
		param += "&Command=" + UPDATE;
		param += "&" + BKACCTNO + "=" + hmap.getString(Define.ACNT_NUMB);

		return postTemplate(urlPath, param);
	}

	public String acntInfo(HMap hmap) {
		String urlPath = "https://ssl.bankda.com/partnership/partner/account_info_xml.php";

		String param = "";
		param += SERVICE_TYPE + "=" + bankdaAccount.getSERVICE_TYPE();
		param += "&" + PARTNER_ID + "=" + bankdaAccount.getPARTNER_ID();
		param += "&" + PARTNER_PW + "=" + bankdaAccount.getPARTNER_PW();
		param += "&" + BKACCTNO + "=" + hmap.getString(Define.ACNT_NUMB);
		param += "&" + CHAR_SET + "=" + UTF_8;

		return postTemplate(urlPath, param);
	}

	public String acntList(HMap hmap) {
		String urlPath = "https://ssl.bankda.com/partnership/partner/account_list_partnerid_xml.php";

		String param = "";
		param += SERVICE_TYPE + "=" + bankdaAccount.getSERVICE_TYPE();
		param += "&" + PARTNER_ID + "=" + bankdaAccount.getPARTNER_ID();
		param += "&" + PARTNER_PW + "=" + bankdaAccount.getPARTNER_PW();
		param += "&" + CHAR_SET + "=" + UTF_8;

		return postTemplate(urlPath, param);
	}

	public String postTemplate(String urlPath, String param) {
		String response = null;

		try {
			URL url = new URL(urlPath);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();

			con.setRequestMethod(POST);
			con.setDoOutput(true);

			OutputStream os = con.getOutputStream();
			os.write(param.getBytes(UTF_8));
			os.flush();
			os.close();

			BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), UTF_8));
			StringBuffer sb = new StringBuffer();
			String inputLine;

			while ((inputLine = br.readLine()) != null) {
				sb.append(inputLine);
			}
			br.close();

			response = sb.toString();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return response;
	}

}
