package com.erowm.webapp.accounting.print.dto;

import com.erowm.common.domain.BusinessVO;
import lombok.Builder;
import lombok.Getter;
import lombok.NonNull;
import org.springframework.util.Assert;

import java.text.SimpleDateFormat;
import java.util.Calendar;

@Getter
public class GeneralLedgerSearchCondition {
	private String comp_code;
	private String bsns_code;
	private int session_start_month;
	private int session_year;
	private int start_year;
	private int start_month;
	private int end_year;
	private int end_month;

	private String session_start_date;
	private String start_date;
	private String end_date;

	@Builder(builderMethodName = "ByYearBuilder", builderClassName = "ByYearBuilder")
	public GeneralLedgerSearchCondition(@NonNull BusinessVO business, int session_year) {
		Assert.isTrue(session_year >= 1900, "년도는 1900년도 이후부터 가능합니다.");

		this.comp_code = business.getComp_code();
		this.bsns_code = business.getBsns_code();
		this.session_start_month = Integer.parseInt(business.getBsns_sess_start_month());
		this.session_year = session_year;

		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.set(this.session_year, this.session_start_month - 1, 1);
		this.session_start_date = dateFormat.format(cal.getTime());

		this.start_date = dateFormat.format(cal.getTime());

		cal.set(this.session_year + 1, this.session_start_month - 1, 1);
		cal.add(Calendar.MONTH, -1);
		this.end_date = dateFormat.format(cal.getTime());
	}

	@Builder(builderMethodName = "ByYearMonthBuilder", builderClassName = "ByYearMonthBuilder")
	public GeneralLedgerSearchCondition(@NonNull BusinessVO business, int year, int month) {
		Assert.isTrue(year >= 1900, "년도는 1900년도 이후부터 가능합니다.");
		Assert.isTrue(month >= 1 && month <= 12, "월은 1에서 12 사이 값을 입력해주세요.");

		this.comp_code = business.getComp_code();
		this.bsns_code = business.getBsns_code();
		this.session_start_month = Integer.parseInt(business.getBsns_sess_start_month());
		this.session_year = this.session_start_month <= month ? year : year - 1;
		this.start_year = year;
		this.start_month = month;

		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.set(this.session_year, this.session_start_month - 1, 1);
		this.session_start_date = dateFormat.format(cal.getTime());

		cal.set(this.start_year, this.start_month - 1, 1);
		this.start_date = dateFormat.format(cal.getTime());

		cal.add(Calendar.MONTH, 1);
		this.end_date = dateFormat.format(cal.getTime());
	}

	@Builder(builderMethodName = "ByPeriodBuilder", builderClassName = "ByPeriodBuilder")
	public GeneralLedgerSearchCondition(@NonNull BusinessVO business, int start_year, int start_month, int end_year, int end_month) {
		Assert.isTrue(start_year >= 1900, "년도는 1900년도 이후부터 가능합니다.");
		Assert.isTrue(start_month >= 1 && start_month <= 12, "월은 1에서 12 사이 값을 입력해주세요.");

		this.comp_code = business.getComp_code();
		this.bsns_code = business.getBsns_code();
		this.session_start_month = Integer.parseInt(business.getBsns_sess_start_month());
		this.session_year = this.session_start_month <= start_month ? start_year : start_year - 1;
		this.start_year = start_year;
		this.start_month = start_month;
		this.end_year = end_year;
		this.end_month = end_month;

		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.set(this.session_year, this.session_start_month - 1, 1);
		this.session_start_date = dateFormat.format(cal.getTime());

		cal.set(this.start_year, this.start_month - 1, 1);
		this.start_date = dateFormat.format(cal.getTime());

		cal.set(this.end_year, this.end_month - 1, 1);
		cal.add(Calendar.MONTH, 1);
		this.end_date = dateFormat.format(cal.getTime());
	}
}
