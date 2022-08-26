package com.jeo.facility.domain;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class Facility {
	private String facility_tag_no;
	private String facility_name;
	private int construction_code;
	private int category_code;
	private int facility_quantity;
	private int purchase_price;
	private String emplacement;
	private String production_company;
	private String form;
	private String installer;
	private String specification;
	private String installation_purpose;
	private Date manufacture_date;
	private Date completion_date;
	private Date durable;
	private Date major_repaircompletion_date;
	private String major_repair_content;
	private String major_repair_installer;
	private String facility_reg_date;
	private String facility_mod_date;
	private String facility_mod_user;
}
