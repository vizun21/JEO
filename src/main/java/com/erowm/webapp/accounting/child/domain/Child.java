package com.erowm.webapp.accounting.child.domain;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class Child {
	String comp_code;
	String bsns_code;
	String child_code;
	String child_name;
	String child_reg_numb_1;
	String child_reg_numb_2;
	Date child_admission_date;
	Date child_graduation_date;
	String child_zipcode;
	String child_addr;
	String child_detail_addr;
	EnrollmentStatus child_status;
	String child_status_name;
	String room_code;
	String room_name;
	Date child_reg_date;
	Date child_mod_date;
	String child_mod_user;
	String child_mod_user_name;

	public void setChild_status(EnrollmentStatus child_status) {
		this.child_status = child_status;
		this.child_status_name = this.child_status.getLabel();
	}
}
