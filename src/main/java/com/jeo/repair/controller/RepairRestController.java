package com.jeo.repair.controller;

import com.jeo.repair.domain.Repair;
import com.jeo.repair.service.RepairService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class RepairRestController {
	@Autowired
	RepairService repairService;

	@GetMapping(value = "/facility/repair/{repair_no}")
	public ResponseEntity<Repair> facilityEquipmentGET(Model model, @PathVariable("repair_no") String repair_no) {
		ResponseEntity<Repair> entity;
		try {
			Repair repair = repairService.selectRepair(repair_no);

			entity = new ResponseEntity<>(repair, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@PostMapping("/facility/repair/modify")
	public String updateRepair(Repair repair) {
		repairService.updateRepair(repair);

		return "redirect:/facility/repair?facility_tag_no=" + repair.getFacility_tag_no();
	}
}
