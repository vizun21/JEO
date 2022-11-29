package com.jeo.facility.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SubFacility {
	private String facility_tag_no;
	private Integer sub_facility_no;
	private String sub_facility_name;
	private String sub_facility_spec;
	private Integer sub_facility_quantity;
	private String sub_facility_production_company;
	private String sub_facility_note;
}
