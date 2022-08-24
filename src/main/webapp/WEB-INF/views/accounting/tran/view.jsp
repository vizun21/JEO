<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-xl-3 col-md-6 col-sm-12">
				<div class="form-group">
					<div class="form-inline d-flex justify-content-between">
						<input type="hidden" id="sess_year">
						<input type="text" class="datepicker form-control" id="start_date" value="${start_date}" style="width: 47%;" readonly>
						<span class="m-1">~</span>
						<input type="text" class="datepicker form-control" id="end_date" value="${end_date}" style="width: 47%;" readonly>
					</div>
				</div>
			</div>
			<div class="col-xl-9 col-md-6 col-sm-12">
				<div class="form-group">
					<div class="input-group input-group-md">
						<select class="select2" id="keyword_column" data-minimum-results-for-search="Infinity" style="width: 180px;">
							<option value="mock_name">계정명</option>
							<option value="tran_jukyo">적요</option>
							<option value="tran_note">비고</option>
						</select>
						<input type="search" class="form-control" id="keyword" placeholder="검색어 입력">
						<div class="input-group-append">
							<button type="button" class="btn btn-md btn-default" id="btnSearch">
								<i class="fa fa-search"></i>
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<div class="form-group">
					<select class="select2" id="tran_io_type" data-minimum-results-for-search="Infinity" style="width: 200px;">
						<option value="">[구분선택]</option>
						<option value="I">수입</option>
						<option value="O">지출</option>
					</select>
					<select class="select2" style="width: 200px;" id="gwan_code">
						<option value="">[관선택]</option>
					</select>
					<select class="select2" style="width: 200px;" id="hang_code">
						<option value="">[항선택]</option>
					</select>
					<select class="select2" style="width: 200px;" id="mock_code">
						<option value="">[목선택]</option>
					</select>
					<select class="select2" style="width: 200px;" id="smok_code">
						<option value="">[세목선택]</option>
					</select>
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
							<div class="col-md-5">
								<div class="float-right">
									<button type="button" class="btn btn-sm btn-info" id="btnPrintVoucher"><i class="fas fa-print"></i> 결의서출력</button>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-12">
								<table id="listTable" class="table-list table table-sm table-bordered table-hover" style="display: none;font-size: small">
									<thead>
									<tr>
										<th class="no_toggle"></th>	<%-- dtr-control 위치 --%>
										<th class="no_toggle"><input type="checkbox" name="tb_check_all"></th>
										<th>출납일</th>
										<th>구분</th>
										<th>계정번호</th>
										<th>계정</th>
										<th>세목</th>
										<th>적요</th>
										<th>입금</th>
										<th>출금</th>
										<th>비고</th>
									</tr>
									</thead>
									<tbody></tbody>
									<tfoot>
									<tr>
										<th></th>
										<th colspan="7">합 계</th>
										<th class="text-right"><span id="span_input_total"></span></th>
										<th class="text-right"><span id="span_output_total"></span></th>
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
		$("#start_date").trigger("change");

		var args = {
			useColvis: true
			, excludeOrderColumns: [1]
		}
		setDatatables("listTable", args);

		getPage();
	});

	$("#start_date").on("change", function () {
		var year = $(this).datepicker("getDate").getFullYear();
		var month = $(this).datepicker("getDate").getMonth()+1;
		var bsns_sess_start_month = ${businessVO.bsns_sess_start_month};

		var sess_year = bsns_sess_start_month <= month ? year : year-1;
		var max_end_date = new Date(sess_year+1, ${businessVO.bsns_sess_start_month}-1, 0);

		$("#end_date").datepicker("option", "minDate", $(this).val());
		$("#end_date").datepicker("option", "maxDate", max_end_date);

		// 관항목 불러오기
		if (sess_year != $("#sess_year").val()) {
			$("#sess_year").val(sess_year);
			initGhmList();
		}
		getPage();
	});

	$("#end_date, #tran_io_type, #gwan_code, #hang_code, #mock_code, #smok_code").on("change", function () {
		getPage();
	});

	$("#tran_io_type").on("change", function () {
		initGhmList();
	});

	$("#gwan_code").on("change", function () {
		getHangList();
	});

	$("#hang_code").on("change", function () {
		getMockList();
	});

	$("#mock_code").on("change", function () {
		getSmokList();
	});

	$("#btnPrintVoucher").on("click", function () {
		var checked_list = $("#listTable input:checkbox[name=tb_check_list]:checked");

		// 거래내역 선택체크
		if (checked_list.length == 0) {
			alert("선택된 거래내역이 없습니다.");
			return false;
		}

		var tran_code_list = []
		$.each(checked_list, function () {
			var tran_code = $(this).closest("tr").data("tran_code");
			console.log(tran_code);
			tran_code_list.push(tran_code);
		});
		console.log(tran_code_list);

		window.open("about:blank").location.href = "/print/hwpctrl/voucher" + "?tran_code_list=" + tran_code_list.join(",")
	});

	function initGhmList() {
		getGwanList();
		getHangList();
		getMockList();
		getSmokList();
	}

	function getGwanList() {
		$.ajax({
			type: "POST"
			, url: "/ghm/gwan/list"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				ghm_year: $("#sess_year").val()
				, gwan_io_type: $("#tran_io_type").val()
			})
			, success: function (data) {
				$("#gwan_code").find("option:not(:first)").remove();
				$.each(data, function(index, item) {
					var optionText = "[" + item.gwan_io_type_name + " " + item.gwan_numb + "] " + item.gwan_name;
					$("#gwan_code").append("<option value='" + item.gwan_code +"'>" + optionText + "</option>").trigger("change");
				});
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	function getHangList() {
		$("#hang_code").find("option:not(:first)").remove();

		if (!$("#gwan_code").val()) return false;

		$.ajax({
			type: "POST"
			, url: "/ghm/hang/list"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				gwan_code: $("#gwan_code").val()
			})
			, success: function (data) {
				$.each(data, function(index, item) {
					var optionText = "[" + item.gwan_io_type_name + " " + item.gwan_numb + item.hang_numb + "] " + item.hang_name;
					$("#hang_code").append("<option value='" + item.hang_code +"'>" + optionText + "</option>").trigger("change");
				});
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	function getMockList() {
		$("#mock_code").find("option:not(:first)").remove();

		if (!$("#hang_code").val()) return false;

		$.ajax({
			type: "POST"
			, url: "/ghm/mock/list"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				hang_code: $("#hang_code").val()
			})
			, async: false
			, success: function (data) {
				$.each(data, function(index, item) {
					var optionText = "[" + item.gwan_io_type_name + " " + item.gwan_numb + item.hang_numb + item.mock_numb + "] " + item.mock_name;
					$("#mock_code").append("<option value='" + item.mock_code +"'>" + optionText + "</option>").trigger("change");
				});
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	function getSmokList() {
		$("#smok_code").find("option:not(:first)").remove();

		if (!$("#mock_code").val()) return false;

		$.ajax({
			type: "POST"
			, url: "/accounting/smok/list"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				mock_code: $("#mock_code").val()
			})
			, async: false
			, success: function (data) {
				$.each(data, function(index, item) {
					var optionText = "[" + item.gwan_io_type_name + " " + item.gwan_numb + item.hang_numb + item.mock_numb + item.smok_numb + "] " + item.smok_name;
					$("#smok_code").append("<option value='" + item.smok_code +"'>" + optionText + "</option>").trigger("change");
				});
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	function getPage() {
		$(".overlay").show();

		$.ajax({
			type: "POST"
			, url: "/accounting/tran/list"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				start_date: $("#start_date").val()
				, end_date: $("#end_date").val()
				, tran_io_type: $("#tran_io_type").val()
				, gwan_code: $("#gwan_code").val()
				, hang_code: $("#hang_code").val()
				, mock_code: $("#mock_code").val()
				, smok_code: $("#smok_code").val()
				, keyword_column: $("#keyword_column").val()
				, keyword: $("#keyword").val()
			})
			, success: function (data) {
				if($.fn.DataTable.isDataTable("#listTable")) {
					$("#listTable").DataTable().clear();
				}

				var input_total = 0;
				var output_total = 0;
				$.each(data, function(index, item) {
					var html = [];
					html.push("");	// dtr-control 위치
					html.push("<input type='checkbox' name='tb_check_list'>");
					html.push(item.tran_date);
					html.push(item.tran_io_type_name);
					html.push(item.gwan_numb + item.hang_numb + item.mock_numb);
					html.push("<div class='text-left'>" + item.mock_name + "</div>");
					html.push("<div class='text-left'>" + item.smok_name + "</div>");
					html.push("<div class='text-left'>" + item.tran_jukyo + "</div>");
					input_total += item.tran_io_type == 'I' ? Number(item.tran_price) : 0;
					html.push("<div class='text-right'>" + (item.tran_io_type == 'I' ? item.tran_price.comma() : 0) + "</div>");
					output_total += item.tran_io_type == 'O' ? Number(item.tran_price) : 0;
					html.push("<div class='text-right'>" + (item.tran_io_type == 'O' ? item.tran_price.comma() : 0) + "</div>");
					html.push("<div class='text-left'>" + item.tran_note + "</div>");

					var rowNode = $("#listTable").DataTable().row.add(html).node();
					$(rowNode).attr("data-tran_code", item.tran_code);
				});

				$("#listTable").DataTable().draw(false);
				$("#listTable").DataTable().columns.adjust().draw();	// 테이블 컬럼 사이즈 조절

				$("#span_input_total").html(input_total.comma());
				$("#span_output_total").html(output_total.comma());

				$(".overlay").hide();
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

</script>