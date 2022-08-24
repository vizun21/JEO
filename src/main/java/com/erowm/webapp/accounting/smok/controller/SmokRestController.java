package com.erowm.webapp.accounting.smok.controller;

import com.erowm.common.config.Define;
import com.erowm.common.domain.HMap;
import com.erowm.common.exception.AlertException;
import com.erowm.webapp.accounting.smok.service.SmokService;
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
public class SmokRestController {
	@Autowired SmokService smokService;

	@RequestMapping(value = "/accounting/smok/page", method = RequestMethod.POST)
	public ResponseEntity<List<Map<Object, String>>> pagePOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<List<Map<Object, String>>> entity = null;
		try {
			hmap.set(map);

			List<Map<Object, String>> list = smokService.smokPage(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/accounting/smok/list", method = RequestMethod.POST)
	public ResponseEntity<List<Map<Object, String>>> listPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<List<Map<Object, String>>> entity = null;
		try {
			hmap.set(map);

			List<Map<Object, String>> list = smokService.smokList(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/accounting/smok/overlapCheck", method = RequestMethod.POST)
	public ResponseEntity<Boolean> overlapCheckPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<Boolean> entity = null;
		try {
			hmap.set(map);

			List<Map<String, Object>> list = smokService.smokList(hmap);
			boolean overlap = list.size() > 0;

			entity = new ResponseEntity<>(overlap, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/accounting/smok/regist", method = RequestMethod.POST)
	public ResponseEntity<String> registPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			hmap.set(map);

			smokService.smokRegist(hmap);

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/accounting/smok/item/{smok_code}", method = RequestMethod.POST)
	public ResponseEntity<Map<Object, String>> itemPOST(HMap hmap, @PathVariable("smok_code") String smok_code) {
		ResponseEntity<Map<Object, String>> entity = null;
		try {
			hmap.put(Define.SMOK_CODE, smok_code);

			Map<Object, String> list = smokService.smokItem(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/accounting/smok/modify/{smok_code}", method = { RequestMethod.PUT, RequestMethod.PATCH })
	public ResponseEntity<String> modifyPOST(HMap hmap, @PathVariable("smok_code") String smok_code, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			hmap.put(Define.SMOK_CODE, smok_code);

			hmap.set(map);

			smokService.smokModify(hmap);

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}


	@RequestMapping(value = "/accounting/smok/delete/{smok_code}", method = RequestMethod.DELETE, produces = "application/text;charset=utf8")
	public ResponseEntity<String> mockDeletePOST(HMap hmap, @PathVariable("smok_code") String smok_code) {
		ResponseEntity<String> entity = null;
		try {
			hmap.put(Define.SMOK_CODE, smok_code);

			smokService.smokDelete(hmap);

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (AlertException e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
