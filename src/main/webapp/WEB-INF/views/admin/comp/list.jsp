<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="row">
					<div class="col-xl-2 col-md-3 col-sm-4">
						<div class="form-group">
							<select class="select2" id="comp_type" data-minimum-results-for-search="Infinity" style="width: 100%;">
								<option value="">사업구분선택</option>
								<option value="P">개인</option>
								<option value="C">법인</option>
							</select>
						</div>
					</div>
					<div class="col-xl-2 col-md-3 col-sm-4">
						<div class="form-group">
							<select class="select2" id="comp_appr_yn" data-minimum-results-for-search="Infinity" style="width: 100%;">
								<option value="">승인상태선택</option>
								<option value="Y">승인</option>
								<option value="N">미승인</option>
							</select>
						</div>
					</div>
					<div class="col-xl-8 col-md-6 col-sm-4">
						<div class="form-group">
							<div class="input-group input-group-md">
								<select class="select2" id="keyword_column" data-minimum-results-for-search="Infinity" style="width: 180px;">
									<option value="comp_name">사업자명</option>
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
									<button type="button" class="btn btn-sm btn-info" id="btnApproval"><i class="fas fa-check"></i> 승인</button>
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
										<th>코드</th>
										<th>사업구분</th>
										<th>사업자번호</th>
										<th>사업자명</th>
										<th>승인여부</th>
										<th>만료일자</th>
										<th>대표ID</th>
										<th>대표자</th>
										<th>대표이메일</th>
										<th>대표핸드폰</th>
									<c:if test="${loginVO.user_level == 9}">
										<th>삭제</th>
									</c:if>
										<th>등록일</th>
										<th>수정일</th>
										<th>최종수정자</th>
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
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="formModalLabel">사업자정보</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<i class="fas fa-times"></i>
				</button>
			</div>
			<div class="modal-body">
				<form id="submitForm">
					<table id="dataTable" class="table-form table table-sm table-bordered">
						<colgroup>
							<col width="20%">
							<col width="30%">
							<col width="20%">
							<col width="30%">
						</colgroup>
						<tr>
							<th>사업자코드</th>
							<td><span id="frm_comp_code"></span></td>
							<th>사업구분</th>
							<td>
								<div class="input-group d-flex justify-content-around">
									<div class="icheck-info d-inline">
										<input type="radio" name="frm_comp_type" id="frm_comp_type_p" value="P" title="사업구분" disabled>
										<label for="frm_comp_type_p">개인</label>
									</div>
									<div class="icheck-info d-inline">
										<input type="radio" name="frm_comp_type" id="frm_comp_type_c" value="C" title="사업구분" disabled>
										<label for="frm_comp_type_c">법인</label>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<th>사업자번호</th>
							<td><span id="frm_comp_reg_numb"></span></td>
							<th>사업자명</th>
							<td><span id="frm_comp_name"></span></td>
						</tr>
						<tr>
							<th>등록일</th>
							<td><span id="frm_comp_reg_date"></span></td>
							<th>만료일</th>
							<td>
								<input type="text" class="datepicker form-control form-control-sm" id="frm_comp_exp_date" name="frm_comp_exp_date" title="만료일"
									   data-parsley-required="true" readonly>
							</td>
						</tr>
						<tr>
							<th>대표자ID</th>
							<td><span id="frm_ceo_id"></span></td>
							<th>대표자</th>
							<td><span id="frm_ceo_name"></span></td>
						</tr>
						<tr>
							<th>대표이메일</th>
							<td><span id="frm_ceo_email"></span></td>
							<th>대표핸드폰</th>
							<td><span id="frm_ceo_mobile"></span></td>
						</tr>
					</table>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" id="btnModify">수정</button>
			</div>
		</div>
	</div>
</div>

<script>
	$(function () {
		var maxIndex = $("#listTable th").length - 1
		var args = {
			hideColumns: [maxIndex-2, maxIndex-1, maxIndex]
			, orderColumns: [[2, "asc"]]
			, excludeOrderColumns: [1]
			, useColvis: true
		}
		setDatatables("listTable", args);

		getPage();
	});

	$("#comp_type, #comp_appr_yn").on("change", function () {
		getPage();
	});

	$("#listTable tbody").on("dblclick", "tr", function () {
		var comp_code = $(this).data("comp_code");
		getItem(comp_code);
	});

	function getPage() {
		$(".overlay").show();

		$.ajax({
			type: "POST"
			, url: "/comp/page"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				comp_type: $("#comp_type").val()
				, comp_appr_yn: $("#comp_appr_yn").val()
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
					if (item.comp_appr_yn == 'Y') {
						html.push("");
					} else {
						html.push("<input type='checkbox' name='tb_check_list' value='" + item.comp_code + "' data-ceo_id='" + item.ceo_id + "'>");
					}
					html.push(item.comp_code);
					html.push(item.comp_type_name);
					html.push(item.comp_reg_numb);
					html.push(item.comp_name);
					if (item.comp_appr_yn == 'Y') {
						html.push(item.comp_appr_yn_name);
					} else {
						html.push("<div class='text-danger text-bold'>" + item.comp_appr_yn_name + "</div>");
					}
					html.push(item.comp_exp_date);
					html.push(item.ceo_id);
					html.push(item.ceo_name);
					html.push(item.ceo_email);
					html.push(item.ceo_mobile);
				<c:if test="${loginVO.user_level == 9}">
					html.push("<button type='button' class='btn btn-xs btn-danger' onclick=\"compDelete('" + item.comp_code + "')\"><i class='fas fa-minus-circle'></i> 삭제</button>");
				</c:if>
					html.push(item.comp_reg_date);
					html.push(item.comp_mod_date);
					html.push(item.comp_mod_user_name);

					var rowNode = $("#listTable").DataTable().row.add(html).node();
					$(rowNode).attr("data-comp_code", item.comp_code);
				});

				$("#listTable").DataTable().draw(false);
				$("#listTable").DataTable().columns.adjust().draw();

				$("input[name=tb_check_all]").prop("checked", false);
				$("input[name=tb_check_list]").on("change", function () {
					syncCheckbox("listTable");
				});

				$(".overlay").hide();
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	function getItem(comp_code) {
		$("#formModal").modal("show");

		$.ajax({
			type: "POST"
			, url: "/comp/item"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				comp_code: comp_code
			})
			, success: function (data) {
				setFrmValue(data);
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
			type: "POST"
			, url: "/comp/modify/" + $("#frm_comp_code").html()
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				comp_exp_date: $("#frm_comp_exp_date").val()
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

	$("#btnApproval").on("click", function () {
		if ($("input[name=tb_check_list]:checked").length == 0) {
			alert("선택된 항목이 없습니다.");
			return false;
		}
		if (!confirm("승인처리하시겠습니까?")) return false;

		var comp_code_list = [];
		var ceo_id_list = [];
		$("input[name=tb_check_list]:checked").each(function () {
			comp_code_list.push($(this).val());
			ceo_id_list.push($(this).data("ceo_id"));
		});

		$.ajax({
			type: "POST"
			, url: "/comp/approval"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				comp_code_list: comp_code_list
				, ceo_id_list: ceo_id_list
			})
			, async: false
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

	function compDelete(comp_code) {
		if (!confirm("DB 및 뱅크다연동 정보가 전부 삭제됩니다.\n삭제하시겠습니까?")) return false;

		$.ajax({
			type: "DELETE"
			, url: "/comp/delete/" + comp_code
			, dataType: "text"
			, success: function (data) {
				if (data == 'success') {
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