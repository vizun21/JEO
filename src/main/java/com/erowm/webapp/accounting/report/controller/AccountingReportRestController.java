package com.erowm.webapp.accounting.report.controller;

import com.erowm.common.config.Define;
import com.erowm.common.domain.HMap;
import com.erowm.webapp.childcare.service.ChildcareService;
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
public class AccountingReportRestController {
	@Autowired
	ChildcareService childcareService;

	@RequestMapping(value = "/accounting/report/item/{repo_code}", method = RequestMethod.POST)
	public ResponseEntity<Map<Object, String>> itemPOST(HMap hmap, @PathVariable("repo_code") String repo_code) {
		ResponseEntity<Map<Object, String>> entity = null;
		try {
			hmap.put(Define.REPO_CODE, repo_code);

			Map<Object, String> list = childcareService.childcareReportItem(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/accounting/report/monthly/page", method = RequestMethod.POST)
	public ResponseEntity<List<Map<Object, String>>> monthlyPagePOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<List<Map<Object, String>>> entity = null;
		try {
			hmap.set(map);

			List<Map<Object, String>> list = childcareService.monthlyPage(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/accounting/report/monthly/regist", method = RequestMethod.POST, produces = "application/text;charset=utf8")
	public ResponseEntity<String> monthlyRegistPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			hmap.set(map);

			childcareService.monthlyRegist(hmap);

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}


	@RequestMapping(value = "/accounting/report/budget/page", method = RequestMethod.POST)
	public ResponseEntity<List<Map<Object, String>>> budgetPagePOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<List<Map<Object, String>>> entity = null;
		try {
			hmap.set(map);

			List<Map<Object, String>> list = childcareService.budgetPage(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/accounting/report/budget/regist", method = RequestMethod.POST, produces = "application/text;charset=utf8")
	public ResponseEntity<String> budgetRegistPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			hmap.set(map);

			childcareService.budgetRegist(hmap);

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}


	@RequestMapping(value = "/accounting/report/settlement/page", method = RequestMethod.POST)
	public ResponseEntity<List<Map<Object, String>>> settlementPagePOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<List<Map<Object, String>>> entity = null;
		try {
			hmap.set(map);

			List<Map<Object, String>> list = childcareService.settlementPage(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}


	@RequestMapping(value = "/accounting/report/settlement/data", method = RequestMethod.POST)
	public ResponseEntity<List<Map<Object, String>>> settlementDataPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<List<Map<Object, String>>> entity = null;
		try {
			hmap.set(map);

			List<Map<Object, String>> list = childcareService.settlementData(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/accounting/report/settlement/regist", method = RequestMethod.POST, produces = "application/text;charset=utf8")
	public ResponseEntity<String> settlementRegistPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			hmap.set(map);

			childcareService.settlementRegist(hmap);

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

}
