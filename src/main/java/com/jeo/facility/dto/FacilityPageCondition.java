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
	private String facility_tag_no;
	private String facility_name;
	private Integer construction_code;
	private Integer category_code;
}
