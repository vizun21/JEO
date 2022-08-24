<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
	$(function () {
		var filePath = BasePath + "/resources/files/docs/annual_settlement_report.hwp";
		if (!pHwpCtrl.Open(filePath)) {
			alert("파일경로가 잘못 지정된 것 같습니다. 파일경로를 확인하여 주세요");
			window.close();
		}

		PutFieldText("[회계연도]", "${session_year}");
		PutFieldText("[사업명]", "${businessVO.bsns_name}");

		if (pHwpCtrl.MoveToField("stamp", true, true, true)) {
			var path = BasePath + "/preview?fileName=${businessVO.bsns_seal}";
			pHwpCtrl.InsertPicture(path);
		} else {
			if (_DEBUG) alert("필드(" + "stamp" + ")가 존재하지 않습니다.");
		}

		PutFieldText("[세입예산액]", "${revenueBudgetAmount}".comma());
		PutFieldText("[세출예산액]", "${expenditureBudgetAmount}".comma());

		PutFieldText("[세입총액]", "${revenueSettlementAmount}".comma());
		PutFieldText("[세출총액]", "${expenditureSettlementAmount}".comma());

		PutFieldText("[예산차액]", "${budgetDifference}".comma());
		PutFieldText("[결산차액]", "${settlementDifference}".comma());

		PutFieldText("[미납액]", "${revenueDifference}".comma());
		PutFieldText("[잔액]", "${expenditureDifference}".comma());


		/* 총괄표 */
		<c:set var="revenueBudgetSettlementSummarySize" value="${fn:length(revenueBudgetSettlementSummary)}" />
		<c:set var="expenditureBudgetSettlementSummarySize" value="${fn:length(expenditureBudgetSettlementSummary)}" />
		<c:set var="diff" value="${revenueBudgetSettlementSummarySize - expenditureBudgetSettlementSummarySize}" />

		var dataList = [];
		<c:forEach var="revenueSummaryItem" items="${revenueBudgetSettlementSummary}">
		dataList.push(new Array(
			"${revenueSummaryItem.gwan_name}"
			, "${revenueSummaryItem.budget_amount}".comma()
			, "${revenueSummaryItem.tran_amount}".comma()
			, "${revenueSummaryItem.difference}".comma()
		));
		</c:forEach>
		<c:if test="${diff < 0}">
		<c:forEach begin="1" end="${diff * -1}">
		dataList.push(new Array("", "", "", ""));
		</c:forEach>
		</c:if>
		InsertTableData("tbl_cell1", dataList);

		dataList = [];
		<c:forEach var="expenditureSummaryItem" items="${expenditureBudgetSettlementSummary}">
		dataList.push(new Array(
			"${expenditureSummaryItem.gwan_name}"
			, "${expenditureSummaryItem.budget_amount}".comma()
			, "${expenditureSummaryItem.tran_amount}".comma()
			, "${expenditureSummaryItem.difference}".comma()
		));
		</c:forEach>
		<c:if test="${diff > 0}">
		<c:forEach begin="1" end="${diff}">
		dataList.push(new Array("", "", "", ""));
		</c:forEach>
		</c:if>
		InsertTableData("tbl_cell2", dataList);


		/* 결산서 */
		dataList = [];
		<c:forEach var="revenueItem" items="${revenueBudgetSettlement}">
		dataList.push(new Array(
			"${revenueItem.gwan_numb}"
			, "${revenueItem.gwan_name}"
			, "${revenueItem.gwan_numb}${revenueItem.hang_numb}"
			, "${revenueItem.hang_name}"
			, "${revenueItem.gwan_numb}${revenueItem.hang_numb}${revenueItem.mock_numb}"
			, "${revenueItem.mock_name}"
			, "${revenueItem.budget_amount}".comma()
			, "${revenueItem.tran_amount}".comma()
			, "${revenueItem.difference}".comma()
		));
		</c:forEach>
		InsertTableData("tbl_cell3", dataList);

		dataList = [];
		<c:forEach var="expenditureItem" items="${expenditureBudgetSettlement}">
		dataList.push(new Array(
			"${expenditureItem.gwan_numb}"
			, "${expenditureItem.gwan_name}"
			, "${expenditureItem.gwan_numb}${expenditureItem.hang_numb}"
			, "${expenditureItem.hang_name}"
			, "${expenditureItem.gwan_numb}${expenditureItem.hang_numb}${expenditureItem.mock_numb}"
			, "${expenditureItem.mock_name}"
			, "${expenditureItem.budget_amount}".comma()
			, "${expenditureItem.tran_amount}".comma()
			, "${expenditureItem.difference}".comma()
		));
		</c:forEach>
		InsertTableData("tbl_cell4", dataList);


		/* 월별합계시산표 */
		// 타이틀 설정
		<c:set var="session_year" value="${session_year}" />
		<c:set var="session_start_month" value="${businessVO.bsns_sess_start_month}" />
		<%
		int sessionYear = (int) pageContext.getAttribute("session_year");
		int sessionStartMonth = Integer.parseInt((String) pageContext.getAttribute("session_start_month"));
		Calendar cal = Calendar.getInstance();
		cal.set(sessionYear, sessionStartMonth - 1, 1);
		cal.add(Calendar.MONTH, -1);
		DateFormat df = new SimpleDateFormat("yyyy년 M월");
		pageContext.setAttribute("df", df);
		%>
		<c:forEach var="index" begin="1" end="12">
		<%
		cal.add(Calendar.MONTH, 1);
		pageContext.setAttribute("cal", cal);
		%>
		<c:set var="title" value="${df.format(cal.getTime())}" />
		PutFieldText("[title" + ${index} +"]", "${title}");
		</c:forEach>
		// 타이틀 설정 끝

		// 데이터 삽입
		var input_tran_sub_amount = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
		var output_tran_sub_amount = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
		dataList = [];
		<c:forEach var="item" items="${trialBalance}" varStatus="status">
		var bgdt_amount = ${item.bgdt_amount};
		var tran_amount = ${item.tran_amount};
		var ratio = bgdt_amount != 0 && tran_amount != 0 ? tran_amount / bgdt_amount * 100 : 0;
		dataList.push(new Array(
			"${item.gwan_io_type_name}"
			, "${item.ghm_numb}"
			, "${item.mock_name}"
			, "${item.bgdt_amount}".comma()
			, "${item.tran_amount}".comma()
			, ratio.comma(1) + "%"
			, "${item.tran_sub_amount_1}".comma()
			, "${item.tran_sub_amount_2}".comma()
			, "${item.tran_sub_amount_3}".comma()
			, "${item.tran_sub_amount_4}".comma()
			, "${item.tran_sub_amount_5}".comma()
			, "${item.tran_sub_amount_6}".comma()
			, "${item.tran_sub_amount_7}".comma()
			, "${item.tran_sub_amount_8}".comma()
			, "${item.tran_sub_amount_9}".comma()
			, "${item.tran_sub_amount_10}".comma()
			, "${item.tran_sub_amount_11}".comma()
			, "${item.tran_sub_amount_12}".comma()
			, "${item.tran_amount}".comma()
		));
		<c:choose>
		<c:when test='${item.gwan_io_type.equals("I")}'>
		input_tran_sub_amount[0] += Number(${item.tran_sub_amount_1});
		input_tran_sub_amount[1] += Number(${item.tran_sub_amount_2});
		input_tran_sub_amount[2] += Number(${item.tran_sub_amount_3});
		input_tran_sub_amount[3] += Number(${item.tran_sub_amount_4});
		input_tran_sub_amount[4] += Number(${item.tran_sub_amount_5});
		input_tran_sub_amount[5] += Number(${item.tran_sub_amount_6});
		input_tran_sub_amount[6] += Number(${item.tran_sub_amount_7});
		input_tran_sub_amount[7] += Number(${item.tran_sub_amount_8});
		input_tran_sub_amount[8] += Number(${item.tran_sub_amount_9});
		input_tran_sub_amount[9] += Number(${item.tran_sub_amount_10});
		input_tran_sub_amount[10] += Number(${item.tran_sub_amount_11});
		input_tran_sub_amount[11] += Number(${item.tran_sub_amount_12});
		</c:when>
		<c:otherwise>
		output_tran_sub_amount[0] += Number(${item.tran_sub_amount_1});
		output_tran_sub_amount[1] += Number(${item.tran_sub_amount_2});
		output_tran_sub_amount[2] += Number(${item.tran_sub_amount_3});
		output_tran_sub_amount[3] += Number(${item.tran_sub_amount_4});
		output_tran_sub_amount[4] += Number(${item.tran_sub_amount_5});
		output_tran_sub_amount[5] += Number(${item.tran_sub_amount_6});
		output_tran_sub_amount[6] += Number(${item.tran_sub_amount_7});
		output_tran_sub_amount[7] += Number(${item.tran_sub_amount_8});
		output_tran_sub_amount[8] += Number(${item.tran_sub_amount_9});
		output_tran_sub_amount[9] += Number(${item.tran_sub_amount_10});
		output_tran_sub_amount[10] += Number(${item.tran_sub_amount_11});
		output_tran_sub_amount[11] += Number(${item.tran_sub_amount_12});
		</c:otherwise>
		</c:choose>
		</c:forEach>
		InsertTableData("tbl_cell5", dataList);

		for (var i = 0; i < 12; i++) {
			PutFieldText("[세입합계" + (i + 1) + "]", input_tran_sub_amount[i].comma());
			PutFieldText("[세출합계" + (i + 1) + "]", output_tran_sub_amount[i].comma());
			PutFieldText("[차액" + (i + 1) + "]", (input_tran_sub_amount[i] - output_tran_sub_amount[i]).comma());
		}


		/* 정부보조금명세서 */
		dataList = [];
		<c:forEach var="grantStatement" items="${grantStatement}">
		dataList.push(new Array(
			"${grantStatement.tran_date}"
			, "${grantStatement.mock_name}"
			, "${grantStatement.tran_price}".comma()
		));
		</c:forEach>
		InsertTableData("tbl_cell6", dataList);

		pHwpCtrl.MovePos(2);
		$("#HwpCtrl").show();
	});
</script>
