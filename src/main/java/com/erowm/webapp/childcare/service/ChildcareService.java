package com.erowm.webapp.childcare.service;

import com.erowm.common.config.ChildcareAccount;
import com.erowm.common.config.Define;
import com.erowm.common.domain.HMap;
import com.erowm.common.util.CommonUtils;
import com.erowm.webapp.childcare.dao.ChildcareDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.xml.sax.InputSource;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.StringReader;
import java.net.URL;
import java.security.cert.X509Certificate;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ChildcareService {
	@Autowired
	ChildcareDao childcareDao;
	@Autowired
	ChildcareAccount childcareAccount;

	public <T> T childcareReportItem(HMap hmap) {
		return childcareDao.childcareReportItem(hmap.getMap());
	}

	public <T> List<T> monthlyPage(HMap hmap) {
		return childcareDao.monthlyPage(hmap.getMap());
	}

	/**
	 * 회계보고월은 당월이며, 회계내역은 전월 회계내역으로 전송
	 * 사용자가 볼때는 전월에 전월 회계내역 전송하는 것처럼 보이도록 함
	 * 시스템 상에서는 당월에 전월 회계내역 전송하는 것으로 처리
	 */
	public int monthlyRegist(HMap hmap) {
		String operationName = Define.acRptMonthSum;

		// MON 설정
		Calendar cal = Calendar.getInstance();
		cal.set(hmap.getInt(Define.REPO_YEAR), hmap.getInt(Define.REPO_MONTH) - 1, 1);
		cal.add(Calendar.MONTH, 1);
		DateFormat df = new SimpleDateFormat("yyyyMM");
		String MON = df.format(cal.getTime());

		// 월회계 데이터 조회
		int bsns_sess_start_month = hmap.getInt(Define.BSNS_SESS_START_MONTH);
		int session_year = bsns_sess_start_month <= hmap.getInt(Define.REPO_MONTH) ? hmap.getInt(Define.REPO_YEAR) : hmap.getInt(Define.REPO_YEAR) - 1;
		hmap.put(Define.SESSION_YEAR, session_year);
		List<Map<String, Object>> list = childcareDao.monthlyData(hmap.getMap());

		StringBuffer bodyData = new StringBuffer();
		bodyData.append("				<MON>").append(MON).append("</MON>\n");
		for (Map<String, Object> data : list) {
			bodyData.append("				<SR>\n");
			bodyData.append("					<GB>").append(data.get(Define.GB)).append("</GB>\n");
			bodyData.append("					<CD>").append(data.get(Define.CD)).append("</CD>\n");
			bodyData.append("					<AMT>").append(data.get(Define.AMT)).append("</AMT>\n");
			bodyData.append("					<CNT>").append(data.get(Define.CNT)).append("</CNT>\n");
			bodyData.append("				</SR>\n");
		}

		Map<String, String> result = soapWebservice(hmap, operationName, bodyData);

		hmap.put(Define.REPO_OPER, operationName);
		hmap.put(Define.REPO_TYPE, hmap.getInt(Define.REPO_MONTH));
		hmap.put(Define.REPO_CONTENT, result.get(Define.REPO_CONTENT));
		hmap.put(Define.REPO_RESULT_CODE, result.get(Define.REPO_RESULT_CODE));
		hmap.put(Define.REPO_RESULT_MSG, result.get(Define.REPO_RESULT_MSG));

		return childcareDao.childcareReportRegist(hmap.getMap());
	}

	public <T> List<T> budgetPage(HMap hmap) {
		return childcareDao.budgetPage(hmap.getMap());
	}

	public int budgetRegist(HMap hmap) {
		String operationName = Define.acRptBudget;

		// 예산 데이터 조회
		List<Map<String, Object>> list = childcareDao.budgetData(hmap.getMap());

		StringBuffer bodyData = new StringBuffer();
		bodyData.append("				<ACYEAR>").append(hmap.getString(Define.REPO_YEAR)).append("</ACYEAR>\n");
		bodyData.append("				<BGTGB>").append(hmap.getString(Define.REPO_TYPE)).append("</BGTGB>\n");
		for (Map<String, Object> data : list) {
			bodyData.append("				<BGTR>\n");
			bodyData.append("					<GB>").append(data.get(Define.GB)).append("</GB>\n");
			bodyData.append("					<CD>").append(data.get(Define.CD)).append("</CD>\n");
			bodyData.append("					<BGTAMT>").append(data.get(Define.BGTAMT)).append("</BGTAMT>\n");
			bodyData.append("					<COMPUTBSIS>").append(data.get(Define.COMPUTBSIS)).append("</COMPUTBSIS>\n");
			bodyData.append("				</BGTR>\n");
		}

		Map<String, String> result = soapWebservice(hmap, operationName, bodyData);
		hmap.put(Define.REPO_OPER, operationName);
		hmap.put(Define.REPO_TYPE, hmap.getInt(Define.REPO_TYPE));
		hmap.put(Define.REPO_CONTENT, result.get(Define.REPO_CONTENT));
		hmap.put(Define.REPO_RESULT_CODE, result.get(Define.REPO_RESULT_CODE));
		hmap.put(Define.REPO_RESULT_MSG, result.get(Define.REPO_RESULT_MSG));

		return childcareDao.childcareReportRegist(hmap.getMap());
	}

	public <T> List<T> settlementPage(HMap hmap) {
		return childcareDao.settlementPage(hmap.getMap());
	}

	public <T> List<T> settlementData(HMap hmap) {
		int session_year = hmap.getInt(Define.REPO_YEAR);
		int bsns_sess_start_month = hmap.getInt(Define.BSNS_SESS_START_MONTH);

		hmap.put(Define.SESSION_YEAR, session_year);

		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.set(session_year, bsns_sess_start_month - 1, 1);
		hmap.put(Define.START_DATE, df.format(cal.getTime()));

		cal.add(Calendar.YEAR, 1);
		hmap.put(Define.END_DATE, df.format(cal.getTime()));

		return childcareDao.settlementData(hmap.getMap());
	}

	public int settlementRegist(HMap hmap) {
		String operationName = Define.acRptStacnt;

		// 예산 데이터 조회
		List<String> gb_list = hmap.getList("gb_list");
		List<String> cd_list = hmap.getList("cd_list");
		List<String> cscnn_list = hmap.getList("cscnn_list");
		List<String> rmk_list = hmap.getList("rmk_list");

		StringBuffer bodyData = new StringBuffer();
		bodyData.append("				<ACYEAR>").append(hmap.getString(Define.REPO_YEAR)).append("</ACYEAR>\n");
		if (CommonUtils.isNotEmpty(cd_list)) {
			for (int i = 0; i < cd_list.size(); i++) {
				bodyData.append("				<STR>\n");
				bodyData.append("					<GB>").append(gb_list.get(i)).append("</GB>\n");
				bodyData.append("					<CD>").append(cd_list.get(i)).append("</CD>\n");
				bodyData.append("					<CSCNN>").append(cscnn_list.get(i)).append("</CSCNN>\n");
				bodyData.append("					<RMK>").append(rmk_list.get(i)).append("</RMK>\n");
				bodyData.append("				</STR>\n");
			}
		}

		Map<String, String> result = soapWebservice(hmap, operationName, bodyData);
		hmap.put(Define.REPO_OPER, operationName);
		hmap.put(Define.REPO_CONTENT, result.get(Define.REPO_CONTENT));
		hmap.put(Define.REPO_RESULT_CODE, result.get(Define.REPO_RESULT_CODE));
		hmap.put(Define.REPO_RESULT_MSG, result.get(Define.REPO_RESULT_MSG));

		return childcareDao.childcareReportRegist(hmap.getMap());
	}

	public Map<String, String> soapWebservice(HMap hmap, String operationName, StringBuffer bodyData) {
		Map<String, String> result = new HashMap<>();

		String targetURL = childcareAccount.getCOMMON_URL() + operationName + ".ws/" + operationName + ".ws";
		String responseMsg = null;
		PrintWriter writer = null;
		HttpsURLConnection conn = null;

		try {
			TrustManager[] trustAllCerts = new TrustManager[] {
				new X509TrustManager() {
					public X509Certificate[] getAcceptedIssuers() {
						return new X509Certificate[0];
					}
					public void checkClientTrusted(X509Certificate[] chain, String authType) {
					}
					public void checkServerTrusted(X509Certificate[] chain, String authType) {
					}
				}
			};

			SSLContext sc = SSLContext.getInstance("SSL");
			sc.init(null, trustAllCerts, new java.security.SecureRandom());
			HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());

			URL url = new URL(targetURL);
			conn = (HttpsURLConnection) url.openConnection();

			conn.addRequestProperty("Content-Type", "text/xml");
			conn.addRequestProperty("method", "post");
			String soapActionInfo = targetURL.split("//")[1];
			conn.addRequestProperty("SOAPAction", soapActionInfo.substring(soapActionInfo.indexOf("/"), soapActionInfo.lastIndexOf("/")));
			conn.setDoOutput(true);

			StringBuffer prefix = new StringBuffer();
			StringBuffer suffix = new StringBuffer();
			prefix.append("<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xxx=\"").append(targetURL).append("\">").append("\n");
			prefix.append("	<soap:Header></soap:Header>").append("\n");
			prefix.append("	<soap:Body>").append("\n");
			prefix.append("		<xxx:").append(operationName).append(">").append("\n");
			prefix.append("			<Request>").append("\n");
			prefix.append("				<S_AUTH_KEY>").append(hmap.getString(Define.S_AUTH_KEY)).append("</S_AUTH_KEY>\n");
			prefix.append("				<C_AUTH_KEY>").append(childcareAccount.getC_AUTH_KEY()).append("</C_AUTH_KEY>\n");
			suffix.append("			</Request>").append("\n");
			suffix.append("		</xxx:").append(operationName).append(">").append("\n");
			suffix.append("	</soap:Body>").append("\n");
			suffix.append("</soap:Envelope>").append("\n");

			String content = prefix.append(bodyData).append(suffix).toString();
			System.out.println("[Content] :\n" + content);

			writer = new PrintWriter(conn.getOutputStream());
			writer.write(content);
			writer.close();

			StringBuffer reponseMsg = new StringBuffer();
			BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			String line;
			while ((line = reader.readLine()) != null) {
				reponseMsg.append(line + "\n");
			}
			reader.close();

			System.out.println("[Response Message] :\n" + reponseMsg.toString());
			responseMsg = reponseMsg.toString();

			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			Document document = builder.parse(new InputSource(new StringReader(responseMsg)));

			result.put(Define.REPO_RESULT_CODE, document.getElementsByTagName("RESULTCODE").item(0).getTextContent());
			result.put(Define.REPO_RESULT_MSG, document.getElementsByTagName("RESULTMSG").item(0).getTextContent());
			result.put(Define.REPO_CONTENT, content);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

}
