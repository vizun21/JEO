package com.jeo.facility.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RepairPageCondition {
	private String repair_date;
	private String facility_tag_no;
	private String repair_company;
	private String repair_manager;
}
