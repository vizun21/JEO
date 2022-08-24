package com.erowm.webapp.admin.system.bank.controller;

import com.erowm.common.config.Define;
import com.erowm.common.domain.HMap;
import com.erowm.webapp.admin.system.bank.service.BankService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;
import java.util.Map;

@Controller
public class BankRestController {
	@Autowired
	BankService bankService;

	@RequestMapping(value = "/admin/system/bank/page", method = RequestMethod.POST)
	public ResponseEntity<List<Map<Object, String>>> pagePOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<List<Map<Object, String>>> entity = null;
		try {
			hmap.set(map);

			List<Map<Object, String>> list = bankService.bankPage(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/admin/system/bank/item/{bank_code}", method = RequestMethod.POST)
	public ResponseEntity<Map<Object, String>> itemPOST(HMap hmap, @PathVariable("bank_code") String bank_code) {
		ResponseEntity<Map<Object, String>> entity = null;
		try {
			hmap.put(Define.BANK_CODE, bank_code);

			Map<Object, String> list = bankService.bankItem(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/admin/system/bank/overlapCheck", method = RequestMethod.POST)
	public ResponseEntity<Boolean> overlapCheckPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<Boolean> entity = null;
		try {
			hmap.set(map);

			List<Map<String, Object>> list = bankService.overlapCheck(hmap);
			boolean overlap = list.size() > 0;

			entity = new ResponseEntity<>(overlap, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/admin/system/bank/regist", method = RequestMethod.POST)
	public ResponseEntity<String> registPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			hmap.set(map);

			bankService.bankRegist(hmap);

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/admin/system/bank/modify/{bank_code}", method = { RequestMethod.PUT, RequestMethod.PATCH })
	public ResponseEntity<String> modifyPOST(HMap hmap, @PathVariable("bank_code") String bank_code, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			hmap.put(Define.BANK_CODE, bank_code);

			hmap.set(map);

			bankService.bankModify(hmap);

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

}
