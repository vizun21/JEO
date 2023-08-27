<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.jeo.common.config.TypeVal" %>

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
								<div class="col-2"></div>
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
								<tr>
									<th colspan="3">설비명</th>
									<th colspan="2">TAG NO.</th>
									<td colspan="2" rowspan="2">
										<button type="button" class="btn btn-sm btn-primary btn-block" style="height: 100%;" onclick="goFacilityInfo();">이전화면</button>
									</td>
									<td colspan="2" rowspan="2">
										<button type="submit" class="btn btn-sm btn-primary btn-block" style="height: 100%;">등록</button>
									</td>
								</tr>
								<tr>
									<td colspan="3">
										<input type="text" class="form-control form-control-sm" id="keyword2" name="facility_name" value="${facility.facility_name}">
									</td>
									<td colspan="2">
										<input type="hidden" name="facility_tag_no" data-parsley-required="true" title="TAG NO." value="${facility.facility_tag_no}">
										<input type="text" class="form-control form-control-sm" id="keyword"
											   maxlength="20" data-parsley-required="true" title="TAG NO." value="${facility.facility_tag_no}">
									</td>
								</tr>
								<tr>
									<th>수리일자</th>
									<th>수리구분</th>
									<th>수리내역</th>
									<th>고장원인</th>
									<th>수리업체</th>
									<th>수리업체TEL</th>
									<th>수리금액</th>
									<th>담당자</th>
									<th>비고</th>
								</tr>
								<tr>
									<td>
										<input type="text" class="datepicker form-control form-control-sm"
											   name="repair_date" data-parsley-required="true" title="수리일자" readonly>
									</td>
									<td>
										<input type="text" class="form-control form-control-sm" name="repair_type"
											   maxlength="5" title="수리구분">
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
											   maxlength="20" title="수리업체TEL">
									</td>
									<td>
										<input type="text" class="form-control form-control-sm" name="repair_price"
											   data-parsley-required="true" title="수리금액">
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
							<div class="col-md-5">
								<div class="float-left">
									<button type="button" class="btn btn-sm btn-default" onclick='datatablesButtonTrigger({tableID:"listTable", extend:"excel"});'><i class="far fa-file-excel"></i> 엑셀</button>
									<button type="button" class="btn btn-sm btn-default" onclick='datatablesButtonTrigger({tableID:"listTable", extend:"print"});'><i class="fas fa-print"></i> 인쇄</button>
								</div>
							</div>
							<div class="col-md-2" id="listTable_colvis"></div>
							<div class="col-md-5">
								<div class="float-right">
									<c:if test="${loginVO.user_level == TypeVal.LEVEL_COMP_ADMIN}">
										<button type="button" class="btn btn-sm btn-danger" id="btnDelete"><i class="fas fa-trash-alt"></i> 삭제</button>
									</c:if>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-12">
								<table id="listTable" class="table-list table table-sm table-bordered table-hover" style="display: none;">
									<thead>
									<tr>
										<th class="no_toggle"></th>	<%-- dtr-control 위치 --%>
										<th class="no_toggle"><input type="checkbox" name="tb_check_all"></th>
										<th>NO</th>
										<th>수리일자</th>
										<th>수리구분</th>
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

<!-- Modal -->
<div class="modal fade" id="formModal" role="dialog" aria-labelledby="formModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="formModalLabel">수리내역</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<i class="fas fa-times"></i>
				</button>
			</div>
			<form id="modifyForm" action="/facility/repair/modify" method="post">

				<div class="modal-body">
					<table class="table-form table table-sm table-bordered">
						<colgroup>
							<col width="20%">
							<col width="30%">
							<col width="20%">
							<col width="30%">
						</colgroup>
						<tr>
							<th>설비명</th>
							<td>
								<input type="hidden" name="repair_no">
								<input type="text" class="form-control form-control-sm" name="facility_name" readonly>
							</td>
							<th>TAG NO.<span class="required">*</span></th>
							<td>
								<input type="text" class="form-control form-control-sm" name="facility_tag_no" readonly>
							</td>
						</tr>
						<tr>
							<th>수리일자<span class="required">*</span></th>
							<td>
								<input type="text" class="datepicker form-control form-control-sm"
									   name="repair_date" data-parsley-required="true" title="수리일자" readonly>
							</td>
							<th>수리구분</th>
							<td>
								<input type="text" class="form-control form-control-sm" name="repair_type"
									   maxlength="5" title="수리구분">
							</td>
						</tr>
						<tr>
							<th>수리내역<span class="required">*</span></th>
							<td colspan="3">
								<input type="text" class="form-control form-control-sm" name="repair_content"
									   maxlength="50" data-parsley-required="true" title="수리내역">
							</td>
						</tr>
						<tr>
							<th>고장원인<span class="required">*</span></th>
							<td colspan="3">
								<input type="text" class="form-control form-control-sm" name="repair_cause"
									   maxlength="50" data-parsley-required="true" title="고장원인">
							</td>
						</tr>
						<tr>
							<th>수리업체</th>
							<td>
								<input type="text" class="form-control form-control-sm" name="repair_company"
									   maxlength="50" title="수리업체">
							</td>
							<th>수리업체TEL</th>
							<td>
								<input type="text" class="form-control form-control-sm" name="repair_company_tel"
									   maxlength="20" title="수리업체TEL">
							</td>
						</tr>
						<tr>
							<th>수리금액<span class="required">*</span></th>
							<td>
								<input type="text" class="form-control form-control-sm" name="repair_price"
									   data-parsley-required="true" title="수리금액">
							</td>
							<th>담당자</th>
							<td>
								<input type="text" class="form-control form-control-sm" name="repair_manager"
									   maxlength="50" title="담당자">
							</td>
						</tr>
						<tr>
							<th>비고</th>
							<td colspan="3">
								<input type="text" class="form-control form-control-sm" name="repair_note"
									   maxlength="50" title="비고">
							</td>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-info">수정</button>
				</div>
			</form>
		</div>
	</div>
</div>

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<script>
	$.each($("#keyword"), function () {
		initAutoComplete(this);
	});

	$.each($("#keyword2"), function () {
		initAutoComplete2(this);
	});

	$("input[name=repair_price]").on("keyup focusout", function () {
		$(this).val($(this).val().number());
	});

	$("#listTable tbody").on("click", "td:not(:nth-child(2))", function () {
		let repair_no = $(this).parent().data("repair_no");
		console.log(repair_no);
		getItem(repair_no);
	});

	$("#btnDelete").on("click", function () {
		var checked_list = $("#listTable input:checkbox[name=tb_check_list]:checked");
		// 수리내역 선택체크
		if (checked_list.length == 0) {
			alert("선택된 수리내역이 없습니다.");
			return false;
		}
		if (!confirm("삭제하시겠습니까?")) return false;

		var repair_list = [];
		$.each(checked_list, function () {
			var repair_no = $(this).closest("tr").data("repair_no");
			repair_list.push(repair_no);
		});

		$.ajax({
			type: "DELETE"
			, url: "/repairs"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				repair_list: repair_list
			})
			, success: function (data) {
				if (data == 'success') {
					getRepairList();
				} else {
					alert(data);
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	});

	function goFacilityInfo() {
		location.href = "<c:url value='/facility/equipment/modify'/>?facility_tag_no=" + $("[name=facility_tag_no]").val();
	}

	function getItem(repair_no) {
		initDataTable("modifyForm");
		$("#formModal").modal("show");

		$.ajax({
			type: "GET"
			, url: "/facility/repair/" + repair_no
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, success: function (data) {
				console.log(data);
				setFormValue("modifyForm", data);
				var repair_date = new Date(data.repair_date.year, data.repair_date.monthValue-1, data.repair_date.dayOfMonth + 1);
				$("#modifyForm input[name=repair_date]").val(repair_date.toISOString().split('T')[0]);
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

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
				$("[name=facility_tag_no]").val(ui.item.value);
				$("#keyword2").val(ui.item.facility_name);

				/* 수리내역목록 가져오기 */
				getRepairList();
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
				$("[name=facility_tag_no]").val(ui.item.facility_tag_no);
				$("#keyword").val(ui.item.facility_tag_no);

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
			, url: "/facility/repairList?facility_tag_no=" + $("[name=facility_tag_no]").val()
			, dataType: "json"
			, success: function (data) {
				if($.fn.DataTable.isDataTable("#listTable")) {
					$("#listTable").DataTable().clear();
				}

				$.each(data, function(index, item) {
					var html = [];
					html.push("");	// dtr-control 위치
					html.push("<input type='checkbox' name='tb_check_list'>");
					html.push(data.length - index);
					var repair_date = new Date(item.repair_date.year, item.repair_date.monthValue-1, item.repair_date.dayOfMonth + 1);
					html.push(repair_date.toISOString().split('T')[0]);
					html.push(item.repair_type);
					html.push(item.repair_content);
					html.push(item.repair_cause);
					html.push(item.repair_company);
					html.push(item.repair_company_tel);
					html.push(item.repair_price);
					html.push(item.repair_manager);
					html.push(item.repair_note);

					var rowNode = $("#listTable").DataTable().row.add(html).node();
					$(rowNode).attr("data-repair_no", item.repair_no);
					$(rowNode).css("cursor", "pointer");
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

		/* 설비선택해서 수리내역화면으로 넘어온 경우 목록조회 */
		<c:if test="${not empty facility}">
		getRepairList();
		</c:if>
	});
</script>
