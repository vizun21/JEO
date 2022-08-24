package com.erowm.webapp.accounting.child.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum EnrollmentStatus {
	ATTEND("재학"), GRADUATION("졸업"), EXPEL("퇴학");

	private String label;
}
