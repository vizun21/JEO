<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-4 col-md-12">
				<div class="card">
					<div class="card-body">
						<div class="row">
							<div class="col-6">
								<div class="form-group">
									<select class="select2" id="bsns_cate" data-minimum-results-for-search="Infinity" style="width: 100%;">
										<option value="">[사업유형선택]</option>
										<c:forEach var="bsns_cate" items="${bsns_cate_list}" varStatus="status">
											<option value="${bsns_cate.cddt_val}">${bsns_cate.cddt_name}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="col-6">
								<div class="form-group">
									<select class="select2" id="ghm_year" data-minimum-results-for-search="Infinity" style="width: 100%;">
										<option value="">[년도선택]</option>
										<c:forEach var="year" items="${year_list}" varStatus="status">
											<option value="${year.ghm_year}">${year.ghm_year}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-6">
								<div class="float-left">
									<c:if test="${loginVO.user_level >= 8}">
										<button type="button" class="btn btn-sm btn-warning" id="btnActivate"><i class="fas fa-lock-open"></i> 활성화</button>
									</c:if>
								</div>
							</div>
							<div class="col-6">
								<div class="float-right">
								<c:if test="${loginVO.user_level >= 8}">
									<button type="button" class="btn btn-sm btn-info" id="btnAdd"><i class="fas fa-plus"></i> 추가</button>
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
									<c:if test="${loginVO.user_level >= 8}">
										<th class="no_toggle"><input type="checkbox" name="tb_check_all"></th>
									</c:if>
										<th>사업유형</th>
										<th>관항목년도</th>
									<c:if test="${loginVO.user_level >= 8}">
										<th>활성화여부</th>
									</c:if>
									</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-8 col-md-12">
				<div class="card">
					<div class="card-body">
						<div class="row mb-3">
							<div class="col-md-12">
								<input type="hidden" id="select_ghm_code">
								<input type="hidden" id="select_bsns_cate">
								<table id="dataTable3" class="table-form table table-sm table-bordered">
									<colgroup>
										<col width="20%">
										<col width="30%">
										<col width="20%">
										<col width="30%">
									</colgroup>
									<tr>
										<th>사업유형</th>
										<td><span id="select_bsns_cate_name"></span></td>
										<th>년도</th>
										<td><span id="select_ghm_year"></span></td>
									</tr>
								</table>
							</div>
						</div>
						<div class="row">
							<div class="col-md-5">
								<div class="float-left">
									<button type="button" class="btn btn-sm btn-default" onclick='datatablesButtonTrigger({tableID:"listTable2", extend:"excel"});'><i class="far fa-file-excel"></i> 엑셀</button>
									<button type="button" class="btn btn-sm btn-default" onclick='datatablesButtonTrigger({tableID:"listTable2", extend:"print"});'><i class="fas fa-print"></i> 인쇄</button>
								</div>
							</div>
							<div class="col-md-7">
								<div class="float-right">
								<c:if test="${loginVO.user_level >= 8}">
									<button type="button" class="btn btn-sm btn-warning btn-hide" id="btnAddReportList"><i class="fas fa-list"></i> 보고서항목관리</button>
									<button type="button" class="btn btn-sm btn-info btn-hide" id="btnAddGwan"><i class="fas fa-plus"></i> 관추가</button>
									<button type="button" class="btn btn-sm btn-info btn-hide" id="btnAddHang"><i class="fas fa-plus"></i> 항추가</button>
									<button type="button" class="btn btn-sm btn-info btn-hide" id="btnAddMock"><i class="fas fa-plus"></i> 목추가</button>
								</c:if>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-12">
								<table id="listTable2" class="table-list table table-sm table-bordered table-hover" style="display: none;font-size: small">
									<thead>
									<tr>
										<th rowspan="2" class="no_toggle"></th>	<%-- dtr-control 위치 --%>
										<th rowspan="2">구분</th>
										<th colspan="2">관</th>
										<th colspan="2">항</th>
										<th colspan="2">목</th>
										<th rowspan="2">비고</th>
									</tr>
									<tr>
										<th>번호</th>
										<th>명칭</th>
										<th>번호</th>
										<th>명칭</th>
										<th>번호</th>
										<th>명칭</th>
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

<!-- Modal -->
<div class="modal fade" id="formModal" tabindex="-1" role="dialog" aria-labelledby="formModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-md" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="formModalLabel">관항목정보</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<i class="fas fa-times"></i>
				</button>
			</div>
			<div class="modal-body">
				<form id="submitForm">
					<table id="dataTable" class="table-form table table-sm table-bordered">
						<colgroup>
							<col width="30%">
							<col width="70%">
						</colgroup>
						<tr>
							<th>사업유형</th>
							<td>
								<select class="select2 form-control-sm" data-minimum-results-for-search="Infinity" style="width: 100%;"
										id="frm_bsns_cate" name="frm_bsns_cate" title="사업유형/년도" data-parsley-required="true">
									<option value="">[사업유형선택]</option>
									<c:forEach var="bsns_cate" items="${bsns_cate_list}" varStatus="status">
										<option value="${bsns_cate.cddt_val}">${bsns_cate.cddt_name}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th>관항목년도</th>
							<td>
								<input type="text" class="form-control form-control-sm" id="frm_ghm_year" name="frm_ghm_year" title="사업유형/년도"
									   data-parsley-required="true" data-parsley-length="[4,4]">
								<small class="checkResult font-italic"></small>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" id="btnRegist">저장</button>
			</div>
		</div>
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="gwanModal" tabindex="-1" role="dialog" aria-labelledby="gwanModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-md" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="gwanModalLabel">관정보</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<i class="fas fa-times"></i>
				</button>
			</div>
			<div class="modal-body">
				<form id="gwanForm">
					<table id="gwanTable" class="table-form table table-sm table-bordered">
						<colgroup>
							<col width="30%">
							<col width="70%">
						</colgroup>
						<tr>
							<th>구분</th>
							<td>
								<input type="hidden" id="frm_gwan_code">
								<div class="input-group d-flex justify-content-around">
									<c:forEach var="io_type" items="${io_type_list}" varStatus="status">
										<div class="icheck-info d-inline">
											<input type="radio" name="frm_gwan_io_type" id="frm_gwan_io_type_${io_type.cddt_val}" value="${io_type.cddt_val}" title="구분" required>
											<label for="frm_gwan_io_type_${io_type.cddt_val}">${io_type.cddt_name}</label>
										</div>
									</c:forEach>
								</div>
							</td>
						</tr>
						<tr>
							<th>번호</th>
							<td>
								<input type="text" class="form-control form-control-sm" id="frm_gwan_numb" name="frm_gwan_numb" title="번호"
									   data-parsley-required="true" data-parsley-maxlength="2">
								<small class="checkResult font-italic"></small>
							</td>
						</tr>
						<tr>
							<th>명칭</th>
							<td>
								<input type="text" class="form-control form-control-sm" id="frm_gwan_name" name="frm_gwan_name" title="명칭"
									   data-parsley-required="true" data-parsley-maxlength="20">
							</td>
						</tr>
						<tr>
							<th>비고</th>
							<td>
								<input type="text" class="form-control form-control-sm" id="frm_gwan_note" name="frm_gwan_note" title="비고"
									   data-parsley-maxlength="100">
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="modal-footer justify-content-between">
				<div class="float-left">
					<button type="button" class="btn btn-danger" id="btnGwanDelete">삭제</button>
				</div>
				<div class="float-right">
					<button type="button" class="btn btn-info" id="btnGwanRegist">저장</button>
					<button type="button" class="btn btn-info" id="btnGwanModify">수정</button>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="hangModal" tabindex="-1" role="dialog" aria-labelledby="hangModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-md" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="hangModalLabel">항정보</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<i class="fas fa-times"></i>
				</button>
			</div>
			<div class="modal-body">
				<form id="hangForm">
					<table id="hangTable" class="table-form table table-sm table-bordered">
						<colgroup>
							<col width="30%">
							<col width="70%">
						</colgroup>
						<tr>
							<th>관선택</th>
							<td>
								<input type="hidden" id="frm_hang_code">
								<select class="select2 form-control-sm" data-minimum-results-for-search="Infinity" style="width: 100%;"
										id="select_gwan_code" name="select_gwan_code" title="관선택" data-parsley-required="true">
								</select>
							</td>
						</tr>
						<tr>
							<th>번호</th>
							<td>
								<input type="text" class="form-control form-control-sm" id="frm_hang_numb" name="frm_hang_numb" title="번호"
									   data-parsley-required="true" data-parsley-maxlength="2">
								<small class="checkResult font-italic"></small>
							</td>
						</tr>
						<tr>
							<th>명칭</th>
							<td>
								<input type="text" class="form-control form-control-sm" id="frm_hang_name" name="frm_hang_name" title="명칭"
									   data-parsley-required="true" data-parsley-maxlength="20">
							</td>
						</tr>
						<tr>
							<th>비고</th>
							<td>
								<input type="text" class="form-control form-control-sm" id="frm_hang_note" name="frm_hang_note" title="비고"
									   data-parsley-maxlength="100">
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="modal-footer justify-content-between">
				<div class="float-left">
					<button type="button" class="btn btn-danger" id="btnHangDelete">삭제</button>
				</div>
				<div class="float-right">
					<button type="button" class="btn btn-info" id="btnHangRegist">저장</button>
					<button type="button" class="btn btn-info" id="btnHangModify">수정</button>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="mockModal" tabindex="-1" role="dialog" aria-labelledby="mockModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-md" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="mockModalLabel">목정보</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<i class="fas fa-times"></i>
				</button>
			</div>
			<div class="modal-body">
				<form id="mockForm">
					<table id="mockTable" class="table-form table table-sm table-bordered">
						<colgroup>
							<col width="30%">
							<col width="70%">
						</colgroup>
						<tr>
							<th>항선택</th>
							<td>
								<input type="hidden" id="frm_mock_code">
								<select class="select2 form-control-sm" data-minimum-results-for-search="Infinity" style="width: 100%;"
										id="select_hang_code" name="select_hang_code" title="항선택" data-parsley-required="true">
								</select>
							</td>
						</tr>
						<tr>
							<th>번호</th>
							<td>
								<input type="text" class="form-control form-control-sm" id="frm_mock_numb" name="frm_mock_numb" title="번호"
									   data-parsley-required="true" data-parsley-maxlength="2">
								<small class="checkResult font-italic"></small>
							</td>
						</tr>
						<tr>
							<th>명칭</th>
							<td>
								<input type="text" class="form-control form-control-sm" id="frm_mock_name" name="frm_mock_name" title="명칭"
									   data-parsley-required="true" data-parsley-maxlength="20">
							</td>
						</tr>
						<tr>
							<th>비고</th>
							<td>
								<input type="text" class="form-control form-control-sm" id="frm_mock_note" name="frm_mock_note" title="비고"
									   data-parsley-maxlength="150">
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="modal-footer justify-content-between">
				<div class="float-left">
					<button type="button" class="btn btn-danger" id="btnMockDelete">삭제</button>
				</div>
				<div class="float-right">
					<button type="button" class="btn btn-info" id="btnMockRegist">저장</button>
					<button type="button" class="btn btn-info" id="btnMockModify">수정</button>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="reportModal" role="dialog" aria-labelledby="reportModalLabel"
	 aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="reportModalLabel">보고서항목</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<i class="fas fa-times"></i>
				</button>
			</div>
			<div class="modal-body">
				<form id="reportForm">
					<table id="reportListTable" class="table-list table table-sm table-bordered table-hover mb-0">
						<colgroup>
							<col width="30%">
							<col width="30%">
							<col width="30%">
							<col width="10%">
						</colgroup>
						<thead>
						<tr>
							<th>제목<span class="required">*</span></th>
							<th>수입 목코드<span class="required">*</span></th>
							<th>지출 목코드<span class="required">*</span></th>
							<th>
								<button type="button" class="btn btn-xs btn-info" onclick="addPopRow()"><i
										class="fas fa-plus"></i> 추가
								</button>
							</th>
						</tr>
						</thead>
						<tbody></tbody>
					</table>
				</form>
			</div>
			<div class="modal-footer">
				<div class="float-right">
					<button type="button" class="btn btn-info" id="btnReportRegist">저장</button>
				</div>
			</div>
		</div>
	</div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
<script id="popTemplate" type="text/x-handlebars-template">
	<tr class="row_{{numb}}">
		<input type="hidden" name="pop_ghmr_code" value="{{ghmr_code}}">
		<td>
			<input type="text" class="form-control form-control-sm" name="pop_ghmr_name" value="{{ghmr_name}}"
				   data-parsley-required="true" data-parsley-maxlength="20" title="제목">
		</td>
		<td>
			<select class="select2 form-control-sm" style="width: 100%;"
					data-parsley-required="true" name="pop_i_mock_code" title="수입 목코드">
				<option value="">[목선택]</option>
			</select>
		</td>
		<td>
			<select class="select2 form-control-sm" style="width: 100%;"
					data-parsley-required="true" name="pop_o_mock_code" title="지출 목코드">
				<option value="">[목선택]</option>
			</select>
		</td>
		<td>
			<button type="button" class="btn btn-xs btn-danger" onclick="popRowDelete('{{numb}}')"><i class="fas fa-minus-circle"></i> 삭제</button>
		</td>
	</tr>
</script>

<script>
	$(function () {
		var args = {
			hideColumns: []
			, orderColumns: [[2, "asc"]]
			, useColvis: false
			, paging: false
			, info: false
		}
		setDatatables("listTable", args);

		var args = {
			hideColumns: []
			, orderColumns: [[1, "asc"]]
			, excludeOrderColumns: []
			, useColvis: false
			, rowspan: [1, 2, 3, 4, 5]
		}
		setDatatables("listTable2", args);

		getPage();
	});

	$("#bsns_cate, #ghm_year").on("change", function () {
		getPage();
	});

	$("#listTable tbody").on("click", "tr", function () {
		var ghm_code = $(this).data("ghm_code");
		getItem(ghm_code);
	});

	function getPage() {
		$(".overlay").show();

		$.ajax({
			type: "POST"
			, url: "/admin/system/ghm/page"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				bsns_cate: $("#bsns_cate").val()
				, ghm_year: $("#ghm_year").val()
				<c:if test="${loginVO.user_level < 8}">
				, ghm_active_yn: 'Y'
				</c:if>
			})
			, success: function (data) {
				if($.fn.DataTable.isDataTable("#listTable")) {
					$("#listTable").DataTable().clear();
				}

				$.each(data, function(index, item) {
					var html = [];
					html.push("");	// dtr-control 위치
				<c:if test="${loginVO.user_level >= 8}">
					if (item.ghm_active_yn == 'Y') {
						html.push("");
					} else {
						html.push("<input type='checkbox' name='tb_check_list' value='" + item.ghm_code + "'>");
					}
				</c:if>
					html.push(item.bsns_cate_name);
					html.push(item.ghm_year);
				<c:if test="${loginVO.user_level >= 8}">
					if (item.ghm_active_yn == 'Y') {
						html.push(item.ghm_active_yn_name);
					} else {
						html.push("<div class='text-danger text-bold'>" + item.ghm_active_yn_name + "</div>");
					}
				</c:if>

					var rowNode = $("#listTable").DataTable().row.add(html).node();
					$(rowNode).attr("data-ghm_code", item.ghm_code);
					$(rowNode).css("cursor", "pointer");
				});

				$("#listTable").DataTable().draw(false);
				$("#listTable").DataTable().columns.adjust().draw();	// 테이블 컬럼 사이즈 조절
				$(".overlay").hide();
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	function getItem(ghm_code) {
		initDataTable("dataTable3");

		$.ajax({
			type: "POST"
			, url: "/admin/system/ghm/item/" + ghm_code
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, success: function (data) {
				setSelectValue(data);
				getSubPage(ghm_code);
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	function getSubPage(ghm_code) {
		$("#btnAddReportList").show();
		$("#btnAddGwan").show();
		$("#btnAddHang").show();
		$("#btnAddMock").show();

		$.ajax({
			type: "POST"
			, url: "/admin/system/ghm/subPage"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				ghm_code: ghm_code
			})
			, success: function (data) {
				if($.fn.DataTable.isDataTable("#listTable2")) {
					$("#listTable2").DataTable().clear();
				}

				$.each(data, function (index, item) {
					var html = [];
					html.push("");	// dtr-control 위치
					html.push(item.gwan_io_type_name);

					html.push("<div <c:if test="${loginVO.user_level >= 8}">onclick=\"getGwanItem('" + item.gwan_code + "')\" style='cursor: pointer;'</c:if>>" + item.gwan_numb + "</div>");
					html.push("<div <c:if test="${loginVO.user_level >= 8}">onclick=\"getGwanItem('" + item.gwan_code + "')\" style='cursor: pointer;'</c:if>>" + item.gwan_name + "</div>");

					html.push("<div <c:if test="${loginVO.user_level >= 8}">onclick=\"getHangItem('" + item.hang_code + "')\" style='cursor: pointer;'</c:if>>" + item.hang_numb + "</div>");
					html.push("<div <c:if test="${loginVO.user_level >= 8}">onclick=\"getHangItem('" + item.hang_code + "')\" style='cursor: pointer;'</c:if>>" + item.hang_name + "</div>");

					html.push("<div <c:if test="${loginVO.user_level >= 8}">onclick=\"getMockItem('" + item.mock_code + "')\" style='cursor: pointer;'</c:if>>" + item.mock_numb + "</div>");
					html.push("<div <c:if test="${loginVO.user_level >= 8}">onclick=\"getMockItem('" + item.mock_code + "')\" style='cursor: pointer;'</c:if>>" + item.mock_name + "</div>");
					html.push("<div class='text-left' <c:if test="${loginVO.user_level >= 8}">onclick=\"getMockItem('" + item.mock_code + "')\" style='cursor: pointer;'</c:if>>" + item.mock_note + "</div>");

					var rowNode = $("#listTable2").DataTable().row.add(html).node();
					$(rowNode).attr("data-ghm_code", item.ghm_code);
				});

				$("#listTable2").DataTable().draw(false);
				$("#listTable2").DataTable().columns.adjust().draw();	// 테이블 컬럼 사이즈 조절
				$(".overlay").hide();
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

<c:if test="${loginVO.user_level >= 8}">
	/* 관리자 로그인 시 등록/수정기능 활성화 */

	$("#frm_ghm_year, #frm_gwan_numb, #frm_hang_numb, #frm_mock_numb").on("keyup focusout", function () {
		$(this).val(formatNumber($(this).val()));
	});

	$("#frm_bsns_cate").on("change", function () {
		var data = {bsns_cate: $("#frm_bsns_cate").val(), ghm_year: $("#frm_ghm_year").val()};
		overlapCheck($("#frm_ghm_year"), "/admin/system/ghm/overlapCheck", data);
	});

	$("#frm_ghm_year").on("keyup focusout", function () {
		var data = {bsns_cate: $("#frm_bsns_cate").val(), ghm_year: $("#frm_ghm_year").val()};
		overlapCheck($("#frm_ghm_year"), "/admin/system/ghm/overlapCheck", data);
	});

	$("input[name=frm_gwan_io_type]").on("change", function () {
		var data = {
			ghm_code: $("#select_ghm_code").val()
			, gwan_io_type: $("input[name=frm_gwan_io_type]:checked").val()
			, gwan_numb: $("#frm_gwan_numb").val()
		};
		overlapCheck($("#frm_gwan_numb"), "/admin/system/gwan/overlapCheck", data);
	});

	$("#frm_gwan_numb").on("keyup focusout", function () {
		var data = {
			ghm_code: $("#select_ghm_code").val()
			, gwan_io_type: $("input[name=frm_gwan_io_type]:checked").val()
			, gwan_numb: $("#frm_gwan_numb").val()
		};
		overlapCheck($("#frm_gwan_numb"), "/admin/system/gwan/overlapCheck", data);
	});

	$("#btnAdd").on("click", function () {
		initDataTable("dataTable");
		$("#btnRegist").show();
		$("#formModal").modal("show");
	});

	$("#btnAddGwan").on("click", function () {
		initDataTable("gwanTable");
		$("#btnGwanRegist").show();
		$("#btnGwanModify").hide();
		$("#btnGwanDelete").hide();
		$("#gwanModal").modal("show");
	});

	$("#btnAddHang").on("click", function () {
		initDataTable("hangTable");
		$("#btnHangRegist").show();
		$("#btnHangModify").hide();
		$("#btnHangDelete").hide();

		getGwanList();

		$("#hangModal").modal("show");
	});

	$("#btnAddMock").on("click", function () {
		initDataTable("mockTable");
		$("#btnMockRegist").show();
		$("#btnMockModify").hide();
		$("#btnMockDelete").hide();

		getHangList();

		$("#mockModal").modal("show");
	});

	$("#btnRegist").on("click", function () {
		if (!parsleyFormValidate("submitForm")) return false;
		if (!checkResultValidate("submitForm", "checkResult")) return false;
		if (!confirm("저장하시겠습니까?")) return false;

		$.ajax({
			type: "POST"
			, url: "/admin/system/ghm/regist"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				bsns_cate: $("#frm_bsns_cate").val()
				, ghm_year: $("#frm_ghm_year").val()
			})
			, success: function (data) {
				if (data == 'success') {
					$("#formModal").modal("hide");
					getPage();
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	});

	$("#btnGwanRegist").on("click", function () {
		if (!parsleyFormValidate("gwanForm")) return false;
		if (!checkResultValidate("gwanForm", "checkResult")) return false;
		if (!confirm("저장하시겠습니까?")) return false;

		$.ajax({
			type: "POST"
			, url: "/admin/system/gwan/regist"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				ghm_code: $("#select_ghm_code").val()
				, bsns_cate: $("#select_bsns_cate").val()
				, ghm_year: $("#select_ghm_year").html()
				, gwan_io_type: $("input[name=frm_gwan_io_type]:checked").val()
				, gwan_numb: $("#frm_gwan_numb").val()
				, gwan_name: $("#frm_gwan_name").val()
				, gwan_note: $("#frm_gwan_note").val()
			})
			, success: function (data) {
				if (data == 'success') {
					initDataTable("gwanTable");
					getSubPage($("#select_ghm_code").val());
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	});

	function getGwanItem(gwan_code) {
		initDataTable("gwanTable");
		$("#btnGwanRegist").hide();
		$("#btnGwanModify").show();
		$("#btnGwanDelete").show();
		$("#gwanModal").modal("show");

		$.ajax({
			type: "POST"
			, url: "/admin/system/gwan/item/" + gwan_code
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, success: function (data) {
				setFrmValue(data);
				$("input[name=frm_gwan_io_type]").attr("disabled", true);
				$("#frm_gwan_numb").attr("disabled", true);
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	$("#btnGwanModify").on("click", function () {
		if (!parsleyFormValidate("gwanForm")) return false;
		if (!checkResultValidate("gwanForm", "checkResult")) return false;
		if (!confirm("수정하시겠습니까?")) return false;

		$.ajax({
			type: "PUT"
			, url: "/admin/system/gwan/modify/" + $("#frm_gwan_code").val()
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				gwan_name: $("#frm_gwan_name").val()
				, gwan_note: $("#frm_gwan_note").val()
			})
			, success: function (data) {
				if (data == 'success') {
					$("#gwanModal").modal("hide");
					getSubPage($("#select_ghm_code").val());
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	});

	$("#btnGwanDelete").on("click", function () {
		if (!confirm("삭제하시겠습니까?")) return false;

		$.ajax({
			type: "DELETE"
			, url: "/admin/system/gwan/delete/" + $("#frm_gwan_code").val()
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({})
			, success: function (data) {
				if (data == 'success') {
					$("#gwanModal").modal("hide");
					getSubPage($("#select_ghm_code").val());
				} else {
					alert(data);
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	});

	function getGwanList() {
		$.ajax({
			type: "POST"
			, url: "/ghm/gwan/list"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				ghm_code: $("#select_ghm_code").val()
			})
			, async: false
			, success: function (data) {
				$("#select_gwan_code").empty();
				$("#select_gwan_code").append("<option value=''>[관선택]</option").trigger("change");
				$.each(data, function (index, item) {
					var optionText = "[" + item.gwan_io_type_name + " " + item.gwan_numb + "] " + item.gwan_name;
					$("#select_gwan_code").append("<option value='" + item.gwan_code + "'>" + optionText + "</option>").trigger("change");
				});
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}


	$("#select_gwan_code").on("change", function () {
		var hang_code = $("#frm_hang_code").val();
		if (isNull(hang_code)) {
			var data = {hang_code: $("#select_gwan_code").val(), mock_numb: $("#frm_hang_numb").val()};
			overlapCheck($("#frm_hang_numb"), "/admin/system/mock/overlapCheck", data);
		}
	});

	$("#frm_hang_numb").on("keyup focusout", function () {
		var data = {
			gwan_code: $("#select_gwan_code").val()
			, hang_numb: $("#frm_hang_numb").val()
		};
		overlapCheck($("#frm_hang_numb"), "/admin/system/hang/overlapCheck", data);
	});

	$("#btnHangRegist").on("click", function () {
		if (!parsleyFormValidate("hangForm")) return false;
		if (!checkResultValidate("hangForm", "checkResult")) return false;
		if (!confirm("저장하시겠습니까?")) return false;

		$.ajax({
			type: "POST"
			, url: "/admin/system/hang/regist"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				gwan_code: $("#select_gwan_code").val()
				, hang_numb: $("#frm_hang_numb").val()
				, hang_name: $("#frm_hang_name").val()
				, hang_note: $("#frm_hang_note").val()
			})
			, success: function (data) {
				if (data == 'success') {
					initDataTable("hangTable");
					getSubPage($("#select_ghm_code").val());
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	});

	function getHangItem(hang_code) {
		initDataTable("hangTable");
		$("#btnHangRegist").hide();
		$("#btnHangModify").show();
		$("#btnHangDelete").show();

		getGwanList();

		$("#hangModal").modal("show");

		$.ajax({
			type: "POST"
			, url: "/admin/system/hang/item/" + hang_code
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, success: function (data) {
				setFrmValue(data);
				$("#select_gwan_code").val(data.gwan_code).trigger("change");
				$("#select_gwan_code").attr("disabled", true);
				$("#frm_hang_numb").attr("disabled", true);
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	$("#btnHangModify").on("click", function () {
		if (!parsleyFormValidate("hangForm")) return false;
		if (!checkResultValidate("hangForm", "checkResult")) return false;
		if (!confirm("수정하시겠습니까?")) return false;

		$.ajax({
			type: "PUT"
			, url: "/admin/system/hang/modify/" + $("#frm_hang_code").val()
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				hang_name: $("#frm_hang_name").val()
				, hang_note: $("#frm_hang_note").val()
			})
			, success: function (data) {
				if (data == 'success') {
					$("#hangModal").modal("hide");
					getSubPage($("#select_ghm_code").val());
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	});

	$("#btnHangDelete").on("click", function () {
		if (!confirm("삭제하시겠습니까?")) return false;

		$.ajax({
			type: "DELETE"
			, url: "/admin/system/hang/delete/" + $("#frm_hang_code").val()
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({})
			, success: function (data) {
				if (data == 'success') {
					$("#hangModal").modal("hide");
					getSubPage($("#select_ghm_code").val());
				} else {
					alert(data);
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	});

	function getHangList() {
		$.ajax({
			type: "POST"
			, url: "/ghm/hang/list"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				ghm_code: $("#select_ghm_code").val()
			})
			, async: false
			, success: function (data) {
				$("#select_hang_code").empty();
				$("#select_hang_code").append("<option value=''>[항선택]</option").trigger("change");
				$.each(data, function (index, item) {
					var optionText = "[" + item.gwan_io_type_name + " " + item.gwan_numb + item.hang_numb + "] " + item.hang_name;
					$("#select_hang_code").append("<option value='" + item.hang_code + "'>" + optionText + "</option>").trigger("change");
				});
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}


	$("#select_hang_code").on("change", function () {
		var mock_code = $("#frm_mock_code").val();
		if (isNull(mock_code)) {
			var data = {hang_code: $("#select_hang_code").val(), mock_numb: $("#frm_mock_numb").val()};
			overlapCheck($("#frm_mock_numb"), "/admin/system/mock/overlapCheck", data);
		}
	});

	$("#frm_mock_numb").on("keyup focusout", function () {
		var data = {
			hang_code: $("#select_hang_code").val()
			, mock_numb: $("#frm_mock_numb").val()
		};
		overlapCheck($("#frm_mock_numb"), "/admin/system/mock/overlapCheck", data);
	});

	$("#btnMockRegist").on("click", function () {
		if (!parsleyFormValidate("mockForm")) return false;
		if (!checkResultValidate("mockForm", "checkResult")) return false;
		if (!confirm("저장하시겠습니까?")) return false;

		$.ajax({
			type: "POST"
			, url: "/admin/system/mock/regist"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				hang_code: $("#select_hang_code").val()
				, mock_numb: $("#frm_mock_numb").val()
				, mock_name: $("#frm_mock_name").val()
				, mock_note: $("#frm_mock_note").val()
			})
			, success: function (data) {
				if (data == 'success') {
					initDataTable("mockTable");
					getSubPage($("#select_ghm_code").val());
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	});

	function getMockItem(mock_code) {
		initDataTable("mockTable");
		$("#btnMockRegist").hide();
		$("#btnMockModify").show();
		$("#btnMockDelete").show();

		getHangList();

		$("#mockModal").modal("show");

		$.ajax({
			type: "POST"
			, url: "/admin/system/mock/item/" + mock_code
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, success: function (data) {
				setFrmValue(data);
				$("#select_hang_code").val(data.hang_code).trigger("change");
				$("#select_hang_code").attr("disabled", true);
				$("#frm_mock_numb").attr("disabled", true);
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	$("#btnMockModify").on("click", function () {
		if (!parsleyFormValidate("mockForm")) return false;
		if (!checkResultValidate("mockForm", "checkResult")) return false;
		if (!confirm("수정하시겠습니까?")) return false;

		$.ajax({
			type: "PUT"
			, url: "/admin/system/mock/modify/" + $("#frm_mock_code").val()
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				mock_name: $("#frm_mock_name").val()
				, mock_note: $("#frm_mock_note").val()
			})
			, success: function (data) {
				if (data == 'success') {
					$("#mockModal").modal("hide");
					getSubPage($("#select_ghm_code").val());
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	});

	$("#btnMockDelete").on("click", function () {
		if (!confirm("삭제하시겠습니까?")) return false;

		$.ajax({
			type: "DELETE"
			, url: "/admin/system/mock/delete/" + $("#frm_mock_code").val()
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({})
			, success: function (data) {
				if (data == 'success') {
					$("#mockModal").modal("hide");
					getSubPage($("#select_ghm_code").val());
				} else {
					alert(data);
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	});

	$("#btnActivate").on("click", function () {
		if ($("#listTable input[name=tb_check_list]:checked").length == 0) {
			alert("선택된 항목이 없습니다.");
			return false;
		}
		if (!confirm("활성화하시겠습니까?")) return false;

		var ghm_code_list = [];
		$("#listTable input[name=tb_check_list]:checked").each(function () {
			ghm_code_list.push($(this).val());
		});

		console.log(ghm_code_list);

		$.ajax({
			type: "POST"
			, url: "/admin/system/ghm/activate"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				ghm_code_list: ghm_code_list
			})
			, success: function (data) {
				if (data == 'success') {
					getPage();
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	});

	$("#btnAddReportList").on("click", function () {
		initDataTable("reportListTable");
		getGhmReportList();
		$("#reportModal").modal("show");
	});

	function getGhmReportList() {
		$.ajax({
			type: "POST"
			, url: "/admin/system/ghm/report/list"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				ghm_code: $("#select_ghm_code").val()
			})
			, async: false
			, success: function (data) {
				$("#reportListTable tbody").empty();
				if (data.length > 0) {
					$.each(data, function (index, item) {
						addPopRow(item);
					});
				} else {
					addPopRow();
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	var p_row_numb = 0;

	function addPopRow(data) {
		var popTemplate = $("#popTemplate").html();
		var popBindTemplate = Handlebars.compile(popTemplate);

		var html = "";
		if (isNull(data)) {
			var item = {
				numb: ++p_row_numb
				, ghmr_code: ""
				, ghmr_name: ""
				, i_mock_code: ""
				, o_mock_code: ""
			}
			html += popBindTemplate(item);
		} else {
			var item = {
				numb: ++p_row_numb
				, ghmr_code: data.ghmr_code
				, ghmr_name: data.ghmr_name
				, i_mock_code: data.i_mock_code
				, o_mock_code: data.o_mock_code
			}
			html += popBindTemplate(item);
		}
		$("#reportListTable tbody").append(html);

		// 수입목코드 세팅
		$("#reportListTable tbody tr.row_" + p_row_numb).find("select[name=pop_i_mock_code]").append(mockSelectOption("I"));
		$("#reportListTable tbody tr.row_" + p_row_numb).find("select[name=pop_i_mock_code]").val(item.i_mock_code).trigger("change");
		// 지출목코드 세팅
		$("#reportListTable tbody tr.row_" + p_row_numb).find("select[name=pop_o_mock_code]").append(mockSelectOption("O"));
		$("#reportListTable tbody tr.row_" + p_row_numb).find("select[name=pop_o_mock_code]").val(item.o_mock_code).trigger("change");

		$("#reportListTable tbody tr.row_" + p_row_numb + " .select2").select2();
	}

	function mockSelectOption(io_type) {
		var html = "";
		$.ajax({
			type: "POST"
			, url: "/ghm/mock/list"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				ghm_code: $("#select_ghm_code").val()
				, gwan_io_type: io_type
			})
			, async: false
			, success: function (data) {
				$.each(data, function (index, item) {
					var optionText = "[" + item.gwan_numb + item.hang_numb + item.mock_numb + "] " + item.mock_name;
					html += "<option value='" + item.mock_code + "'>" + optionText + "</option>";
				});
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});

		return html;
	}

	$("#btnReportRegist").on("click", function () {
		if (!parsleyFormValidate("reportForm")) return false;
		if (!confirm("저장하시겠습니까?")) return false;

		var ghmr_code_list = [];
		var ghmr_name_list = [];
		var i_mock_code_list = [];
		var o_mock_code_list = [];

		$.each($("#reportListTable tbody tr"), function () {
			ghmr_code_list.push($(this).find("input[name=pop_ghmr_code]").val());
			ghmr_name_list.push($(this).find("input[name=pop_ghmr_name]").val());
			i_mock_code_list.push($(this).find("select[name=pop_i_mock_code]").val());
			o_mock_code_list.push($(this).find("select[name=pop_o_mock_code]").val());
		});

		$.ajax({
			type: "POST"
			, url: "/admin/system/ghm/report/regist"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				ghm_code: $("#select_ghm_code").val()
				, ghmr_code_list: ghmr_code_list
				, ghmr_name_list: ghmr_name_list
				, i_mock_code_list: i_mock_code_list
				, o_mock_code_list: o_mock_code_list
			})
			, async: false
			, success: function (data) {
				if (data == 'success') {
					getPage();
					$("#reportModal").modal("hide");
				} else {
					alert(data);
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	});

	function popRowDelete(numb) {
		if (!confirm("삭제하시겠습니까?")) return false;

		var ghmr_code = $("#reportListTable tbody tr.row_" + numb).find("input[name=pop_ghmr_code]").val();
		if (isNotNull(ghmr_code)) {
			$.ajax({
				type: "DELETE"
				, url: "/admin/system/ghm/report/delete/" + ghmr_code
				, headers: {"Content-Type": "application/json"}
				, dataType: "text"
				, success: function (data) {
					if (data == 'success') {
						$("#reportListTable tbody tr.row_" + numb).remove();
					} else {
						alert(data);
					}
				}
				, error: function (request, status, error) {
					alertAjaxError(request, status, error);
				}
			});
		} else {
			$("#reportListTable tbody tr.row_" + numb).remove();
		}
	}

</c:if>

</script>