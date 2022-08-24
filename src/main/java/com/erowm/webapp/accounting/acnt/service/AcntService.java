package com.erowm.webapp.accounting.acnt.service;

import com.erowm.common.config.Define;
import com.erowm.common.domain.HMap;
import com.erowm.webapp.accounting.acnt.dao.AcntDao;
import com.erowm.webapp.accounting.tran.dao.TranDao;
import com.erowm.webapp.bankda.exception.BankdaException;
import com.erowm.webapp.bankda.service.BankdaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.w3c.dom.Document;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.xml.sax.InputSource;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.StringReader;
import java.util.List;
import java.util.Map;

@Service
public class AcntService {
	@Autowired AcntDao acntDao;
	@Autowired TranDao tranDao;
	@Autowired BankdaService bankdaService;

	public <T> List<T> acntPage(HMap hmap) {
		List<T> accountlist = acntDao.acntPage(hmap.getMap());

		for (T account : accountlist) {
			Map<String, Object> accountMap = (Map<String, Object>) account;
			HMap param = new HMap();
			param.put(Define.ACNT_NUMB, accountMap.get(Define.ACNT_NUMB));

			// 뱅크다 계좌 조회
			String result = bankdaService.acntInfo(param);
			try {
				InputSource is = new InputSource(new StringReader(result));
				DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
				DocumentBuilder builder = factory.newDocumentBuilder();
				Document doc = builder.parse(is);

				Node node = doc.getElementsByTagName("account").item(0);
				NamedNodeMap attribute = node.getAttributes();
				accountMap.put("act_tag", attribute.getNamedItem("acttag").getNodeValue());
				String acttag = attribute.getNamedItem("acttag").getNodeValue();
				String act_tag_name;
				if (acttag.equals("T")) act_tag_name = "정상";
				else if (acttag.equals("F")) act_tag_name = "오류";
				else act_tag_name = "계좌연동 중";
				accountMap.put("act_tag_name", act_tag_name);
				accountMap.put("last_scraping_dtm", attribute.getNamedItem("last_scraping_dtm").getNodeValue());
				accountMap.put("act_status", attribute.getNamedItem("act_status").getNodeValue());
				account = (T) accountMap;
			} catch (Exception e) {
				throw new BankdaException(result);
			}
		}
		return accountlist;
	}

	public <T> List<T> acntList(HMap hmap) {
		return acntDao.acntList(hmap.getMap());
	}

	@Transactional
	public void acntRegist(HMap hmap) {
		acntDao.acntRegist(hmap.getMap());

		// 뱅크다 계좌 등록
		String result = bankdaService.acntRegist(hmap);
		if (!result.equals(Define.OK)) {
			throw new BankdaException(result);
		}
	}

	public <T> T acntItem(HMap hmap) {
		return acntDao.acntItem(hmap.getMap());
	}

	@Transactional
	public void acntModify(HMap hmap) {
		acntDao.acntModify(hmap.getMap());

		// 뱅크다 계좌 수정
		String result = bankdaService.acntModify(hmap);
		if (!result.equals(Define.OK)) {
			throw new BankdaException(result);
		}
	}

	@Transactional
	public void acntDelete(HMap hmap) {
		Map<String, Object> acnt = acntDao.acntItem(hmap.getMap());
		hmap.put(Define.ACNT_NUMB, acnt.get(Define.ACNT_NUMB));

		String delete_type = hmap.getString(Define.DELETE_TYPE);
		if (delete_type.equals(Define.REMOVE)) {
			tranDao.tranDelete(hmap.getMap());
		} else if (delete_type.equals(Define.MAINTAIN)) {
			tranDao.tranBktrSetNull(hmap.getMap());
		}
		acntDao.acntDelete(hmap.getMap());

		// 뱅크다 계좌 삭제

		String result = bankdaService.acntDelete(hmap);
		if (!result.equals(Define.OK)) {
			throw new BankdaException(result);
		}
	}
}
