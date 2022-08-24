package com.erowm.webapp.accounting.deadline.service;

import com.erowm.common.config.Define;
import com.erowm.common.config.TypeVal;
import com.erowm.common.domain.HMap;
import com.erowm.common.exception.AlertException;
import com.erowm.webapp.accounting.deadline.dao.DeadlineDao;
import com.erowm.webapp.accounting.tran.service.BankTranService;
import com.erowm.webapp.accounting.tran.service.TranService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigInteger;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

@Service
public class DeadlineService {
	@Autowired DeadlineDao deadlineDao;
	@Autowired TranService tranService;
	@Autowired BankTranService bankTranService;

	public <T> List<T> deadlinePage(HMap hmap) {
		return deadlineDao.deadlinePage(hmap.getMap());
	}

	public boolean prevIsClosed(HMap hmap) {
		int bsns_sess_start_month = hmap.getInt(Define.BSNS_SESS_START_MONTH);
		int year = hmap.getInt(Define.YEAR);
		int month = hmap.getInt(Define.MONTH);

		// 회기시작월은 전월 마감여부 체크 안함
		if (bsns_sess_start_month == month) return true;

		// 전월 년도/월 계산
		year = month == 1 ? year - 1 : year;
		month = month == 1 ? 12 : month - 1;

		HMap param = new HMap();
		param.put(Define.COMP_CODE, hmap.getString(Define.COMP_CODE));
		param.put(Define.BSNS_CODE, hmap.getString(Define.BSNS_CODE));
		param.put(Define.YEAR, year);
		param.put(Define.MONTH, month);
		return isClosed(param);
	}

	public boolean nextIsClosed(HMap hmap) {
		int bsns_sess_start_month = hmap.getInt(Define.BSNS_SESS_START_MONTH);
		int year = hmap.getInt(Define.YEAR);
		int month = hmap.getInt(Define.MONTH);

		// 다음월 년도/월 계산
		int next_year = month + 1 == 13 ? year + 1 : year;
		int next_month = month + 1 == 13 ? 1 : month + 1;

		// 다음달이 회기시작월이면 다음월 마감여부 체크 안함
		if (bsns_sess_start_month == next_month) return true;

		HMap param = new HMap();
		param.put(Define.COMP_CODE, hmap.getString(Define.COMP_CODE));
		param.put(Define.BSNS_CODE, hmap.getString(Define.BSNS_CODE));
		param.put(Define.YEAR, next_year);
		param.put(Define.MONTH, next_month);
		return isClosed(param);
	}

	public boolean isClosed(HMap hmap) {
		List<Map<String, Object>> list = deadlineDao.deadlineList(hmap.getMap());
		if (list.size() == 1) return true;

		return false;
	}

	// 전월이월금 조회
	public BigInteger deadlinePrevBalance(HMap hmap) {
		int bsns_sess_start_month = hmap.getInt(Define.BSNS_SESS_START_MONTH);
		int year = hmap.getInt(Define.YEAR);
		int month = hmap.getInt(Define.MONTH);

		if (bsns_sess_start_month == month) return new BigInteger("0");

		// 전월 년도/월 계산
		year = month == 1 ? year-1 : year;
		month = month == 1 ? 12 : month-1;

		HMap param = new HMap();
		param.put(Define.COMP_CODE, hmap.getString(Define.COMP_CODE));
		param.put(Define.BSNS_CODE, hmap.getString(Define.BSNS_CODE));
		param.put(Define.YEAR, year);
		param.put(Define.MONTH, month);

		BigInteger deadlineBalance = deadlineDao.deadlineBalance(param.getMap());
		return deadlineBalance != null ? deadlineBalance : new BigInteger("0");
	}

	public int deadlineRegist(HMap hmap) {
		BigInteger prev_balance;
		int bsns_sess_start_month = hmap.getInt(Define.BSNS_SESS_START_MONTH);
		int dead_month = hmap.getInt(Define.DEAD_MONTH);
		boolean isSessionStartMonth = bsns_sess_start_month == dead_month ? true : false;

		// 전월잔액 구하기
		if (isSessionStartMonth) {    // 회기시작월이면 전월잔액 0으로 고정
			prev_balance = new BigInteger("0");
		} else {    // 회기시작월이 아닐 경우 전월잔액 구함
			// 전월 년도/월 계산
			int year = dead_month == 1 ? hmap.getInt(Define.DEAD_YEAR)-1 : hmap.getInt(Define.DEAD_YEAR);
			int month = dead_month == 1 ? 12 : dead_month-1;

			HMap param = new HMap();
			param.put(Define.COMP_CODE, hmap.getString(Define.COMP_CODE));
			param.put(Define.BSNS_CODE, hmap.getString(Define.BSNS_CODE));
			param.put(Define.YEAR, year);
			param.put(Define.MONTH, month);
			prev_balance = deadlineDao.deadlineBalance(param.getMap());
		}

		// 당월 수입/지출 금액 구하기
		hmap.put(Define.YEAR, hmap.getString(Define.DEAD_YEAR));
		hmap.put(Define.MONTH, hmap.getString(Define.DEAD_MONTH));
		hmap.put(Define.IO_TYPE, TypeVal.INPUT_TYPE);
		BigInteger inputAmount = tranService.tranAmount(hmap);		// 수입금액
		hmap.put(Define.IO_TYPE, TypeVal.OUTPUT_TYPE);
		BigInteger outputAmount = tranService.tranAmount(hmap);	// 지출금액

		BigInteger bankTranCount = bankTranService.bankTranCount(hmap); // 은행거래내역 개수
		if (bankTranCount.compareTo(new BigInteger("0")) == 0) {
			throw new AlertException("은행거래없음");
		}

		// 은행잔액(은행거래내역 잔액) 구하기
		BigInteger bankBalance = bankTranService.bankTranBalance(hmap);	// 사업 전체계좌의 잔액합
		BigInteger calcBalance = prev_balance.add(inputAmount).subtract(outputAmount);	// 계산잔액
		// 잔액일치여부 체크
		if (calcBalance.compareTo(bankBalance) != 0) {
			throw new AlertException("계좌잔액과 거래내역잔액이 일치하지 않습니다.");
		}

		hmap.put(Define.DEAD_BALANCE, calcBalance);
		return deadlineDao.deadlineRegist(hmap.getMap());
	}
	public int deadlineRegistByTranBalance(HMap hmap) {
		BigInteger prev_balance;
		int bsns_sess_start_month = hmap.getInt(Define.BSNS_SESS_START_MONTH);
		int dead_month = hmap.getInt(Define.DEAD_MONTH);
		boolean isSessionStartMonth = bsns_sess_start_month == dead_month ? true : false;

		// 전월잔액 구하기
		if (isSessionStartMonth) {    // 회기시작월이면 전월잔액 0으로 고정
			prev_balance = new BigInteger("0");
		} else {    // 회기시작월이 아닐 경우 전월잔액 구함
			// 전월 년도/월 계산
			int year = dead_month == 1 ? hmap.getInt(Define.DEAD_YEAR)-1 : hmap.getInt(Define.DEAD_YEAR);
			int month = dead_month == 1 ? 12 : dead_month-1;

			HMap param = new HMap();
			param.put(Define.COMP_CODE, hmap.getString(Define.COMP_CODE));
			param.put(Define.BSNS_CODE, hmap.getString(Define.BSNS_CODE));
			param.put(Define.YEAR, year);
			param.put(Define.MONTH, month);
			prev_balance = deadlineDao.deadlineBalance(param.getMap());
		}

		// 당월 수입/지출 금액 구하기
		hmap.put(Define.YEAR, hmap.getString(Define.DEAD_YEAR));
		hmap.put(Define.MONTH, hmap.getString(Define.DEAD_MONTH));
		hmap.put(Define.IO_TYPE, TypeVal.INPUT_TYPE);
		BigInteger inputAmount = tranService.tranAmount(hmap);		// 수입금액
		hmap.put(Define.IO_TYPE, TypeVal.OUTPUT_TYPE);
		BigInteger outputAmount = tranService.tranAmount(hmap);	// 지출금액

		BigInteger calcBalance = prev_balance.add(inputAmount).subtract(outputAmount);	// 계산잔액
		hmap.put(Define.DEAD_BALANCE, calcBalance);
		return deadlineDao.deadlineRegist(hmap.getMap());
	}

	public int deadlineDelete(HMap hmap) {
		Map<String, Object> deadline = deadlineDao.deadlineItem(hmap.getMap());
		int year = Integer.parseInt((String) deadline.get(Define.DEAD_YEAR));
		int month = Integer.parseInt((String) deadline.get(Define.DEAD_MONTH));

		HMap param = new HMap();
		param.put(Define.COMP_CODE, hmap.getString(Define.COMP_CODE));
		param.put(Define.BSNS_CODE, hmap.getString(Define.BSNS_CODE));
		param.put(Define.BSNS_SESS_START_MONTH, hmap.getString(Define.BSNS_SESS_START_MONTH));
		param.put(Define.YEAR, year);
		param.put(Define.MONTH, month);
		if (nextIsClosed(param)) throw new AlertException("익월 마감처리되어 마감취소가 불가합니다.");

		// 익월 거래내역 등록여부 체크
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.set(year, month, 1);
		hmap.put(Define.START_DATE, df.format(cal.getTime()));
		cal.add(Calendar.MONTH, 1);
		cal.add(Calendar.DATE, -1);
		hmap.put(Define.END_DATE, df.format(cal.getTime()));

		List<Map<String, Object>> list = tranService.tranList(hmap);
		if (list.size() > 0) {
			throw new AlertException("익월 거래내역이 등록되어 마감취소가 불가합니다.");
		}

		return deadlineDao.deadlineDelete(hmap.getMap());
	}

	public <T> T deadlineItem(HMap hmap) {
		return deadlineDao.deadlineItem(hmap.getMap());
	}

}
