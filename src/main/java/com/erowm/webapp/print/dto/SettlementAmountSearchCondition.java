package com.erowm.webapp.print.dto;

import lombok.Builder;

@Builder
public class SettlementAmountSearchCondition {
	String comp_code;
	String bsns_code;
	int session_year;
	IOType io_type;
}
