package com.jeo.webapp.admin.system.ghm.controller;

import com.jeo.common.config.Define;
import com.jeo.common.domain.HMap;
import com.jeo.webapp.ghm.service.GhmService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Controller
public class AdminGhmRestController {
	@Autowired GhmService ghmService;

	@RequestMapping(value = "/admin/system/ghm/page", method = RequestMethod.POST)
	public ResponseEntity<List<Map<Object, String>>> pagePOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<List<Map<Object, String>>> entity = null;
		try {
			hmap.set(map);

			List<Map<Object, String>> list = ghmService.ghmPage(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/admin/system/ghm/item/{ghm_code}", method = RequestMethod.POST)
	public ResponseEntity<Map<Object, String>> itemPOST(HMap hmap, @PathVariable("ghm_code") String ghm_code) {
		ResponseEntity<Map<Object, String>> entity = null;
		try {
			hmap.put(Define.GHM_CODE, ghm_code);

			hmap.remove(Define.BSNS_CATE);

			Map<Object, String> list = ghmService.ghmItem(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/admin/system/ghm/overlapCheck", method = RequestMethod.POST)
	public ResponseEntity<Boolean> overlapCheckPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<Boolean> entity = null;
		try {
			hmap.set(map);

			List<Map<String, Object>> list = ghmService.overlapCheck(hmap);
			boolean overlap = list.size() > 0;

			entity = new ResponseEntity<>(overlap, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/admin/system/ghm/regist", method = RequestMethod.POST)
	public ResponseEntity<String> registPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			hmap.set(map);

			ghmService.ghmRegist(hmap);

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/admin/system/ghm/subPage", method = RequestMethod.POST)
	public ResponseEntity<List<Map<Object, String>>> subPagePOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<List<Map<Object, String>>> entity = null;
		try {
			hmap.set(map);

			List<Map<Object, String>> list = ghmService.ghmSubPage(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/admin/system/ghm/activate", method = RequestMethod.POST)
	public ResponseEntity<String> activatePOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			hmap.set(map);

			ghmService.ghmActivate(hmap);

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}


	@RequestMapping(value = "/admin/system/gwan/overlapCheck", method = RequestMethod.POST)
	public ResponseEntity<Boolean> gwanOverlapCheckPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<Boolean> entity = null;
		try {
			hmap.set(map);

			List<Map<String, Object>> list = ghmService.gwanOverlapCheck(hmap);
			boolean overlap = list.size() > 0;

			entity = new ResponseEntity<>(overlap, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/admin/system/gwan/regist", method = RequestMethod.POST)
	public ResponseEntity<String> gwanRegistPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			hmap.set(map);

			ghmService.gwanRegist(hmap);

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/admin/system/gwan/item/{gwan_code}", method = RequestMethod.POST)
	public ResponseEntity<Map<Object, String>> gwanItemPOST(HMap hmap, @PathVariable("gwan_code") String gwan_code) {
		ResponseEntity<Map<Object, String>> entity = null;
		try {
			hmap.put(Define.GWAN_CODE, gwan_code);

			Map<Object, String> list = ghmService.gwanItem(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/admin/system/gwan/modify/{gwan_code}", method = { RequestMethod.PUT, RequestMethod.PATCH })
	public ResponseEntity<String> gwanModifyPOST(HMap hmap, @PathVariable("gwan_code") String gwan_code, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			hmap.put(Define.GWAN_CODE, gwan_code);

			hmap.set(map);

			ghmService.gwanModify(hmap);

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/admin/system/gwan/delete/{gwan_code}", method = RequestMethod.DELETE, produces = "application/text;charset=utf8")
	public ResponseEntity<String> gwanDeletePOST(HMap hmap, @PathVariable("gwan_code") String gwan_code, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			hmap.put(Define.GWAN_CODE, gwan_code);

			hmap.set(map);

			ghmService.gwanDelete(hmap);

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (SQLException e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}


	@RequestMapping(value = "/admin/system/hang/overlapCheck", method = RequestMethod.POST)
	public ResponseEntity<Boolean> hangOverlapCheckPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<Boolean> entity = null;
		try {
			hmap.set(map);

			List<Map<String, Object>> list = ghmService.hangOverlapCheck(hmap);
			boolean overlap = list.size() > 0;

			entity = new ResponseEntity<>(overlap, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/admin/system/hang/regist", method = RequestMethod.POST)
	public ResponseEntity<String> hangRegistPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			hmap.set(map);

			ghmService.hangRegist(hmap);

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/admin/system/hang/item/{hang_code}", method = RequestMethod.POST)
	public ResponseEntity<Map<Object, String>> hangItemPOST(HMap hmap, @PathVariable("hang_code") String hang_code) {
		ResponseEntity<Map<Object, String>> entity = null;
		try {
			hmap.put(Define.HANG_CODE, hang_code);

			Map<Object, String> list = ghmService.hangItem(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/admin/system/hang/modify/{hang_code}", method = { RequestMethod.PUT, RequestMethod.PATCH })
	public ResponseEntity<String> hangModifyPOST(HMap hmap, @PathVariable("hang_code") String hang_code, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			hmap.put(Define.HANG_CODE, hang_code);

			hmap.set(map);

			ghmService.hangModify(hmap);

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/admin/system/hang/delete/{hang_code}", method = RequestMethod.DELETE, produces = "application/text;charset=utf8")
	public ResponseEntity<String> hangDeletePOST(HMap hmap, @PathVariable("hang_code") String hang_code, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			hmap.put(Define.HANG_CODE, hang_code);

			hmap.set(map);

			ghmService.hangDelete(hmap);

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (SQLException e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}


	@RequestMapping(value = "/admin/system/mock/overlapCheck", method = RequestMethod.POST)
	public ResponseEntity<Boolean> mockOverlapCheckPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<Boolean> entity = null;
		try {
			hmap.set(map);

			List<Map<String, Object>> list = ghmService.mockOverlapCheck(hmap);
			boolean overlap = list.size() > 0;

			entity = new ResponseEntity<>(overlap, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/admin/system/mock/regist", method = RequestMethod.POST)
	public ResponseEntity<String> mockRegistPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			hmap.set(map);

			ghmService.mockRegist(hmap);

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/admin/system/mock/item/{mock_code}", method = RequestMethod.POST)
	public ResponseEntity<Map<Object, String>> mockItemPOST(HMap hmap, @PathVariable("mock_code") String mock_code) {
		ResponseEntity<Map<Object, String>> entity = null;
		try {
			hmap.put(Define.MOCK_CODE, mock_code);

			Map<Object, String> list = ghmService.mockItem(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/admin/system/mock/modify/{mock_code}", method = { RequestMethod.PUT, RequestMethod.PATCH })
	public ResponseEntity<String> mockModifyPOST(HMap hmap, @PathVariable("mock_code") String mock_code, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			hmap.put(Define.MOCK_CODE, mock_code);

			hmap.set(map);

			ghmService.mockModify(hmap);

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/admin/system/mock/delete/{mock_code}", method = RequestMethod.DELETE, produces = "application/text;charset=utf8")
	public ResponseEntity<String> mockDeletePOST(HMap hmap, @PathVariable("mock_code") String mock_code, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			hmap.put(Define.MOCK_CODE, mock_code);

			hmap.set(map);

			ghmService.mockDelete(hmap);

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (SQLException e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}


	@RequestMapping(value = "/admin/system/ghm/report/list", method = RequestMethod.POST)
	public ResponseEntity<List<Map<Object, String>>> ghmReportListPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<List<Map<Object, String>>> entity = null;
		try {
			hmap.set(map);

			List<Map<Object, String>> list = ghmService.ghmReportList(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/admin/system/ghm/report/regist", method = RequestMethod.POST, produces = "application/text;charset=utf8")
	public ResponseEntity<String> ghmReportRegistPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			hmap.set(map);

			ghmService.ghmReportRegist(hmap);

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}


	@RequestMapping(value = "/admin/system/ghm/report/delete/{ghmr_code}", method = RequestMethod.DELETE, produces = "application/text;charset=utf8")
	public ResponseEntity<String> ghmReportDeletePOST(HMap hmap, @PathVariable("ghmr_code") String ghmr_code) {
		ResponseEntity<String> entity = null;
		try {
			hmap.put(Define.GHMR_CODE, ghmr_code);

			ghmService.ghmReportDelete(hmap);

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
