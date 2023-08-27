package com.jeo.web.print.controller;

import com.jeo.common.util.DateUtils;
import com.jeo.facility.domain.FacilityRepairHistory;
import com.jeo.report.dto.Report;
import com.jeo.report.dto.ReportCondition;
import com.jeo.facility.dto.FacilityPageCondition;
import com.jeo.facility.dto.RepairPageCondition;
import com.jeo.facility.service.FacilityService;
import com.jeo.facility.service.SubFacilityService;
import com.jeo.report.service.ReportService;
import com.jeo.repair.service.RepairService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class PrintHtmlController {

	@Autowired
	FacilityService facilityService;

	@Autowired
	SubFacilityService subFacilityService;

	@Autowired
	RepairService repairService;

	@Autowired
	ReportService reportService;

	@GetMapping(value = "/print/html/equipment-list")
	public void printEquipmentListGET(Model model, @ModelAttribute FacilityPageCondition condition) {
		model.addAttribute("facilities", facilityService.selectFacilityList(condition));
	}

	@GetMapping(value = "/print/html/equipment-card")
	public String printEquipmentCardGET(Model model, @RequestParam("facility_tag_no") String facility_tag_no) {
		model.addAttribute("facility", facilityService.selectFacility(facility_tag_no));
		model.addAttribute("subFacilities", subFacilityService.selectSubFacilityList(facility_tag_no));
		return "/print/html/equipment-card";
	}

	@GetMapping(value = "/print/html/repair-list")
	public void printRepairListGET(Model model, @ModelAttribute RepairPageCondition condition) {
		model.addAttribute("facility", facilityService.selectFacility(condition.getFacility_tag_no()));
		model.addAttribute("repairs", repairService.selectRepairList(condition));
	}

	@GetMapping(value = "/print/html/report1")
	public void printReport1GET(Model model, @ModelAttribute RepairPageCondition condition) {
		model.addAttribute("facility", facilityService.selectFacility(condition.getFacility_tag_no()));
		model.addAttribute("subFacilities", subFacilityService.selectSubFacilityList(condition.getFacility_tag_no()));
		model.addAttribute("repairs", repairService.selectRepairList(condition));
	}

	@GetMapping(value = "/print/html/report2")
	public void printReport2GET(Model model, @ModelAttribute ReportCondition condition) {
		Report report = Report.builder()
				.print_date(DateUtils.getToday("yyyy-MM-dd"))
				.build();
		reportService.insert(report);
		String report_no = DateUtils.getDate(report.getPrint_date(), "yyyyMMdd") + "-" + String.format("%03d", report.getPrint_no());
		model.addAttribute("report_no", report_no);

		model.addAttribute("facilities", facilityService.selectFacilityList(
				FacilityPageCondition.builder()
						.start_date(condition.getStart_date())
						.end_date(condition.getEnd_date())
						.build()));
		List<FacilityRepairHistory> facilityRepairHistory = repairService.selectFacilityRepairHistory(
				RepairPageCondition.builder()
						.start_date(condition.getStart_date())
						.end_date(condition.getEnd_date())
						.build());
		model.addAttribute("facilityRepairHistory", facilityRepairHistory);
	}

}
