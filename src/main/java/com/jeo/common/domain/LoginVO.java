package com.jeo.common.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class LoginVO {
	private String user_id;
	private String user_pw;
	private String user_name;
	private String user_email;
	private String user_tel;
	private String user_mobile;
	private String user_reg_numb_1;
	private String user_reg_numb_2;
	private String user_reg_numb;
	private String user_join_date;
	private String user_sales;
	private int user_level;
	private String user_appr_yn;
	private String user_yn;
	private String user_login_date;
	private String user_reg_date;
	private String user_mod_date;
	private String user_mod_user;
	private String comp_code;
	private String comp_type;
	private String comp_reg_numb_1;
	private String comp_reg_numb_2;
	private String comp_reg_numb_3;
	private String comp_reg_numb;
	private String comp_name;
	private String comp_bankda_pw;
	private String comp_appr_yn;
	private String comp_exp_date;
	private String ceo_yn;
}
