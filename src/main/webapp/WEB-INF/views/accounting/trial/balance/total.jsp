<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-12">
				<div class="form-group">
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
										<th>수입누계</th>
										<th>수입금액</th>
										<th>계정명</th>
										<th>지출금액</th>
										<th>지출누계</th>
									</tr>
									</thead>
									<tbody></tbody>
									<tfoot>
									<tr>
										<th class="text-right"><span id="span_input_tran_balance"></span></th>
										<th class="text-right"><span id="span_input_tran_total_balance"></span></th>
										<th>합 계</th>
										<th class="text-right"><span id="span_output_tran_total_balance"></span></th>
										<th class="text-right"><span id="span_output_tran_balance"></span></th>
									</tr>
									<tr>
										<th class="text-right"><span id="span_tran_balance"></span></th>
										<th class="text-right"><span id="span_tran_total_balance"></span></th>
										<th></th>
										<th></th>
										<th></th>
									</tr>
									</tfoot>
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
			, paging: false
			, ordering: false
		}
		setDatatables("listTable", args);

		$("#start_year").trigger("change");

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
			, url: "/accounting/trial/balance/total"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				start_year: $("#start_year").val()
				, start_month: $("#start_month").val()
				, end_year: $("#end_year").val()
				, end_month: $("#end_month").val()
			})
			, success: function (data) {
				if($.fn.DataTable.isDataTable("#listTable")) {
					$("#listTable").DataTable().clear();
				}

				var input_tran_balance = 0;
				var input_tran_total_balance = 0;
				var output_tran_total_balance = 0;
				var output_tran_balance = 0;

				$.each(data, function(index, item) {
					input_tran_balance += Number(item.input_tran_total);
					input_tran_total_balance += Number(item.input_tran_amount);
					output_tran_total_balance += Number(item.output_tran_amount);
					output_tran_balance += Number(item.output_tran_total);

					var html = [];
					html.push("<div class='text-right'>" + item.input_tran_total.comma() + "</div>");
					html.push("<div class='text-right'>" + item.input_tran_amount.comma() + "</div>");
					html.push("<div class='text-left'>" + item.ghm_name + "</div>");
					html.push("<div class='text-right'>" + item.output_tran_amount.comma() + "</div>");
					html.push("<div class='text-right'>" + item.output_tran_total.comma() + "</div>");

					$("#listTable").DataTable().row.add(html).node();
				});

				$("#listTable").DataTable().draw(false);
				$("#listTable").DataTable().columns.adjust().draw();	// 테이블 컬럼 사이즈 조절

				$("#span_input_tran_balance").html(input_tran_balance.comma());
				$("#span_input_tran_total_balance").html(input_tran_total_balance.comma());
				$("#span_output_tran_total_balance").html(output_tran_total_balance.comma());
				$("#span_output_tran_balance").html(output_tran_balance.comma());

				$("#span_tran_balance").html((input_tran_balance - output_tran_balance).comma());
				$("#span_tran_total_balance").html((input_tran_total_balance - output_tran_total_balance).comma());

				$(".overlay").hide();
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

</script>