<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-12">
				<div class="card">
					<form id="repairForm" action="<c:url value="/facility/repair"/>" method="post" onsubmit="return validate();">
						<div class="card-header">
							<div class="row">
								<div class="col-6 align-self-center">
									<h5 class="mb-0">수리내역</h5>
								</div>
								<div class="offset-4"></div>
								<div class="col-2">
									<button type="submit" class="btn btn-sm btn-primary btn-block">등록</button>
								</div>
							</div>

						</div>
						<div class="card-body">
							<table class="table-list table table-sm table-bordered table-hover mb-0">
								<colgroup>
									<col style="width: 10%;">
									<col style="width: 10%;">
									<col style="width: 15%;">
									<col style="width: 15%;">
									<col style="width: 10%;">
									<col style="width: 10%;">
									<col style="width: 10%;">
									<col style="width: 10%;">
									<col style="width: 10%;">
								</colgroup>
								<thead>
								<tr>
									<th>수리일자</th>
									<th>TAG NO.</th>
									<th>수리내역</th>
									<th>고장원인</th>
									<th>수리업체</th>
									<th>수리업체TEL</th>
									<th>수리금액</th>
									<th>담당자</th>
									<th>비고</th>
								</tr>
								</thead>
								<tbody>
								<tr>
									<td>
										<input type="text" class="datepicker form-control form-control-sm"
											   name="repair_date" data-parsley-required="true" title="수리일자" readonly>
									</td>
									<td>
										<input type="hidden" name="facility_tag_no" data-parsley-required="true" title="TAG NO.">
										<input type="text" class="form-control form-control-sm" id="facility_tag_no_keyword"
											   maxlength="20" data-parsley-required="true" title="TAG NO.">
									</td>
									<td>
										<input type="text" class="form-control form-control-sm" name="repair_content"
											   maxlength="50" data-parsley-required="true" title="수리내역">
									</td>
									<td>
										<input type="text" class="form-control form-control-sm" name="repair_cause"
											   maxlength="50" data-parsley-required="true" title="고장원인">
									</td>
									<td>
										<input type="text" class="form-control form-control-sm" name="repair_company"
											   maxlength="50" title="수리업체">
									</td>
									<td>
										<input type="text" class="form-control form-control-sm" name="repair_company_tel"
											   maxlength="50" title="수리업체TEL">
									</td>
									<td>
										<input type="text" class="form-control form-control-sm" name="repair_price"
											   maxlength="50" data-parsley-required="true" title="수리금액">
									</td>
									<td>
										<input type="text" class="form-control form-control-sm" name="repair_manager"
											   maxlength="50" title="담당자">
									</td>
									<td>
										<input type="text" class="form-control form-control-sm" name="repair_note"
											   maxlength="50" title="비고">
									</td>
								</tr>
								</tbody>
							</table>
						</div>
					</form>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<div class="card">
					<div class="card-header"><h5 class="mb-0">수리내역목록</h5></div>
					<div class="card-body">
						<div class="row">
							<div class="offset-5"></div>
							<div class="col-md-2" id="listTable_colvis"></div>
							<div class="col-md-5"></div>
						</div>
						<div class="row">
							<div class="col-12">
								<table id="listTable" class="table-list table table-sm table-bordered table-hover" style="display: none;">
									<thead>
									<tr>
										<th class="no_toggle"></th>	<%-- dtr-control 위치 --%>
										<th>NO</th>
										<th>수리일자</th>
										<th>수리내역</th>
										<th>고장원인</th>
										<th>수리업체</th>
										<th>수리업체TEL</th>
										<th>수리금액</th>
										<th>담당자</th>
										<th>비고</th>
									</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<script>
	$.each($("#facility_tag_no_keyword"), function () {
		initAutoComplete(this);
	});

	$("input[name=repair_price]").on("keyup focusout", function () {
		$(this).val($(this).val().number());
	});

	function initAutoComplete(obj) {
		$(obj).autocomplete({
			minLength: ($(obj).data("parsley-length") ? $(obj).data("parsley-length")[0] : 1)	// bootstrap-select 적용 후 수정
			, delay: 300
			, search: function (event) {
				if (event.keyCode == 37 || event.keyCode == 38 || event.keyCode == 39 || event.keyCode == 40) {
					event.preventDefault();
				}
			}
			, source: function (request, response) {
				$.ajax({
					type: "POST",
					url: "/facility/equipment/" + encodeURIComponent($.trim(request.term).replace(/\./g, "%2E").replace(/\//g, "%2F")),
					cache: false,
					dataType: "json",
					success: function (data) {
						// loading 종료 신호보내기 위해..
						setTimeout(function () {
							response($.map(data, function (item) {
								return {
									label: item.facility_tag_no
									, value: item.facility_tag_no
								}
							}));
						}, 100);
					},
					error: function (xhr, status, message) {
						alertAjaxError(xhr, status, message);
						response();
					}
				});
			}
			, select: function (event, ui) {
				$("[name=facility_tag_no]").val(ui.item.value);

				/* 수리내역목록 가져오기 */
				getRepairList();
			}
		});
	}

	function validate() {
		if (!parsleyFormValidate("repairForm")) return false;
	}

	function getRepairList() {
		$(".overlay").show();

		$.ajax({
			type: "GET"
			, url: "/facility/repairList/" + $("[name=facility_tag_no]").val()
			, dataType: "json"
			, success: function (data) {
				if($.fn.DataTable.isDataTable("#listTable")) {
					$("#listTable").DataTable().clear();
				}

				$.each(data, function(index, item) {
					console.log(item);
					var html = [];
					html.push("");	// dtr-control 위치
					html.push(item.repair_no);
					var repair_date = new Date(item.repair_date.year, item.repair_date.monthValue-1, item.repair_date.dayOfMonth + 1);
					html.push(repair_date.toISOString().split('T')[0]);
					html.push(item.repair_content);
					html.push(item.repair_cause);
					html.push(item.repair_company);
					html.push(item.repair_company_tel);
					html.push(item.repair_price);
					html.push(item.repair_manager);
					html.push(item.repair_note);

					var rowNode = $("#listTable").DataTable().row.add(html).node();
					$(rowNode).attr("data-repair_no", item.repair_no);
				});

				$("#listTable").DataTable().draw(false);
				$("#listTable").DataTable().columns.adjust().draw();

				$(".overlay").hide();
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	$(function () {
		var args = {
			orderColumns: []
			, ordering: false
		}
		setDatatables("listTable", args);
		$("#listTable").DataTable().columns.adjust().draw();
	});
</script>
