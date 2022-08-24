<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-12">
				<div class="form-group">
					<select class="select2" id="io_type" data-minimum-results-for-search="Infinity" style="width: 100px;">
						<option value="I">세입</option>
						<option value="O">세출</option>
					</select>
					<select class="select2" id="start_year" data-minimum-results-for-search="Infinity" style="width: 150px;">
						<c:set var="year"><fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy" /></c:set>
						<c:forEach var="y" begin="2000" end="${year + 1}">
							<option value="${y}" ${y eq year ? 'selected' : ''}>${y}년</option>
						</c:forEach>
					</select>
					<select class="select2" id="start_month" data-minimum-results-for-search="Infinity" style="width: 150px;">
						<c:forEach var="m" begin="1" end="12">
							<option value="${m}" ${m eq businessVO.bsns_sess_start_month ? 'selected' : ''}>${m}월</option>
						</c:forEach>
					</select>
					<span class="m-1">~</span>
					<select class="select2" id="end_year" data-minimum-results-for-search="Infinity" style="width: 150px;"></select>
					<select class="select2" id="end_month" data-minimum-results-for-search="Infinity" style="width: 150px;"></select>
					<button type="button" class="btn btn-md btn-default" id="btnSearch"><i class="fa fa-search"> 조회</i></button>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<div class="card">
					<div class="card-body">
						<h3 id="frm_title"></h3>
						<div class="row">
							<div class="col-md-5">
								<div class="float-left">
									<button type="button" class="btn btn-sm btn-default" onclick='datatablesButtonTrigger({tableID:"listTable", extend:"excel"});'><i class="far fa-file-excel"></i> 엑셀</button>
									<button type="button" class="btn btn-sm btn-default" onclick='datatablesButtonTrigger({tableID:"listTable", extend:"print"});'><i class="fas fa-print"></i> 인쇄</button>
								</div>
							</div>
							<div class="col-md-2" id="listTable_colvis"></div>
							<div class="col-md-5"></div>
						</div>
						<div class="row">
							<div class="col-12">
								<table id="listTable" class="table-list table table-sm table-bordered table-hover" style="display: none;font-size: small">
									<thead>
									<tr>
										<th colspan="2">관</th>
										<th colspan="2">항</th>
										<th colspan="2">목</th>
										<th rowspan="2">예산액</th>
										<th rowspan="2">예산현액</th>
										<th rowspan="2"><span id="title_tran_total"></span></th>
										<th rowspan="2"><span id="title_balance_total"></span></th>
									</tr>
									<tr>
										<th>번호</th>
										<th>명칭</th>
										<th>번호</th>
										<th>명칭</th>
										<th>번호</th>
										<th>명칭</th>
									</tr>
									<tr>
										<th colspan="6">총 계</th>
										<th class="text-right"><span id="span_budg_total"></span></th>
										<th class="text-right"><span id="span_current_budg_total"></span></th>
										<th class="text-right"><span id="span_tran_total"></span></th>
										<th class="text-right"><span id="span_balance_total"></span></th>
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

<script>
	$(function () {
		var args = {
			responsive: false
			, useColvis: false
			, excludeOrderColumns: [0,1,2,3,4,5,6,7,8,9]
			, rowspan: [0,1,2,3]
		}
		setDatatables("listTable", args);

		$("#start_year").trigger("change");
		$("#io_type").trigger("change");

		getPage();
	});

	$("#io_type").on("change", function () {
		if ($(this).val() == 'I') {
			$("#title_tran_total").html("수납액");
			$("#title_balance_total").html("미납액");
		} else if ($(this).val() == 'O') {
			$("#title_tran_total").html("지출액");
			$("#title_balance_total").html("잔액");
		}
		getPage();
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

	function getPage() {
		$(".overlay").show();

		$.ajax({
			type: "POST"
			, url: "/accounting/settlement/page"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				start_year: $("#start_year").val()
				, start_month: $("#start_month").val()
				, end_year: $("#end_year").val()
				, end_month: $("#end_month").val()
				, io_type: $("#io_type").val()
			})
			, success: function (data) {
				if($.fn.DataTable.isDataTable("#listTable")) {
					$("#listTable").DataTable().clear();
				}

				var budg_total = 0;
				var current_budg_total = 0;
				var tran_total = 0;
				var balance_total = 0;
				$.each(data, function(index, item) {
					var html = [];
					html.push(item.gwan_numb);
					html.push(item.gwan_name);
					html.push(item.gwan_numb + item.hang_numb);
					html.push(item.hang_name);
					html.push(item.gwan_numb + item.hang_numb + item.mock_numb);
					html.push(item.mock_name);
					html.push("<div class='text-right'>" + item.budg_amount.comma() + '</div>');
					var current_budg_amount = Number(item.budg_amount) - Number(item.prev_tran_amount);
					html.push("<div class='text-right'>" + current_budg_amount.comma() + '</div>');
					html.push("<div class='text-right'>" + item.tran_amount.comma() + '</div>');
					var balance = Number(current_budg_amount) - Number(item.tran_amount);
					html.push("<div class='text-right'>" + balance.comma() + '</div>');

					budg_total += Number(item.budg_amount);
					current_budg_total += current_budg_amount;
					tran_total += Number(item.tran_amount);
					balance_total += balance;

					$("#listTable").DataTable().row.add(html).node();
				});

				$("#listTable").DataTable().draw(false);
				$("#listTable").DataTable().columns.adjust().draw();	// 테이블 컬럼 사이즈 조절

				$("#span_budg_total").html(budg_total.comma());
				$("#span_current_budg_total").html(current_budg_total.comma());
				$("#span_tran_total").html(tran_total.comma());
				$("#span_balance_total").html(balance_total.comma());

				$(".overlay").hide();
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

</script>