package com.jeo.webapp.accounting.print.controller;

import com.jeo.common.domain.HMap;
import com.jeo.webapp.accounting.print.service.PrintService;
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
public class PrintRestController {
	@Autowired
	PrintService printService;

	@RequestMapping(value = "/accounting/print/transaction", method = RequestMethod.POST)
	public ResponseEntity<List<Map<String, Object>>> transactionPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<List<Map<String, Object>>> entity = null;
		try {
			hmap.set(map);

			List<Map<String, Object>> list = printService.transactionList(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/accounting/print/voucher", method = RequestMethod.POST)
	public ResponseEntity<List<Map<String, Object>>> voucherPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<List<Map<String, Object>>> entity = null;
		try {
			hmap.set(map);

			List<Map<String, Object>> list = printService.voucher(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/accounting/print/voucher2", method = RequestMethod.POST)
	public ResponseEntity<List<Map<String, Object>>> voucher2POST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<List<Map<String, Object>>> entity = null;
		try {
			hmap.set(map);

			List<Map<String, Object>> list = printService.voucher2(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/accounting/print/budget", method = RequestMethod.POST)
	public ResponseEntity<List<Map<String, Object>>> budgetPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<List<Map<String, Object>>> entity = null;
		try {
			hmap.set(map);

			List<Map<String, Object>> list = printService.budget(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
