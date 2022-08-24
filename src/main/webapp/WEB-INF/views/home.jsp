<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
	.table {
		font-size: 10pt;
	}
    .table td {
        text-align: center;
    }
	#inout-tab .nav-link {
		width: 150px;
		text-align: center;
	}
</style>

<div class="content">
	<div class="container-fluid">
		<div class="row mb-2">
			<div class="col-12">
				<select class="select2 form-control-sm" id="year" data-minimum-results-for-search="Infinity" style="width: 180px;">
					<c:set var="year"><fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy" /></c:set>
					<c:forEach var="y" begin="2000" end="${year + 1}">
						<option value="${y}" ${y eq year ? 'selected' : ''}>${y}년</option>
					</c:forEach>
				</select>
				<select class="select2 form-control-sm" id="month" data-minimum-results-for-search="Infinity" style="width: 180px;">
					<c:set var="month"><fmt:formatDate value="<%=new java.util.Date()%>" pattern="MM" /></c:set>
					<c:forEach var="m" begin="1" end="12">
						<option value="${m}" ${m eq month ? 'selected' : ''}>${m}월</option>
					</c:forEach>
				</select>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<div class="card">
					<div class="card-header">
						<h3 class="card-title">마감정보</h3>
						<div class="card-tools">
							<button type="button" class="btn btn-tool" data-card-widget="collapse">
								<i class="fas fa-minus"></i>
							</button>
						</div>
					</div>
					<div class="card-body">
						<table id="deadlineTable" class="table-form table table-sm table-bordered">
							<colgroup>
								<col width="40%">
								<col width="60%">
							</colgroup>
							<tr>
								<th>마감여부</th>
								<td><span class="text-bold" id="deadline_yn"></span></td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div class="row" id="ghmReportRow">
		</div>
		<div class="row">
			<div class="col-12">
				<div class="card">
					<div class="card-header">
						<h3 class="card-title">중복데이터</h3>
						<div class="card-tools">
							<button type="button" class="btn btn-tool" data-card-widget="collapse">
								<i class="fas fa-minus"></i>
							</button>
						</div>
					</div>
					<div class="card-body" style="overflow: auto">
						<table id="duplicateDataTable" class="table-form table table-sm table-bordered">
							<colgroup>
								<col width="14%">
								<col width="8%">
								<col width="15%">
								<col width="15%">
								<col width="30%">
								<col width="10%">
								<col width="8%">
							</colgroup>
							<thead>
							<tr>
								<th>출납일</th>
								<th>구분</th>
								<th>계정</th>
								<th>세목</th>
								<th>적요</th>
								<th>거래금액</th>
								<th>중복건</th>
							</tr>
							</thead>
							<tbody></tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<div class="card card-tabs">
					<div class="card-header p-0 pt-1">
						<ul class="nav nav-tabs" id="inout-tab" role="tablist">
							<li class="pt-2 px-3"><h3 class="card-title">월 예/결산자료</h3></li>
							<li class="nav-item">
								<a class="nav-link active" id="inout-input-tab" data-toggle="pill" href="#inout-input" role="tab" aria-controls="inout-input" aria-selected="true">세입</a>
							</li>
							<li class="nav-item">
								<a class="nav-link" id="inout-output-tab" data-toggle="pill" href="#inout-output" role="tab" aria-controls="inout-output" aria-selected="false">세출</a>
							</li>
						</ul>
					</div>
					<div class="card-body" style="overflow: auto">
						<div class="tab-content" id="inout-tabContent">
							<div class="tab-pane fade show active" id="inout-input" role="tabpanel" aria-labelledby="inout-input-tab">
								<table id="inputTable" class="table-form table table-sm table-bordered">
									<colgroup>
										<col width="10%">
										<col width="20%">
										<col width="20%">
										<col width="20%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
									</colgroup>
									<thead>
									<tr>
										<th>목코드</th>
										<th>계정</th>
										<th>월예산액</th>
										<th>월결산액</th>
										<th>증감비교</th>
										<th>비율</th>
										<th>참고사항</th>
									</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
							<div class="tab-pane fade" id="inout-output" role="tabpanel" aria-labelledby="inout-output-tab">
								<table id="outputTable" class="table-form table table-sm table-bordered">
									<colgroup>
										<col width="10%">
										<col width="20%">
										<col width="20%">
										<col width="20%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
									</colgroup>
									<thead>
									<tr>
										<th>목코드</th>
										<th>계정</th>
										<th>월예산액</th>
										<th>월결산액</th>
										<th>증감비교</th>
										<th>비율</th>
										<th>참고사항</th>
									</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
<script id="ghmReportTemplate" type="text/x-handlebars-template">
	<div class="col-12">
		<div class="card">
			<div class="card-header">
				<h3 class="card-title">{{ghmr_name}}</h3>
				<div class="card-tools">
					<button type="button" class="btn btn-tool" data-card-widget="collapse">
						<i class="fas fa-minus"></i>
					</button>
				</div>
			</div>
			<div class="card-body" style="overflow: auto">
				<table id="dataTable" class="table-form table table-sm table-bordered">
					<colgroup>
						<col width="15%">
						<col width="15%">
						<col width="15%">
						<col width="5%">
						<col width="15%">
						<col width="15%">
						<col width="15%">
						<col width="5%">
					</colgroup>
					<thead>
					<tr>
						<th>수입</th>
						<th>예산액</th>
						<th>수입금액</th>
						<th>적정여부</th>
						<th>지출</th>
						<th>예산액</th>
						<th>지출금액</th>
						<th>적정여부</th>
					</tr>
					</thead>
					<tr>
						<th>{{i_mock_name}}</th>
						<td class="text-right">{{i_month_budg_amount}}</td>
						<td class="text-right">{{i_tran_amount}}</td>
						<td class="{{i_bg_color}}">{{i_status}}</td>
						<th>{{o_mock_name}}</th>
						<td class="text-right">{{o_month_budg_amount}}</td>
						<td class="text-right">{{o_tran_amount}}</td>
						<td class="{{o_bg_color}}">{{o_status}}</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</script>

<script>
	$(function () {
		getPage();
	});

	$("#year, #month").on("change", function () {
		getPage();
	});

	function getPage() {
		$(".overlay").show();

		// 마감정보
		getDeadlineInfo();
		// 보고항목목록
		getGhmReportList();
		// 중복데이터
		getDuplicateTransactionInfo();
		// 월 예/결산자료
		getSettlementInfo("I", "inputTable");
		getSettlementInfo("O", "outputTable");

		setInterval(function () {
			$(".overlay").hide();
		}, 100);
	}

	function getDeadlineInfo() {
		$.ajax({
			type: "POST"
			, url: "/accounting/deadline/item"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, async: false
			, data: JSON.stringify({
				year: $("#year").val()
				, month: $("#month").val()
			})
			, success: function (data) {
				$("#deadline_yn").html("마감완료");
				$("#deadline_yn").removeClass("text-red");
				$("#deadline_yn").addClass("text-primary");
			}
			, error: function (request, status, error) {
				$("#deadline_yn").html("마감 미등록");
				$("#deadline_yn").removeClass("text-primary");
				$("#deadline_yn").addClass("text-red");
			}
		});
	}

	function getGhmReportList() {
		$.ajax({
			type: "POST"
			, url: "/accounting/tran/ghm/report/list"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, async: false
			, data: JSON.stringify({
				year: $("#year").val()
				, month: $("#month").val()
			})
			, success: function (data) {
				$("#ghmReportRow").empty();

				if (data.length > 0) {
					$.each(data, function (index, item) {
						addRow(item);
					});
				} else {
					addRow();
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	var p_row_numb = 0;
	function addRow(data) {
		var ghmReportTemplate = $("#ghmReportTemplate").html();
		var bindTemplate = Handlebars.compile(ghmReportTemplate);

		var html = "";
		if (isNotNull(data)) {
			var i_status = getStatus(data.i_month_budg_amount, data.i_tran_amount);
			var o_status = getStatus(data.o_month_budg_amount, data.o_tran_amount);

			var item = {
				numb: ++p_row_numb
				, ghmr_name: data.ghmr_name
				, i_mock_name: data.i_mock_name
				, i_month_budg_amount: data.i_month_budg_amount.comma()
				, i_tran_amount: data.i_tran_amount.comma()
				, o_mock_name: data.o_mock_name
				, o_month_budg_amount: data.o_month_budg_amount.comma()
				, o_tran_amount: data.o_tran_amount.comma()
				, i_bg_color : i_status['bg_color']
				, i_status : i_status['text']
				, o_bg_color : o_status['bg_color']
				, o_status : o_status['text']
			}
			html += bindTemplate(item);
		}
		$("#ghmReportRow").append(html);
	}

	function getDuplicateTransactionInfo() {
		$.ajax({
			type: "POST"
			, url: "/accounting/tran/duplicate/list"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, async: false
			, data: JSON.stringify({
				tran_year: $("#year").val()
				, tran_month: $("#month").val()
			})
			, success: function (data) {
				$("#duplicateDataTable tbody").empty();

				if (data.length > 0) {
					$.each(data, function (index, item) {
						var html = "<tr>";
						html += "<td>" + item.tran_date + "</td>";
						html += "<td>" + item.tran_io_type_name + "</td>";
						html += "<td>" + item.mock_name + "</td>";
						html += "<td>" + item.smok_name + "</td>";
						html += "<td>" + item.tran_jukyo + "</td>";
						html += "<td class='text-right'>" + item.tran_price.comma() + "</td>";
						html += "<td>" + item.tran_dup_count + "건</td>";
						html += "</tr>";
						$("#duplicateDataTable tbody").append(html);
					});
				} else {
					$("#duplicateDataTable tbody").append("<tr><td colspan='7'>조회된 데이터가 없습니다.</td></tr>");
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	function getSettlementInfo(io_type, tableID) {
		$.ajax({
			type: "POST"
			, url: "/accounting/settlement/page"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, async: false
			, data: JSON.stringify({
				start_year: $("#year").val()
				, start_month: $("#month").val()
				, end_year: $("#year").val()
				, end_month: $("#month").val()
				, io_type: io_type
			})
			, success: function (data) {
				$("#" + tableID + " tbody").empty();

				if (data.length > 0) {
					$.each(data, function (index, item) {
						var html = "<tr>";
						html += "<td>" + item.gwan_numb + item.hang_numb + item.mock_numb + "</td>";
						html += "<td>" + item.mock_name + "</td>";
						html += "<td class='text-right'>" + item.sub_budg_amount.comma() + "</td>";
						html += "<td class='text-right'>" + item.tran_amount.comma() + "</td>";
						if (item.sub_budg_amount < item.tran_amount) {
							html += "<td class='text-red'><i class='fas fa-caret-up'></i></td>";
						} else {
							html += "<td class='text-primary'><i class='fas fa-caret-down'></i></td>";
						}

						var status = getStatus(item.sub_budg_amount, item.tran_amount);
						html += "<td>" + status['rate'].comma(2) + "</td>";
						html += "<td class='" + status['bg_color'] + "'>" + status['text'] + "</td>";
						html += "</tr>";

						$("#" + tableID + " tbody").append(html);
					});
				} else {
					$("#" + tableID + " tbody").append("<tr><td colspan='7'>조회된 데이터가 없습니다.</td></tr>");
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	function getStatus(sub_budg_amount, tran_amount) {
		var rate = sub_budg_amount != 0 ? Math.round(tran_amount / sub_budg_amount * 100)/100 : "-";

		if (sub_budg_amount == 0) {
			if (tran_amount > 0) {
				return {rate: rate, bg_color: "bg-danger", text: "경고"};
			} else {
				return {rate: rate, bg_color: "", text: ""};
			}
		} else {
			if (0.95 <= rate && rate <= 1.05) {			// 0.05 범위내 적정
				return {rate: rate, bg_color: "bg-success", text: "적정"};
			} else if (0.9 <= rate && rate <= 1.1) {	// 0.1 범위내 주의
				return {rate: rate, bg_color: "bg-warning", text: "주의"};
			} else {									// 0.1 초과 경고
				return {rate: rate, bg_color: "bg-danger", text: "경고"};
			}
		}
	}

</script>