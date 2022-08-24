package com.erowm.common.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class DateUtils {

	/**
	 * 오늘 날짜를 다양한 형태로 리턴한다. 예) getToday("yyyyMMdd"); getToday("yyyyMMddHHmmss");
	 * getToday("yyyy-MM-dd HH:mm:ss"); getToday("yyyy-MM-dd"); getToday("HHmm");
	 *
	 * @param type 날짜형태
	 * @return
	 */
	public static String getToday(String type) {
		if (type == null)
			return null;

		String s = new SimpleDateFormat(type).format(new Date());
		return s;
	}

	/**
	 * 오늘 날짜를 yyyyMMddHHmmss 형태로 리턴
	 *
	 * @return
	 */
	public static String getToday() {
		return getToday("yyyyMMddHHmmss");
	}

	/**
	 * 입력받은 날짜를 다양한 형태로 리턴한다. 예) getToday("yyyyMMdd"); getToday("yyyyMMddHHmmss");
	 * getToday("yyyy-MM-dd HH:mm:ss"); getToday("yyyy-MM-dd"); getToday("HHmm");
	 *
	 * @param date 날짜
	 * @param type 날짜형태
	 * @return
	 */
	public static String getDate(Date date, String type) {
		return new SimpleDateFormat(type).format(date);
	}

	/**
	 * 입력받은 문자열 날짜를 다양한 형태로 리턴한다. 문자열 날짜는 "yyyy-MM-dd" 형식으로 입력받는다.
	 * 예) getToday("yyyyMMdd"); getToday("yyyyMMddHHmmss");
	 *
	 * @param strDate 날짜
	 * @param type 날짜형태
	 * @return
	 */
	public static String getDate(String strDate, String type) {
		try {
			Date date = new SimpleDateFormat("yyyy-MM-dd").parse(strDate);
			return new SimpleDateFormat(type).format(date);
		} catch (ParseException e) {
			e.printStackTrace();
			throw new IllegalArgumentException(e.getMessage(), e);
		}
	}

	/**
	 * 이번달 마지막 일자를 yyyy-MM-dd 형태로 리턴
	 *
	 * @return
	 */
	public static String getFirstDate() {
		Calendar cal = Calendar.getInstance();
		return getDate(cal.getTime(), "yyyy-MM-01");
	}

	/**
	 * 이번달 마지막 일자를 yyyy-MM-dd 형태로 리턴
	 *
	 * @return
	 */
	public static String getLastDate() {
		Calendar cal = Calendar.getInstance();
		return getDate(cal.getTime(), "yyyy-MM-" + cal.getActualMaximum(Calendar.DAY_OF_MONTH));
	}

	/**
	 * 입력받은 두 날짜의 개월 차이를 반환한다.
	 *
	 * @param startCal	시작일자
	 * @param endCal	종료일자
	 * @return
	 */
	public static int getDiffMonth(Calendar startCal, Calendar endCal) {
		int startYear = startCal.get(Calendar.YEAR);
		int startMonth = startCal.get(Calendar.MONTH) + 1;
		int endYear = endCal.get(Calendar.YEAR);
		int endMonth = endCal.get(Calendar.MONTH) + 1;

		return (endYear * 12 + endMonth) - (startYear * 12 + startMonth);
	}

}