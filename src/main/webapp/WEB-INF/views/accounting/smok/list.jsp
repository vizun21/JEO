<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-xl-2 col-md-3 col-sm-4">
				<div class="form-group">
					<select class="select2" id="ghm_year" data-minimum-results-for-search="Infinity" style="width: 100%;">
						<c:forEach var="ghm_year" items="${ghm_year_list}">
							<option value="${ghm_year.ghm_year}">${ghm_year.ghm_year}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="col-xl-10 col-md-9 col-sm-8">
				<div class="form-group">
					<div class="input-group input-group-md">
						<select class="select2" id="keyword_column" data-minimum-results-for-search="Infinity" style="width: 180px;">
							<option value="smok_name">세목명칭</option>
							<option value="mock_name">목명칭</option>
							<option value="hang_name">항명칭</option>
							<option value="gwan_name">관명칭</option>
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
							<div class="col-md-5">
								<div class="float-right">
									<button type="button" class="btn btn-sm btn-info" id="btnAdd"><i class="fas fa-plus"></i> 추가</button>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-12">
								<table id="listTable" class="table-list table table-sm table-bordered table-hover" style="display: none;">
									<thead>
									<tr>
										<th class="no_toggle"></th>	<%-- dtr-control 위치 --%>
										<th>구분</th>
										<th>관번호</th>
										<th>관명칭</th>
										<th>항번호</th>
										<th>항명칭</th>
										<th>목번호</th>
										<th>목명칭</th>
										<th>세목번호</th>
										<th>세목명칭</th>
										<th>세목비고</th>
										<th>등록일</th>
										<th>수정일</th>
										<th>최종수정자</th>
										<th>삭제</th>
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
<div class="modal fade" id="formModal" role="dialog" aria-labelledby="formModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-md" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="formModalLabel">사업정보</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<i class="fas fa-times"></i>
				</button>
			</div>
			<div class="modal-body">
				<form id="submitForm">
					<table id="dataTable" class="table-form table table-sm table-bordered">
						<colgroup>
							<col width="40%">
							<col width="60%">
						</colgroup>
						<tr>
							<th>회계년도<span class="required">*</span></th>
							<td>
								<input type="hidden" id="frm_smok_code">
								<select class="select2 form-control-sm" data-minimum-results-for-search="Infinity" style="width: 100%;"
										id="frm_ghm_year" name="frm_ghm_year" title="회계년도" data-parsley-required="true">
									<option value="">[회계년도선택]</option>
								<c:forEach var="ghm_year" items="${ghm_year_list}">
									<option value="${ghm_year.ghm_year}">${ghm_year.ghm_year}</option>
								</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th>목선택<span class="required">*</span></th>
							<td>
								<select class="select2 form-control-sm" style="width: 100%;"
										id="frm_mock_code" name="frm_mock_code" title="목선택" data-parsley-required="true">
									<option value="">[목선택]</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>번호<span class="required">*</span></th>
							<td>
								<input type="text" class="form-control form-control-sm" id="frm_smok_numb" name="frm_smok_numb" title="번호"
									   data-parsley-required="true" data-parsley-maxlength="2">
								<small class="checkResult font-italic"></small>
							</td>
						</tr>
						<tr>
							<th>명칭<span class="required">*</span></th>
							<td>
								<input type="text" class="form-control form-control-sm" id="frm_smok_name" name="frm_smok_name" title="명칭"
									   data-parsley-required="true" data-parsley-maxlength="20">
							</td>
						</tr>
						<tr>
							<th>비고</th>
							<td>
								<input type="text" class="form-control form-control-sm" id="frm_smok_note" name="frm_smok_note" title="비고"
									   data-parsley-maxlength="100">
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" id="btnRegist">저장</button>
				<button type="button" class="btn btn-info" id="btnModify">수정</button>
			</div>
		</div>
	</div>
</div>

<script>
	$(function () {
		var maxIndex = $("#listTable th").length - 1
		var args = {
			hideColumns: [maxIndex-3, maxIndex-2, maxIndex-1]
			, orderColumns: [[1, "asc"]]
			, excludeOrderColumns: [14]
			, useColvis: true
		}
		setDatatables("listTable", args);

		getPage();
	});

	$("#ghm_year").on("change", function () {
		getPage();
	});

	function getPage() {
		$(".overlay").show();

		$.ajax({
			type: "POST"
			, url: "/accounting/smok/page"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				ghm_year: $("#ghm_year").val()
				, keyword_column: $("#keyword_column").val()
				, keyword: $("#keyword").val()
			})
			, success: function (data) {
				if($.fn.DataTable.isDataTable("#listTable")) {
					$("#listTable").DataTable().clear();
				}

				$.each(data, function(index, item) {
					var html = [];
					html.push("");	// dtr-control 위치
					html.push(item.gwan_io_type_name);
					html.push(item.gwan_numb);
					html.push(item.gwan_name);
					html.push(item.hang_numb);
					html.push(item.hang_name);
					html.push(item.mock_numb);
					html.push(item.mock_name);
					html.push(item.smok_numb);
					html.push(item.smok_name);
					html.push(item.smok_note);
					html.push(item.smok_reg_date);
					html.push(item.smok_mod_date);
					html.push(item.smok_mod_user_name);
					html.push("<button type='button' class='btn btn-sm btn-danger' onclick=\"smokDelete('" + item.smok_code + "')\">삭제</button>");

					var rowNode = $("#listTable").DataTable().row.add(html).node();
					$(rowNode).attr("data-smok_code", item.smok_code);
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

	$("#btnAdd").on("click", function () {
		initDataTable("dataTable");
		$("#btnRegist").show();
		$("#btnModify").hide();
		$("#formModal").modal("show");
	});

	$("#frm_ghm_year").on("change", function () {
		if ($(this).val() == '') {
			$("#frm_mock_code").empty();
			$("#frm_mock_code").append("<option value=''>[목선택]</option").trigger("change");
		} else {
			getMockList();
		}
	});

	function getMockList() {
		$.ajax({
			type: "POST"
			, url: "/ghm/mock/list"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				ghm_year: $("#frm_ghm_year").val()
				, bsns_cate: '${businessVO.bsns_cate}'
			})
			, async: false
			, success: function (data) {
				$("#frm_mock_code").empty();
				$("#frm_mock_code").append("<option value=''>[목선택]</option").trigger("change");
				$.each(data, function(index, item) {
					var optionText = "[" + item.gwan_io_type_name + " " + item.gwan_numb + item.hang_numb + item.mock_numb + "] " + item.mock_name;
					$("#frm_mock_code").append("<option value='" + item.mock_code +"'>" + optionText + "</option>").trigger("change");
				});
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	$("#frm_smok_numb").on("keyup focusout", function () {
		$(this).val(formatPhone($(this).val()));

		if(!$("#frm_smok_code").val()) {
			var data = {mock_code: $("#frm_mock_code").val(), smok_numb: $("#frm_smok_numb").val()};
			overlapCheck($("#frm_smok_numb"), "/accounting/smok/overlapCheck", data);
		}
	});

	$("#frm_mock_code").on("change", function () {
		if(!$("#frm_smok_code").val()) {
			var data = {mock_code: $("#frm_mock_code").val(), smok_numb: $("#frm_smok_numb").val()};
			overlapCheck($("#frm_smok_numb"), "/accounting/smok/overlapCheck", data);
		}
	});

	$("#btnRegist").on("click", function () {
		if (!parsleyFormValidate("submitForm")) return false;
		if (!checkResultValidate("submitForm", "checkResult")) return false;
		if (!confirm("저장하시겠습니까?")) return false;

		$.ajax({
			type: "POST"
			, url: "/accounting/smok/regist"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				mock_code: $("#frm_mock_code").val()
				, smok_numb: $("#frm_smok_numb").val()
				, smok_name: $("#frm_smok_name").val()
				, smok_note: $("#frm_smok_note").val()
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

	$("#listTable tbody").on("dblclick", "tr", function () {
		var smok_code = $(this).data("smok_code");
		getItem(smok_code);
	});

	function getItem(smok_code) {
		initDataTable("dataTable");
		$("#btnRegist").hide();
		$("#btnModify").show();
		$("#formModal").modal("show");

		$.ajax({
			type: "POST"
			, url: "/accounting/smok/item/" + smok_code
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, success: function (data) {
				setFrmValue(data);
				$("#frm_ghm_year").attr("disabled", true);
				$("#frm_mock_code").attr("disabled", true);
				$("#frm_mock_code").val(data.mock_code);
				$("#frm_smok_numb").attr("disabled", true);
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	$("#btnModify").on("click", function () {
		if (!parsleyFormValidate("submitForm")) return false;
		if (!confirm("수정하시겠습니까?")) return false;

		$.ajax({
			type: "PUT"
			, url: "/accounting/smok/modify/" + $("#frm_smok_code").val()
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				smok_name: $("#frm_smok_name").val()
				, smok_note: $("#frm_smok_note").val()
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

	function smokDelete(smok_code) {
		if (!confirm("삭제하시겠습니까?")) return false;

		$.ajax({
			type: "DELETE"
			, url: "/accounting/smok/delete/" + smok_code
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, success: function (data) {
				if (data == 'success') {
					$("#formModal").modal("hide");
					getPage();
				} else {
					alert(data);
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

</script>