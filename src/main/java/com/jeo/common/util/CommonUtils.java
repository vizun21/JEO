package com.jeo.common.util;

import com.jeo.common.config.Define;

import javax.servlet.http.HttpServletRequest;

public class CommonUtils {
	public static String genCode(String prefix, String date, int index, int digit) {
		date = DateUtils.getDate(date, "yyyyMMdd");
		return prefix + date + String.format("%0" + digit + "d", index);
	}

	public static String genRandPassword(int len) {
		char[] charSet = new char[]{'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'};
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < len; i++) {
			int idx = (int) (charSet.length * Math.random()); // 36 * 생성된 난수를 Int로 추출 (소숫점제거)
			sb.append(charSet[idx]);
		}
		return sb.toString();
	}

	public static boolean isEmpty(Object obj) {
		if (obj == null) return true;
		if ((obj instanceof String) && (((String) obj).trim().length() == 0)) return true;
		return false;
	}

	public static boolean isNotEmpty(Object obj) {
		return !isEmpty(obj);
	}

	public static boolean isNumber(String str) {
		String reg = "[+-]?\\d*(\\.\\d+)?";
		return str.matches(reg);
	}

	public static boolean isValidJuminRegNumb(String reg_numb_1, String reg_numb_2) {
		if (reg_numb_1.length() != 6) return false;
		if (reg_numb_2.length() != 7) return false;
		if (!isNumber(reg_numb_1)) return false;	// 숫자인지 검증
		if (!isNumber(reg_numb_2)) return false;	// 숫자인지 검증

		int n = 2;
		int sum = 0;
		for (int i = 0; i < reg_numb_1.length(); i++) {
			sum += Integer.parseInt(reg_numb_1.substring(i, i+1)) * n++;
		}
		for (int i = 0; i < reg_numb_2.length() - 1; i++) {
			sum += Integer.parseInt(reg_numb_2.substring(i, i+1)) * n++;
			if (n == 10) n = 2;
		}

		int checkSum = (11 - sum % 11) % 10;
		if (checkSum != Integer.parseInt(reg_numb_2.substring(6, 7))) {
			return false;
		}

		return true;
	}

	public static boolean isValidCompRegNumb(String reg_numb_1, String reg_numb_2, String reg_numb_3) {
		if (reg_numb_1.length() != 3) return false;
		if (reg_numb_2.length() != 2) return false;
		if (reg_numb_3.length() != 5) return false;
		if (!isNumber(reg_numb_1)) return false;	// 숫자인지 검증
		if (!isNumber(reg_numb_2)) return false;	// 숫자인지 검증
		if (!isNumber(reg_numb_3)) return false;	// 숫자인지 검증

		String reg_numb = reg_numb_1 + reg_numb_2 + reg_numb_3;

		int sum = 0;
		int[] keyArr = {1, 3, 7, 1, 3, 7, 1, 3, 5};

		for (int i = 0; i < reg_numb.length()-1; i++) {
			sum += Integer.parseInt(reg_numb.substring(i, i+1)) * keyArr[i];
		}

		int checkSum = (10 - ((sum + (int) Math.floor((Integer.parseInt(reg_numb.substring(8, 9)) * keyArr[8]) / 10)) % 10)) % 10;
		if (checkSum != Integer.parseInt(reg_numb_3.substring(4, 5))) {
			return false;
		}

		return true;
	}

	public static void saveDestination(HttpServletRequest request) {
		String uri = request.getRequestURI();
		String query = request.getQueryString();

		if (query == null || query.equals("null")) {
			query = "";
		} else {
			query = "?" + query;
		}

		if (request.getMethod().equals("GET")) {
			request.getSession().setAttribute(Define.DESTINATION, uri + query);
		}
	}
}
