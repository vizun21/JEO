package com.jeo.repair.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Repair {
	private Integer repair_no;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate repair_date;
	private String repair_type;
	private String facility_tag_no;
	private String facility_name;
	private String repair_content;
	private String repair_cause;
	private String repair_company;
	private String repair_company_tel;
	private Integer repair_price;
	private String repair_manager;
	private String repair_note;
}
