package com.jeo.common.util;

import com.jeo.common.config.Define;
import com.jeo.common.domain.HMap;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

/* 회기년도/일자 관련 함수 */
public class SessionDateUtils {
	/**
	 * 조회시작/종료일을 기준으로 회계년도 및 회계 시작종료일 구해서 hmap에 추가한다.
	 * 예)	"start_year"	-> "2021",	"start_month"	-> "4"
	 * 		"end_year"		-> "2021",	"end_month"		-> "6"	(종료년도, 월은 조회할 년월까지)
	 * 		"bsns_sess_start_month"	-> "3" 이면
	 *
	 * 		"session_year"	-> 2021,			"session_start_date"	-> "2021-03-01"
	 * 		"start_date"	-> "2021-04-01",	"end_date"	-> "2021-07-01"	(종료일자는 종료년월의 다음월 1일로 설정)
	 * 		"months"		-> 3
	 *
	 * @param hmap	start_year, start_month, end_year, end_month, bsns_sess_start_month 반드시 포함되어야 함
	 */
	public static void setSessionInfo(HMap hmap) {
		int start_year = hmap.getInt(Define.START_YEAR);
		int start_month = hmap.getInt(Define.START_MONTH);
		int end_year = hmap.getInt(Define.END_YEAR);
		int end_month = hmap.getInt(Define.END_MONTH);
		int bsns_sess_start_month = hmap.getInt(Define.BSNS_SESS_START_MONTH);

		int session_year = bsns_sess_start_month <= start_month ? start_year : start_year - 1;
		hmap.put(Define.SESSION_YEAR, session_year);

		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");

		Calendar sessStartCal = Calendar.getInstance();
		sessStartCal.set(session_year, bsns_sess_start_month-1, 1);
		hmap.put(Define.SESSION_START_DATE, df.format(sessStartCal.getTime()));
		sessStartCal.add(Calendar.YEAR, 1);
		hmap.put(Define.SESSION_END_DATE, df.format(sessStartCal.getTime()));

		Calendar startCal = Calendar.getInstance();
		startCal.set(start_year, start_month - 1, 1);
		hmap.put(Define.START_DATE, df.format(startCal.getTime()));

		Calendar endCal = Calendar.getInstance();
		endCal.set(end_year, end_month, 1);
		hmap.put(Define.END_DATE, df.format(endCal.getTime()));

		hmap.put(Define.MONTHS, DateUtils.getDiffMonth(startCal, endCal));
	}

	/**
	 * 조회시작일을 기준으로 회계년도를 구해서 반환한다.
	 * @param start_year
	 * @param start_month
	 * @param bsns_sess_start_month
	 * @return int sessionYear(회계년도)
	 */
	public static int getSessionYear(int start_year, int start_month, int bsns_sess_start_month) {
		return bsns_sess_start_month <= start_month ? start_year : start_year - 1;
	}

}
