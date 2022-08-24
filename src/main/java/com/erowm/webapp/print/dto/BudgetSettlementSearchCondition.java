package com.erowm.webapp.print.dto;

import lombok.Builder;

@Builder
public class BudgetSettlementSearchCondition {
	String comp_code;
	String bsns_code;
	int session_year;
	String bsns_cate;
	IOType io_type;
}
