package com.erowm.webapp.accounting.tran.controller;

import com.erowm.common.config.Define;
import com.erowm.common.config.TypeVal;
import com.erowm.common.domain.HMap;
import com.erowm.common.exception.AlertException;
import com.erowm.webapp.accounting.deadline.service.DeadlineService;
import com.erowm.webapp.accounting.tran.service.TranService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class TranRestController {
	@Autowired TranService tranService;
	@Autowired DeadlineService deadlineService;

	@RequestMapping(value = "/accounting/tran/page", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> pagePOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<Map<String, Object>> entity = null;
		try {
			hmap.set(map);

			Map<String, Object> data = new HashMap<>();
			data.put("data", tranService.tranPage(hmap));

			data.put("prev_balance_amount", deadlineService.deadlinePrevBalance(hmap).toString());	// 전월이월금
			hmap.put(Define.IO_TYPE, TypeVal.INPUT_TYPE);
			data.put("input_amount", tranService.tranAmount(hmap).toString());	// 수입금액
			hmap.put(Define.IO_TYPE, TypeVal.OUTPUT_TYPE);
			data.put("output_amount", tranService.tranAmount(hmap).toString());	// 지출금액

			entity = new ResponseEntity<>(data, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/accounting/tran/list", method = RequestMethod.POST)
	public ResponseEntity<List<Map<Object, String>>> listPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<List<Map<Object, String>>> entity = null;
		try {
			hmap.set(map);

			List<Map<Object, String>> list = tranService.tranList(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/accounting/tran/regist", method = RequestMethod.POST, produces = "application/text;charset=utf8")
	public ResponseEntity<String> registPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			hmap.set(map);

			tranService.tranListRegist(hmap);

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

	@RequestMapping(value = "/accounting/tran/modify", method = { RequestMethod.PUT, RequestMethod.PATCH }, produces = "application/text;charset=utf8")
	public ResponseEntity<String> modifyPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			hmap.set(map);

			tranService.tranListModify(hmap);

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

	@RequestMapping(value = "/accounting/tran/delete", method = RequestMethod.DELETE, produces = "application/text;charset=utf8")
	public ResponseEntity<String> deleteDELETE(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			hmap.set(map);

			tranService.tranListDelete(hmap);

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

	@RequestMapping(value = "/accounting/tran/direct/regist", method = RequestMethod.POST, produces = "application/text;charset=utf8")
	public ResponseEntity<String> directRegistPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			hmap.set(map);

			tranService.tranDirectRegist(hmap);

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

	@RequestMapping(value = "/accounting/tran/direct/modify/{tran_code}", method = { RequestMethod.PUT, RequestMethod.PATCH }, produces = "application/text;charset=utf8")
	public ResponseEntity<String> directModifyPOST(HMap hmap, @PathVariable("tran_code") String tran_code, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			hmap.put(Define.TRAN_CODE, tran_code);

			hmap.set(map);

			tranService.tranDirectModify(hmap);

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

	@RequestMapping(value = "/accounting/tran/item/{tran_code}", method = RequestMethod.POST)
	public ResponseEntity<Map<Object, String>> itemPOST(HMap hmap, @PathVariable("tran_code") String tran_code) {
		ResponseEntity<Map<Object, String>> entity = null;
		try {
			hmap.put(Define.TRAN_CODE, tran_code);

			Map<Object, String> list = tranService.tranItem(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}


	@RequestMapping(value = "/accounting/tran/duplicate/list", method = RequestMethod.POST)
	public ResponseEntity<List<Map<Object, String>>> duplicateListPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<List<Map<Object, String>>> entity = null;
		try {
			hmap.set(map);

			List<Map<Object, String>> list = tranService.tranDuplicateList(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/accounting/tran/ghm/report/list", method = RequestMethod.POST)
	public ResponseEntity<List<Map<Object, String>>> ghmReportListPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<List<Map<Object, String>>> entity = null;
		try {
			hmap.set(map);

			List<Map<Object, String>> list = tranService.ghmReportList(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
