package com.jeo.webapp.bankda.exception;

public class BankdaException extends RuntimeException {
	public BankdaException(String result) {
		super(result);
	}
}
