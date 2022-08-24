package com.jeo.webapp.accounting.room.controller;

import com.jeo.common.config.Define;
import com.jeo.common.domain.HMap;
import com.jeo.webapp.accounting.room.domain.Room;
import com.jeo.webapp.accounting.room.service.RoomService;
import com.jeo.webapp.bankda.exception.BankdaException;
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
public class RoomRestController {
	@Autowired RoomService roomService;

	@RequestMapping(value = "/accounting/room/page", method = RequestMethod.POST)
	public ResponseEntity<List<Room>> pagePOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<List<Room>> entity = null;
		try {
			hmap.set(map);

			List<Room> list = roomService.roomPage(hmap);

			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/accounting/room/item/{room_code}", method = RequestMethod.POST)
	public ResponseEntity<Map<Object, String>> itemPOST(HMap hmap, @PathVariable("room_code") String room_code) {
		ResponseEntity<Map<Object, String>> entity = null;
		try {
			hmap.put(Define.ROOM_CODE, room_code);

			Map<Object, String> item = roomService.roomItem(hmap);

			entity = new ResponseEntity<>(item, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/accounting/room/regist", method = RequestMethod.POST, produces = "application/text;charset=utf8")
	public ResponseEntity<String> registPOST(HMap hmap, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			hmap.set(map);

			roomService.roomRegist(hmap);

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/accounting/room/modify/{room_code}", method = { RequestMethod.PUT, RequestMethod.PATCH }, produces = "application/text;charset=utf8")
	public ResponseEntity<String> modifyPOST(HMap hmap, @PathVariable("room_code") String room_code, @RequestBody Map<String, Object> map) {
		ResponseEntity<String> entity = null;
		try {
			hmap.put(Define.ROOM_CODE, room_code);

			hmap.set(map);

			roomService.roomModify(hmap);

			entity = new ResponseEntity<>(Define.SUCCESS, HttpStatus.OK);
		} catch (BankdaException e) {
			e.printStackTrace();
			entity = new ResponseEntity<>("계좌오류. 입력한 정보가 정확한지 확인 후 다시 등록해주세요.", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
