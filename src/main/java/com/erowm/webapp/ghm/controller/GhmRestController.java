package com.erowm.webapp.ghm.controller;

import com.erowm.common.domain.HMap;
import com.erowm.webapp.ghm.service.GhmService;
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
public class GhmRestController {
	@Autowired
	GhmService ghmService;

	@RequestMapping(value = "/ghm/gwan/list", method = RequestMethod.POST)
	public ResponseEntity<List<Map<Object, String>>> gwanListPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<List<Map<Object, String>>> entity = null;
		try {
			hmap.set(map);

			List<Map<Object, String>> list = ghmService.gwanList(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/ghm/hang/list", method = RequestMethod.POST)
	public ResponseEntity<List<Map<Object, String>>> hangListPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<List<Map<Object, String>>> entity = null;
		try {
			hmap.set(map);

			List<Map<Object, String>> list = ghmService.hangList(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/ghm/mock/list", method = RequestMethod.POST)
	public ResponseEntity<List<Map<Object, String>>> mockListPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<List<Map<Object, String>>> entity = null;
		try {
			hmap.set(map);

			List<Map<Object, String>> list = ghmService.mockList(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
