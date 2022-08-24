package com.jeo.webapp.accounting.parent.controller;

import com.jeo.common.domain.HMap;
import com.jeo.webapp.accounting.parent.domain.Parent;
import com.jeo.webapp.accounting.parent.service.ParentService;
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
public class ParentRestController {
	@Autowired
	ParentService parentService;

	@RequestMapping(value = "/accounting/parent/list", method = RequestMethod.POST)
	public ResponseEntity<List<Parent>> listPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<List<Parent>> entity = null;
		try {
			hmap.set(map);

			List<Parent> list = parentService.parentList(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
