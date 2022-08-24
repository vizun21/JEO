package com.jeo.webapp.accounting.acnt.controller;

import com.jeo.common.config.Define;
import com.jeo.common.domain.HMap;
import com.jeo.webapp.accounting.acnt.service.AcntService;
import com.jeo.webapp.bankda.exception.BankdaException;
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
public class AcntRestController {
	@Autowired AcntService acntService;

	@RequestMapping(value = "/accounting/acnt/page", method = RequestMethod.POST)
	public ResponseEntity<List<Map<Object, String>>> pagePOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<List<Map<Object, String>>> entity = null;
		try {
			hmap.set(map);

			List<Map<Object, String>> list = acntService.acntPage(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/accounting/acnt/overlapCheck", method = RequestMethod.POST)
	public ResponseEntity<Boolean> overlapCheckPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<Boolean> entity = null;
		try {
			hmap.set(map);

			List<Map<String, Object>> list = acntService.acntList(hmap);
			boolean overlap = list.size() > 0;

			entity = new ResponseEntity<>(overlap, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/accounting/acnt/regist", method = RequestMethod.POST, produces = "application/text;charset=utf8")
	public ResponseEntity<String> registPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			hmap.set(map);

			acntService.acntRegist(hmap);

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (BankdaException e) {
			e.printStackTrace();
			entity = new ResponseEntity<>("계좌오류. 입력한 정보가 정확한지 확인 후 다시 등록해주세요.", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/accounting/acnt/item/{acnt_code}", method = RequestMethod.POST)
	public ResponseEntity<Map<Object, String>> itemPOST(HMap hmap, @PathVariable("acnt_code") String acnt_code) {
		ResponseEntity<Map<Object, String>> entity = null;
		try {
			hmap.put(Define.ACNT_CODE, acnt_code);

			Map<Object, String> list = acntService.acntItem(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/accounting/acnt/modify/{acnt_code}", method = { RequestMethod.PUT, RequestMethod.PATCH }, produces = "application/text;charset=utf8")
	public ResponseEntity<String> modifyPOST(HMap hmap, @PathVariable("acnt_code") String acnt_code, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			hmap.put(Define.ACNT_CODE, acnt_code);

			hmap.set(map);

			acntService.acntModify(hmap);

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (BankdaException e) {
			e.printStackTrace();
			entity = new ResponseEntity<>("계좌오류. 입력한 정보가 정확한지 확인 후 다시 등록해주세요.", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/accounting/acnt/delete/{acnt_code}/{delete_type}", method = RequestMethod.DELETE, produces = "application/text;charset=utf8")
	public ResponseEntity<String> deleteDELETE(HMap hmap, @PathVariable("acnt_code") String acnt_code, @PathVariable("delete_type") String delete_type) {
		ResponseEntity<String> entity = null;
		try {
			hmap.put(Define.ACNT_CODE, acnt_code);
			hmap.put(Define.DELETE_TYPE, delete_type);

			acntService.acntDelete(hmap);

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (BankdaException e) {
			e.printStackTrace();
			entity = new ResponseEntity<>("계좌삭제오류. 지속적으로 문제발생 시 관리자에게 문의바랍니다.", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
