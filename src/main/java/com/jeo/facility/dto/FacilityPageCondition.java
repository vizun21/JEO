package com.jeo.facility.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FacilityPageCondition {
	private String facility_tag_no_keyword;
	private String facility_name_keyword;
	private Integer construction_code;
	private Integer category_code;
	private String start_date;
	private String end_date;
}
