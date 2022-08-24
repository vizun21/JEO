package com.erowm.webapp.accounting.child.controller;

import com.erowm.common.config.Define;
import com.erowm.common.domain.HMap;
import com.erowm.webapp.accounting.child.domain.Child;
import com.erowm.webapp.accounting.child.service.ChildService;
import com.erowm.webapp.accounting.parent.service.ParentService;
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
public class ChildRestController {
	@Autowired ChildService childService;
	@Autowired ParentService parentService;

	@RequestMapping(value = "/accounting/child/page", method = RequestMethod.POST)
	public ResponseEntity<List<Child>> pagePOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<List<Child>> entity = null;
		try {
			hmap.set(map);

			List<Child> list = childService.childPage(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/accounting/child/item/{child_code}", method = RequestMethod.POST)
	public ResponseEntity<Map<Object, String>> itemPOST(HMap hmap, @PathVariable("child_code") String child_code) {
		ResponseEntity<Map<Object, String>> entity = null;
		try {
			hmap.put(Define.CHILD_CODE, child_code);

			Map<Object, String> item = childService.childItem(hmap);

			entity = new ResponseEntity<>(item, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/accounting/child/regist", method = RequestMethod.POST, produces = "application/text;charset=utf8")
	public ResponseEntity<String> registPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			hmap.set(map);

			childService.childRegist(hmap);

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/accounting/child/modify/{child_code}", method = { RequestMethod.PUT, RequestMethod.PATCH }, produces = "application/text;charset=utf8")
	public ResponseEntity<String> modifyPOST(HMap hmap, @PathVariable("child_code") String child_code, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			hmap.put(Define.CHILD_CODE, child_code);

			hmap.set(map);

			childService.childModify(hmap);

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
