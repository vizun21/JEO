package com.erowm.webapp.accounting.print.dto;

import com.erowm.common.domain.BusinessVO;
import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import static org.junit.Assert.assertEquals;

public class GeneralLedgerSearchConditionTest {
	BusinessVO business;

	@Rule
	public ExpectedException exceptionRule = ExpectedException.none();

	@Before
	public void setUp() throws Exception {
		business = new BusinessVO();
		business.setComp_code("1111");
		business.setBsns_code("1111");
		business.setBsns_sess_start_month("3");
	}

	@Test
	public void test() {
		GeneralLedgerSearchCondition searchCondition = GeneralLedgerSearchCondition.ByYearBuilder()
				.business(business)
				.session_year(1900)
				.build();
		assertEquals(searchCondition.getSession_start_date(), "1900-03-01");
		assertEquals(searchCondition.getStart_date(), "1900-03-01");
		assertEquals(searchCondition.getEnd_date(), "1901-02-01");

		GeneralLedgerSearchCondition searchCondition2 = GeneralLedgerSearchCondition.ByYearMonthBuilder()
				.business(business)
				.year(2022)
				.month(3)
				.build();
		assertEquals(searchCondition2.getSession_start_date(), "2022-03-01");
		assertEquals(searchCondition2.getStart_date(), "2022-03-01");
		assertEquals(searchCondition2.getEnd_date(), "2022-03-01");
	}

	@Test
	public void ByYearBuilder_business_누락() {
		exceptionRule.expect(NullPointerException.class);
		GeneralLedgerSearchCondition searchCondition = GeneralLedgerSearchCondition.ByYearBuilder()
				.session_year(1899)
				.build();
	}

	@Test
	public void ByYearBuilder_session_year_값오류() {
		exceptionRule.expect(IllegalArgumentException.class);
		exceptionRule.expectMessage("년도는 1900년도 이후부터 가능합니다.");
		GeneralLedgerSearchCondition searchCondition = GeneralLedgerSearchCondition.ByYearBuilder()
				.business(business)
				.session_year(1899)
				.build();
	}


	@Test
	public void ByYearMonthBuilder_business_누락() {
		exceptionRule.expect(NullPointerException.class);
		GeneralLedgerSearchCondition searchCondition = GeneralLedgerSearchCondition.ByYearMonthBuilder()
				.year(2022)
				.month(3)
				.build();
	}

	@Test
	public void ByYearMonthBuilder_year_값오류() {
		exceptionRule.expect(IllegalArgumentException.class);
		exceptionRule.expectMessage("년도는 1900년도 이후부터 가능합니다.");
		GeneralLedgerSearchCondition searchCondition = GeneralLedgerSearchCondition.ByYearMonthBuilder()
				.business(business)
				.year(1899)
				.month(3)
				.build();
	}

	@Test
	public void ByYearMonthBuilder_month_값오류() {
		exceptionRule.expect(IllegalArgumentException.class);
		exceptionRule.expectMessage("월은 1에서 12 사이 값을 입력해주세요.");
		GeneralLedgerSearchCondition searchCondition = GeneralLedgerSearchCondition.ByYearMonthBuilder()
				.business(business)
				.year(2022)
				.month(0)
				.build();
	}
}
