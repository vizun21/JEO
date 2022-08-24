package com.jeo.webapp.accounting.budgetSettlement.domain;

import lombok.Getter;

import java.math.BigInteger;
import java.util.List;

@Getter
public class GeneralLedger {
	String mock_code;
	String mock_name;
	BigInteger current_budg_amount;
	BigInteger input_tran_amount;
	BigInteger output_tran_amount;
	BigInteger input_accumulated_amount;
	BigInteger output_accumulated_amount;
	BigInteger balance;
	List<GeneralLedgerDetails> generalLedgerDetails;

	@Getter
	public class GeneralLedgerDetails {
		String tran_date;
		String tran_proof_numb;
		String tran_jukyo;
		BigInteger tran_input_price;
		BigInteger tran_output_price;
	}
}
