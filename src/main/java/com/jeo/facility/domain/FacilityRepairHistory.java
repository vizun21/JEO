package com.jeo.facility.domain;

import com.jeo.repair.domain.Repair;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FacilityRepairHistory {
	private String facility_tag_no;
	private String facility_name;
	private List<Repair> repairs;
}
