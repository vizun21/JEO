package com.jeo.user.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class User {
	private String comp_code;
	private String user_id;
	private String user_pw;
	private String user_name;
	private String user_email;
	private String user_tel;
	private String user_mobile;
	private String user_reg_numb_1;
	private String user_reg_numb_2;
	private String user_join_date;
	private String user_sales;
	private String user_position;
	private int user_level;
	private String user_appr_yn;
	private String user_yn;
	private String password_hint;
	private String password_hint_answer;
	private String user_login_date;
	private String user_reg_date;
	private String user_mod_date;
	private String user_mod_user;

	public void retirement() {
		this.user_yn = "N";
	}
}
