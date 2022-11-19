package com.jeo.facility.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Facility {
	private String facility_tag_no;
	private String facility_name;
	private Integer construction_code;
	private Integer category_code;
	private Integer facility_quantity;
	private Integer purchase_price;
	private String emplacement;
	private String production_company;
	private String form;
	private String installer;
	private String specification;
	private String installation_purpose;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate manufacture_date;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate completion_date;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate durable;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate major_repaircompletion_date;
	private String major_repair_content;
	private String major_repair_installer;
	private LocalDateTime facility_reg_date;
	private LocalDateTime facility_mod_date;
	private String facility_mod_user;

	/* 전동기 관련 컬럼 */
	private String electric_motor_form;
	private String electric_motor_rpm;
	private String electric_motor_production_company;
	private String electric_motor_volume;
	private String electric_motor_starting_method;
	private String electric_motor_power;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate electric_motor_production_date;
	private String motor_bearing_no_1;
	private String motor_bearing_no_2;
	private String pump_reducer_bearing_no_1;
	private String pump_reducer_bearing_no_2;

	private String facility_image_path;
}
