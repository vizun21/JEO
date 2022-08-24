package com.jeo.common.util;

import org.junit.Test;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

public class DateUtilsTest {

	@Test
	public void getLastDate(){
		assertThat(DateUtils.getLastDate(), is("2021-04-30"));
	}

	@Test
	public void getDate(){
		assertThat(DateUtils.getDate("2021-04-16", "yyyy-MM-dd"), is("2021-04-16"));
		assertThat(DateUtils.getDate("2021-04-16", "yyyyMMdd"), is("20210416"));
	}

	@Test(expected = IllegalArgumentException.class)
	public void getDateException(){
		DateUtils.getDate("20210416", "yyyy-MM-dd");
	}
}
