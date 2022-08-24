package com.erowm.webapp.bankda.exception;

public class BankdaException extends RuntimeException {
	public BankdaException(String result) {
		super(result);
	}
}
