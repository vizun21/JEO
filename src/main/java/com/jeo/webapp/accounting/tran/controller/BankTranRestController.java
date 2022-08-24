package com.jeo.webapp.accounting.tran.controller;

import com.jeo.common.config.Define;
import com.jeo.common.domain.HMap;
import com.jeo.webapp.accounting.tran.service.BankTranService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.HashMap;
import java.util.Map;

@Controller
public class BankTranRestController {
	@Autowired
	BankTranService bankTranService;

	@RequestMapping(value = "/accounting/bank/tran/page", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> pagePOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<Map<String, Object>> entity = null;
		try {
			hmap.set(map);

			Map<String, Object> data = new HashMap<>();
			data.put("data", bankTranService.bankTranPage(hmap));

			entity = new ResponseEntity<>(data, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/accounting/bank/tran/item/{bktr_code}", method = RequestMethod.POST)
	public ResponseEntity<Map<Object, String>> itemPOST(HMap hmap, @PathVariable("bktr_code") String bktr_code) {
		ResponseEntity<Map<Object, String>> entity = null;
		try {
			hmap.put(Define.BKTR_CODE, bktr_code);

			Map<Object, String> list = bankTranService.bankTranItem(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
