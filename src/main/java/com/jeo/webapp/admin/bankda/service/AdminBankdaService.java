package com.jeo.webapp.admin.bankda.service;

import com.jeo.common.config.Define;
import com.jeo.common.domain.HMap;
import com.jeo.webapp.accounting.acnt.dao.AcntDao;
import com.jeo.webapp.bankda.exception.BankdaException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.StringReader;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

@Service
public class AdminBankdaService {
	@Autowired AcntDao acntDao;
//	@Autowired BankdaService bankdaService;

	public <T> List<T> bankdaAccountPage(HMap hmap) {
		List<T> accountlist = acntDao.acntList(hmap.getMap());

		for (T account : accountlist) {
			Map<String, Object> accountMap = (Map<String, Object>) account;
			HMap param = new HMap();
			param.put(Define.ACNT_NUMB, accountMap.get(Define.ACNT_NUMB));

			// 뱅크다 계좌 조회
//			String result = bankdaService.acntInfo(param);
//			try {
//				InputSource is = new InputSource(new StringReader(result));
//				DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
//				DocumentBuilder builder = factory.newDocumentBuilder();
//				Document doc = builder.parse(is);
//
//				Node node = doc.getElementsByTagName("account").item(0);
//				NamedNodeMap attribute = node.getAttributes();
//				accountMap.put("act_tag", attribute.getNamedItem("acttag").getNodeValue());
//				accountMap.put("act_tag_name", attribute.getNamedItem("acttag").getNodeValue().equals("T") ? "정상" : "오류");
//				accountMap.put("last_scraping_dtm", attribute.getNamedItem("last_scraping_dtm").getNodeValue());
//				accountMap.put("act_status", attribute.getNamedItem("act_status").getNodeValue());
//				account = (T) accountMap;
//			} catch (Exception e) {
//				throw new BankdaException(result);
//			}
		}

		return accountlist;
	}

	public <T> List<T> bankdaAccountList(HMap hmap) {
		List<Map<String, Object>> list = new LinkedList<>();
//		String result = bankdaService.acntList(hmap);
//		try {
//			InputSource is = new InputSource(new StringReader(result));
//			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
//			DocumentBuilder builder = factory.newDocumentBuilder();
//			Document doc = builder.parse(is);
//
//			NodeList nodeList = doc.getElementsByTagName("account_info");
//			for (int i = 0; i < nodeList.getLength(); i++) {
//				NamedNodeMap attribute = nodeList.item(i).getAttributes();
//				System.out.println(attribute);
//				Map<String, Object> map = new HashMap<>();
//				for (int j = 0; j < attribute.getLength(); j++) {
//					Node attr = attribute.item(j);
//					map.put(attr.getNodeName(), attr.getNodeValue());
//				}
//				list.add(map);
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//			throw new BankdaException(result);
//		}
		return (List<T>) list;
	}
}
