<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-12">

			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<div class="card">
					<div class="card-header">
						<span class="text-bold mr-2">기간별 출력 </span>
						<select class="select2 form-control-sm" id="start_year" data-minimum-results-for-search="Infinity" style="width: 180px;">
							<c:set var="year"><fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy" /></c:set>
							<c:forEach var="y" begin="2000" end="${year + 1}">
								<option value="${y}" ${y eq year ? 'selected' : ''}>${y}년</option>
							</c:forEach>
						</select>
						<select class="select2 form-control-sm" id="start_month" data-minimum-results-for-search="Infinity" style="width: 180px;">
							<c:forEach var="m" begin="1" end="12">
								<option value="${m}" ${m eq businessVO.bsns_sess_start_month ? 'selected' : ''}>${m}월</option>
							</c:forEach>
						</select>
						<span class="m-1">~</span>
						<select class="select2 form-control-sm" id="end_year" data-minimum-results-for-search="Infinity" style="width: 180px;"></select>
						<select class="select2 form-control-sm" id="end_month" data-minimum-results-for-search="Infinity" style="width: 180px;"></select>
					</div>
					<div class="card-body">
						<button class="btn btn-default mb-2" onclick="windowOpen('/print/hwpctrl/settlement/revenue');">세입결산서</button>
						<button class="btn btn-default mb-2" onclick="windowOpen('/print/hwpctrl/settlement/expenditure');">세출결산서</button>
						<button class="btn btn-default mb-2" onclick="windowOpen('/print/hwpctrl/transaction');">현금출납장</button>
						<button class="btn btn-default mb-2" onclick="windowOpen('/print/hwpctrl/general_ledger');">총계정원장</button>
						<button class="btn btn-default mb-2" onclick="windowOpen('/print/hwpctrl/voucher/revenue');">수입결의서</button>
						<button class="btn btn-default mb-2" onclick="windowOpen('/print/hwpctrl/voucher/expenditure');">지출결의서</button>
						<button class="btn btn-default mb-2" onclick="windowOpen('/print/hwpctrl/return/voucher/revenue');">수입반납결의서</button>
						<button class="btn btn-default mb-2" onclick="windowOpen('/print/hwpctrl/return/voucher/expenditure');">지출반납결의서</button>
						<button class="btn btn-default mb-2" onclick="windowOpen('/print/hwpctrl/trial_balance');">합계잔액시산표</button>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<div class="card">
					<div class="card-header">
						<span class="text-bold mr-2">연도별 출력 </span>
						<select class="select2 form-control-sm" id="year" data-minimum-results-for-search="Infinity" style="width: 180px;">
							<c:set var="year"><fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy" /></c:set>
							<c:forEach var="y" begin="2000" end="${year + 1}">
								<option value="${y}" ${y eq year ? 'selected' : ''}>${y}년</option>
							</c:forEach>
						</select>
					</div>
					<div class="card-body">
						<button class="btn btn-default mb-2" onclick="windowOpen2('/print/hwpctrl/annual_settlement_report');">결산보고서</button>
						<button class="btn btn-default mb-2" onclick="windowOpen2('/print/hwpctrl/annual_settlement_revenue');">세입결산서</button>
						<button class="btn btn-default mb-2" onclick="windowOpen2('/print/hwpctrl/annual_settlement_expenditure');">세출결산서</button>
						<button class="btn btn-default mb-2" onclick="windowOpen2('/print/hwpctrl/annual_trial_balance');">월별시산표</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	$(function () {
		$("#start_year").trigger("change");
		$("#io_type").trigger("change");
	});

	$("#start_year, #start_month").on("change", function () {
		var bsns_sess_start_month = ${businessVO.bsns_sess_start_month};
		var year = parseInt($("#start_year").val());

		$("#end_year").empty();
		var optionHTML = '';
		if (bsns_sess_start_month <= $("#start_month").val()) {
			optionHTML += "<option value='" + year + "'>" + year + "년</option>";
			optionHTML += "<option value='" + (year+1) + "'>" + (year+1) + "년</option>";
		} else {
			optionHTML += "<option value='" + year + "'>" + year + "년</option>";
		}
		$("#end_year").append(optionHTML).trigger("change");
	});

	$("#end_year").on("change", function () {
		var start_year = $("#start_year").val();
		var start_month = $("#start_month").val();
		var end_year = $("#end_year").val();

		$("#end_month").empty();
		var optionHTML = '';
		var first_month;
		var last_month;
		var bsns_sess_start_month = ${businessVO.bsns_sess_start_month};
		if (start_year == end_year) {
			if (bsns_sess_start_month <= start_month) {
				first_month = start_month;
				last_month = 12;
			} else {
				first_month = start_month;
				last_month = bsns_sess_start_month - 1;
			}
		} else {
			first_month = 1;
			last_month = bsns_sess_start_month - 1;
		}

		for (var i = first_month; i <= last_month; i++) {
			optionHTML += "<option value='" + i + "'>" + i + "월</option>";
		}

		$("#end_month").append(optionHTML);
	});

	function windowOpen(url) {
		window.open("about:blank").location.href = url + "?start_year=" + $("#start_year").val() + "&start_month=" + $("#start_month").val() + "&end_year=" + $("#end_year").val() + "&end_month=" + $("#end_month").val()
	}

	function windowOpen2(url) {
		window.open("about:blank").location.href = url + "?year=" + $("#year").val()
	}

</script>
