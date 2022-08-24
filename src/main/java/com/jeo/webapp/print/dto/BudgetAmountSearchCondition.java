package com.jeo.webapp.print.dto;

import lombok.Builder;

@Builder
public class BudgetAmountSearchCondition {
	String comp_code;
	String bsns_code;
	int session_year;
	String budg_type;
	IOType io_type;
}
