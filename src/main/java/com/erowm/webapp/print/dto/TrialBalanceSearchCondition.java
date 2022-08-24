package com.erowm.webapp.print.dto;

import lombok.Builder;

@Builder
public class TrialBalanceSearchCondition {
	String comp_code;
	String bsns_code;
	int session_year;
	int session_start_month;
	String bsns_cate;
}
