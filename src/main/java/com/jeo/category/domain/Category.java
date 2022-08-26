package com.jeo.category.domain;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class Category {
	private String category_code;
	private String category_name;
	private String category_reg_date;
	private String category_mod_date;
	private String category_mod_user;
}
