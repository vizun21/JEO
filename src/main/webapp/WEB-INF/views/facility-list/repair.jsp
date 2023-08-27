<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="content">
	<div class="container-fluid">
		<form id="searchForm">
			<div class="row">
				<div class="col-2">
					<div class="form-group">
						<div class="input-group input-group-md">
							<input type="text" class="datepicker-removable form-control" name="repair_date"
								   id="repair_date" title="수리일자" placeholder="수리일자" readonly>
						</div>
					</div>
				</div>
				<div class="col-2">
					<input type="search" class="form-control" id="facility_tag_no" name="facility_tag_no"
						   data-parsley-required="true" placeholder="TAG NO." title="TAG NO.">
				</div>
				<div class="col-2">
					<input type="search" class="form-control" id="facility_name" name="facility_name"
						   placeholder="설비명">
				</div>
				<div class="col-2">
					<input type="search" class="form-control" id="repair_company" name="repair_company" placeholder="수리업체">
				</div>
				<div class="col-2">
					<input type="search" class="form-control" id="repair_manager" name="repair_manager" placeholder="담당자">
				</div>
				<div class="col-1">
					<button type="button" class="btn btn-md btn-primary btn-block" id="btnSearch">
						<i class="fa fa-hourglass-half"></i> 검색
					</button>
				</div>
				<div class="col-1">
					<button type="button" class="btn btn-md btn-primary btn-block" id="btnPrint">
						<i class="fas fa-print"></i> 인쇄
					</button>
				</div>
			</div>
		</form>
		<div class="row">
			<div class="col-12">
				<div class="card">
					<div class="card-body">
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
									<c:forEach var="result" items="${resultList}" varStatus="status">
										<tr>
											<td></td>
											<td>${status.count}</td>
											<td>${result.facility_name}</td>
											<td>${result.construction_code}</td>
											<td>${result.category_code}</td>
											<td>${result.facility_tag_no}</td>
											<td>${result.emplacement}</td>
											<td>${result.facility_quantity}</td>
										</tr>
									</c:forEach>
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

<script>
	$.each($("#facility_tag_no"), function () {
		initAutoComplete(this);
	});

	$.each($("#facility_name"), function () {
		initAutoComplete2(this);
	});

	$("#btnPrint").on("click", function () {
		if (!parsleyFormValidate("searchForm")) return false;

		var url = "<c:url value='/print/html/repair-list'/>"
			+ "?repair_date=" + $("#repair_date").val()
			+ "&facility_tag_no=" + $("#facility_tag_no").val()
			+ "&repair_company=" + $("#repair_company").val()
			+ "&repair_manager=" + $("#repair_manager").val();
		window.open(url, '_blank');
	});

	function getPage() {
		if (!parsleyFormValidate("searchForm")) return false;

		$(".overlay").show();

		console.log($("#searchForm").serialize());

		$.ajax({
			type: "POST"
			, url: "/facility-list/repair/page"
			, dataType: "json"
			, data: $("#searchForm").serialize()
			, success: function (data) {
				if($.fn.DataTable.isDataTable("#listTable")) {
					$("#listTable").DataTable().clear();
				}

				$.each(data, function(index, item) {
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

					$("#listTable").DataTable().row.add(html).node();
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
		}
		setDatatables("listTable", args);

		$("#listTable").DataTable().columns.adjust().draw();

		$("#listTable tbody").on("click", "tr", function () {
			let facility_tag_no = $(this).data("facility_tag_no");
			console.log(facility_tag_no);
			if (facility_tag_no !== undefined) {
				window.location.href = "<c:url value="/facility/equipment/modify"></c:url>?facility_tag_no=" + facility_tag_no;
			}
		});
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
									label: '[' + item.facility_tag_no + '] ' + item.facility_name
									, value: item.facility_tag_no
									, facility_name: item.facility_name
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
				$("#facility_name").val(ui.item.facility_name);
			}
		});
	}

	function initAutoComplete2(obj) {
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
									label: '[' + item.facility_tag_no + '] ' + item.facility_name
									, value: item.facility_name
									, facility_tag_no: item.facility_tag_no
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
				$("#facility_tag_no").val(ui.item.facility_tag_no);
			}
		});
	}
</script>
