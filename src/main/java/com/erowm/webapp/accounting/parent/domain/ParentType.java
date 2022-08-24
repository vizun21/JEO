package com.erowm.webapp.accounting.parent.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ParentType {
	F("부"), M("모"), GF("조부"), GM("조모"), ETC("기타");

	private String label;
}
