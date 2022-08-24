package com.erowm.common.util;

import org.junit.Test;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

public class CommonUtilsTest {
	@Test
	public void genRamdomPassword() {
		String pw = CommonUtils.genRandPassword(10);

		System.out.println(pw);
		assertThat(pw.length(), is(10));
	}

	@Test
	public void isEmpty() {
		assertThat(CommonUtils.isEmpty(""), is(true));
		assertThat(CommonUtils.isEmpty("1"), is(false));
	}

	@Test
	public void isNotEmpty() {
		assertThat(CommonUtils.isNotEmpty(""), is(false));
		assertThat(CommonUtils.isNotEmpty("1"), is(true));
	}

	@Test
	public void isNumber() {
		assertThat(CommonUtils.isNumber("123456"), is(true));
		assertThat(CommonUtils.isNumber("sdf1sdf"), is(false));
		assertThat(CommonUtils.isNumber("123d1564"), is(false));
	}

	@Test
	public void isValidJuminRegNumb() {
		assertThat(CommonUtils.isValidJuminRegNumb("950729", "2484110"), is(true));
		assertThat(CommonUtils.isValidJuminRegNumb("950729", "2484111"), is(false));
		assertThat(CommonUtils.isValidJuminRegNumb("9507xx", "24841xx"), is(false));
		assertThat(CommonUtils.isValidJuminRegNumb("9507290", "24841100"), is(false));
		assertThat(CommonUtils.isValidJuminRegNumb("660703", "1528217"), is(true));
	}

	@Test
	public void isValideCompRegNumb() {
		assertThat(CommonUtils.isValidCompRegNumb("418", "01", "88316"), is(true));
		assertThat(CommonUtils.isValidCompRegNumb("418", "01", "88315"), is(false));
		assertThat(CommonUtils.isValidCompRegNumb("418", "01", "88xxx"), is(false));
		assertThat(CommonUtils.isValidCompRegNumb("418", "01", "8800000"), is(false));
	}
}
