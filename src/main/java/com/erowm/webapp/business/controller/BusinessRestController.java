package com.erowm.webapp.business.controller;

import com.erowm.common.config.Define;
import com.erowm.common.domain.HMap;
import com.erowm.common.util.SessionUtils;
import com.erowm.webapp.business.service.BusinessService;
import com.erowm.webapp.upload.image.service.UploadImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.util.List;
import java.util.Map;

@Controller
public class BusinessRestController {
	@Autowired
	BusinessService businessService;
	@Autowired
	UploadImageService uploadImageService;

	@RequestMapping(value = "/mybusiness/page", method = RequestMethod.POST)
	public ResponseEntity<List<Map<Object, String>>> pagePOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<List<Map<Object, String>>> entity = null;
		try {
			hmap.set(map);

			List<Map<Object, String>> list = businessService.businessPage(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/mybusiness/item/{bsns_code}", method = RequestMethod.POST)
	public ResponseEntity<Map<Object, String>> itemPOST(HMap hmap, @PathVariable("bsns_code") String bsns_code) {
		ResponseEntity<Map<Object, String>> entity = null;
		try {
			hmap.put(Define.BSNS_CODE, bsns_code);

			Map<Object, String> list = businessService.businessItem(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/mybusiness/regist", method = RequestMethod.POST)
	public ResponseEntity<String> registPOST(HMap hmap, MultipartHttpServletRequest request) {
		ResponseEntity<String> entity = null;
		try {
			hmap.putRequestAll(request.getParameterMap());

			/* 이미지 처리 */
			MultipartFile bsns_director_stamp = request.getFile("bsns_director_stamp");
			if (bsns_director_stamp.getSize() != 0) {
				hmap.put("bsns_director_stamp", uploadImageService.fileUpload(bsns_director_stamp));
			}

			MultipartFile bsns_manager_stamp = request.getFile("bsns_manager_stamp");
			if (bsns_manager_stamp.getSize() != 0) {
				hmap.put("bsns_manager_stamp", uploadImageService.fileUpload(bsns_manager_stamp));
			}

			MultipartFile bsns_seal = request.getFile("bsns_seal");
			if (bsns_seal.getSize() != 0) {
				hmap.put("bsns_seal", uploadImageService.fileUpload(bsns_seal));
			}

			businessService.businessRegist(hmap);

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/mybusiness/modify/{bsns_code}", method = RequestMethod.POST)
	public ResponseEntity<String> modifyPOST(HMap hmap, @PathVariable("bsns_code") String bsns_code, MultipartHttpServletRequest request) {
		ResponseEntity<String> entity = null;
		try {
			hmap.put(Define.BSNS_CODE, bsns_code);

			hmap.putRequestAll(request.getParameterMap());

			/* 이미지 처리 */
			MultipartFile bsns_director_stamp = request.getFile("bsns_director_stamp");
			if (bsns_director_stamp.getSize() != 0) {
				hmap.put("bsns_director_stamp", uploadImageService.fileUpload(bsns_director_stamp));
			}

			MultipartFile bsns_manager_stamp = request.getFile("bsns_manager_stamp");
			if (bsns_manager_stamp.getSize() != 0) {
				hmap.put("bsns_manager_stamp", uploadImageService.fileUpload(bsns_manager_stamp));
			}

			MultipartFile bsns_seal = request.getFile("bsns_seal");
			if (bsns_seal.getSize() != 0) {
				hmap.put("bsns_seal", uploadImageService.fileUpload(bsns_seal));
			}

			businessService.businessModify(hmap);

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/mybusiness/transform/{bsns_code}", method = RequestMethod.POST)
	public ResponseEntity<String> transformPOST(HMap hmap, @PathVariable("bsns_code") String bsns_code) {
		ResponseEntity<String> entity = null;
		try {
			hmap.put(Define.BSNS_CODE, bsns_code);

			SessionUtils.setAttribute(Define.businessVO, businessService.businessVO(hmap));

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
