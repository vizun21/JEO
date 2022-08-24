package com.erowm.webapp.comp.controller;

import com.erowm.common.config.Define;
import com.erowm.common.domain.HMap;
import com.erowm.webapp.bankda.exception.BankdaException;
import com.erowm.webapp.comp.service.CompService;
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
public class CompRestController {
	@Autowired CompService compService;

	@RequestMapping(value = "/comp/page", method = RequestMethod.POST)
	public ResponseEntity<List<Map<Object, String>>> pagePOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<List<Map<Object, String>>> entity = null;
		try {
			hmap.set(map);

			List<Map<Object, String>> list = compService.compList(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/comp/item", method = RequestMethod.POST)
	public ResponseEntity<Map<Object, String>> itemPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<Map<Object, String>> entity = null;
		try {
			hmap.put(Define.COMP_CODE, map.get(Define.COMP_CODE));

			Map<Object, String> item = compService.compItem(hmap);

			entity = new ResponseEntity<>(item, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/comp/modify/{comp_code}", method = RequestMethod.POST)
	public ResponseEntity<String> modifyPOST(HMap hmap, @PathVariable("comp_code") String comp_code, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			hmap.put(Define.COMP_CODE, comp_code);

			hmap.set(map);

			compService.compModify(hmap);

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/comp/approval", method = RequestMethod.POST)
	public ResponseEntity<String> approvalPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			hmap.set(map);

			compService.compApproval(hmap);

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/comp/delete/{comp_code}", method = RequestMethod.DELETE, produces = "application/text;charset=utf8")
	public ResponseEntity<String> deleteDELETE(HMap hmap, @PathVariable("comp_code") String comp_code) {
		ResponseEntity<String> entity = null;
		try {
			hmap.put(Define.COMP_CODE, comp_code);

			compService.compDelete(hmap);

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (BankdaException e) {
			e.printStackTrace();
			entity = new ResponseEntity<>("뱅크다 사업자정보 삭제오류. 뱅크다 정보와 일치하는지 확인바랍니다.", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
