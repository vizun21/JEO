package com.jeo.webapp.accounting.trial.balance.controller;

import com.jeo.common.domain.HMap;
import com.jeo.webapp.accounting.trial.balance.service.TrialBalanceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;
import java.util.Map;

@Controller
public class TrialBalanceRestController {
	@Autowired TrialBalanceService trialBalanceService;

	@RequestMapping(value = "/accounting/trial/balance/total", method = RequestMethod.POST)
	public ResponseEntity<List<Map<Object, String>>> totalPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<List<Map<Object, String>>> entity = null;
		try {
			hmap.set(map);

			List<Map<Object, String>> list = trialBalanceService.trialBalanceTotal(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/accounting/trial/balance/annual", method = RequestMethod.POST)
	public ResponseEntity<List<Map<Object, String>>> annualPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<List<Map<Object, String>>> entity = null;
		try {
			hmap.set(map);

			List<Map<Object, String>> list = trialBalanceService.trialBalanceAnnual(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
