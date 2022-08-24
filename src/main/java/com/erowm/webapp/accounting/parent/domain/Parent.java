package com.erowm.webapp.accounting.parent.domain;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class Parent {
	String comp_code;
	String bsns_code;
	String child_code;
	String parent_code;
	String child_name;
	String parent_reg_numb_1;
	String parent_reg_numb_2;
	String parent_mobile;
	ParentType parent_type;
	String parent_type_name;
	Date parent_reg_date;
	Date parent_mod_date;
	String parent_mod_user;
	String parent_mod_user_name;

	public void setParent_type(ParentType parent_type) {
		this.parent_type = parent_type;
		this.parent_type_name = parent_type.getLabel();
	}
}
