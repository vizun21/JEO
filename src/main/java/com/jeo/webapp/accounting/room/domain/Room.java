package com.jeo.webapp.accounting.room.domain;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class Room {
	String comp_code;
	String bsns_code;
	String room_code;
	String room_name;
	int room_limit;
	String room_teacher_name;
	String room_sub_teacher_name;
	Date room_reg_date;
	Date room_mod_date;
	String room_mod_user;
	String room_mod_user_name;
}
