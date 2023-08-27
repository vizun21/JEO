package com.jeo.facility.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DeleteSubFacilityList {
	private List<SubFacility> DeleteSubFacilities;
}
