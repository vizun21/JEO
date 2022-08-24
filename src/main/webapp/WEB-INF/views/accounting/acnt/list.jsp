<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-xl-2 col-md-3 col-sm-4">
				<div class="form-group">
					<select class="select2" id="bank_code" style="width: 100%;">
						<option value="">[은행선택]</option>
					<c:forEach var="bank" items="${bank_list}">
						<option value="${bank.bank_code}" data-bank_web_yn="${bank.bank_web_yn}">${bank.bank_name}</option>
					</c:forEach>
					</select>
				</div>
			</div>
			<div class="col-xl-10 col-md-9 col-sm-8">
				<div class="form-group">
					<div class="input-group input-group-md">
						<select class="select2" id="keyword_column" data-minimum-results-for-search="Infinity" style="width: 180px;">
							<option value="acnt_name">계좌명(별칭)</option>
							<option value="acnt_numb">계좌번호</option>
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
										<th>은행</th>
										<th>계좌명(별칭)</th>
										<th>계좌번호</th>
										<th>계좌상태</th>
										<th>계좌조회결과</th>
										<th>비고</th>
										<th>삭제</th>
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
<div class="modal fade" id="formModal" role="dialog" aria-labelledby="formModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-md" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="formModalLabel">계좌정보</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<i class="fas fa-times"></i>
				</button>
			</div>
			<div class="modal-body">
				<div id="modifyDescription" class="mb-3" style="display: none;">
					<span class="red" style="font-size: 9pt;">※은행 및 계좌번호는 수정이 불가능합니다.<br>※은행 및 계좌번호를 수정하시려면 계좌를 삭제 후 다시 등록을 해주세요.</span>
				</div>
				<form id="submitForm">
					<table id="dataTable" class="table-form table table-sm table-bordered">
						<colgroup>
							<col width="40%">
							<col width="60%">
						</colgroup>
						<tr>
							<th>은행<span class="required">*</span></th>
							<td>
								<input type="hidden" id="frm_acnt_code">
								<select class="select2 form-control-sm" style="width: 100%;" id="frm_bank_code" name="frm_bank_code" title="은행" data-parsley-required="true">
									<option value="">[은행선택]</option>
								<c:forEach var="bank" items="${bank_list}">
									<option value="${bank.bank_code}" data-bank_web_yn="${bank.bank_web_yn}">${bank.bank_name}</option>
								</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th>계좌명(별칭)<span class="required">*</span></th>
							<td>
								<input type="text" class="form-control form-control-sm" id="frm_acnt_name" name="frm_acnt_name" title="계좌명(별칭)"
									   data-parsley-required="true" data-parsley-maxlength="20">
							</td>
						</tr>
						<tr>
							<th>계좌번호<span class="required">*</span></th>
							<td>
								<input type="text" class="form-control form-control-sm" id="frm_acnt_numb" name="frm_acnt_numb" title="계좌번호"
									   data-parsley-required="true" data-parsley-maxlength="64" placeholder="'-' 없이 입력">
								<small class="checkResult font-italic"></small>
							</td>
						</tr>
						<tr id="tr_acnt_pw">
							<th>계좌비밀번호<span class="required">*</span></th>
							<td>
								<input type="password" class="form-control form-control-sm" id="frm_acnt_pw" name="frm_acnt_pw" title="계좌비밀번호"
									   data-parsley-required="true" data-parsley-maxlength="64">
							</td>
						</tr>
						<tr id="tr_acnt_pw_modify">
							<th>계좌비밀번호 변경<br><small>(변경시에만 입력)</small></th>
							<td>
								<input type="password" class="form-control form-control-sm" id="frm_acnt_pw_modify" name="frm_acnt_pw_modify" title="계좌비밀번호 변경"
									   data-parsley-maxlength="64">
							</td>
						</tr>
						<tr class="acnt_web" style="display: none;">
							<th>간편조회ID<span class="required">*</span></th>
							<td>
								<input type="text" class="form-control form-control-sm" id="frm_acnt_web_id" name="frm_acnt_web_id" title="간편조회ID"
									   data-parsley-required="true" data-parsley-maxlength="30">
							</td>
						</tr>
						<tr class="acnt_web" style="display: none;">
							<th>간편조회PW<span class="required">*</span></th>
							<td>
								<input type="password" class="form-control form-control-sm" id="frm_acnt_web_pw" name="frm_acnt_web_pw" title="간편조회PW"
									   data-parsley-required="true" data-parsley-maxlength="45">
							</td>
						</tr>
						<tr>
							<th>비고</th>
							<td>
								<input type="text" class="form-control form-control-sm" id="frm_acnt_note" name="frm_acnt_note" title="비고"
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

<!-- Modal -->
<div class="modal fade" id="deleteModal" role="dialog" aria-labelledby="deleteModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-md" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="deleteModalLabel">삭제방식선택</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<i class="fas fa-times"></i>
				</button>
			</div>
			<div class="modal-body">
				해당 계좌를 참조하는 거래등록내역도 함께 삭제하시겠습니까?
			</div>
			<div class="modal-footer">
				<input type="hidden" id="delete_acnt_code">
				<button type="button" class="btn btn-primary" onclick="acntDelete('maintain')">유지</button>
				<button type="button" class="btn btn-danger" onclick="acntDelete('remove')">삭제</button>
			</div>
		</div>
	</div>
</div>

<div id="dialog-message" title="선택하세요." style='display:none'>
	해당 계좌의 거래등록내역을 유지하시겠습니까?
</div>

<script>
	$(function () {
		var maxIndex = $("#listTable th").length - 1
		var args = {
			hideColumns: [maxIndex-2, maxIndex-1, maxIndex]
			, orderColumns: [[1, "asc"]]
			, excludeOrderColumns: []
			, useColvis: true
			, rowspan: [1,2,3,4,5,6]
		}
		setDatatables("listTable", args);

		getPage();
	});

	$("#bank_code").on("change", function () {
		getPage();
	});

	function getPage() {
		$(".overlay").show();

		$.ajax({
			type: "POST"
			, url: "/accounting/acnt/page"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				bank_code: $("#bank_code").val()
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
					html.push(item.bank_name);
					html.push(item.acnt_name);
					html.push(item.acnt_numb);
					if (item.act_tag == "F") {
						html.push("<div class='text-danger text-bold'>" + item.act_tag_name + "</div>");
					} else {
						html.push(item.act_tag_name);
					}
					html.push("<div class='text-danger text-bold'>" + item.act_status + "</div>");
					html.push(item.acnt_note);
					html.push("<button type='button' class='btn btn-xs btn-danger' onclick=\"checkDelete('" + item.acnt_code + "')\"><i class='fas fa-minus-circle'></i> 삭제</button>");
					html.push(item.acnt_reg_date);
					html.push(item.acnt_mod_date);
					html.push(item.acnt_mod_user_name);

					var rowNode = $("#listTable").DataTable().row.add(html).node();
					$(rowNode).attr("data-acnt_code", item.acnt_code);
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

	$("#frm_acnt_numb").on("keyup focusout", function () {
		$(this).val(formatNumber($(this).val()));

		var data = {acnt_numb: $("#frm_acnt_numb").val()};
		overlapCheck($("#frm_acnt_numb"), "/accounting/acnt/overlapCheck", data);
	});

	$("#btnAdd").on("click", function () {
		initDataTable("dataTable");
		$("#btnRegist").show();
		$("#btnModify").hide();
		$("#tr_acnt_pw").show();
		$("#frm_acnt_pw").attr("data-parsley-required", true);
		$("#tr_acnt_pw_modify").hide();
		$("#modifyDescription").hide();
		$("#formModal").modal("show");
	});

	$("#frm_bank_code").on("change", function (e) {
		var bank_web_yn = $("#frm_bank_code option:selected").data("bank_web_yn");
		if (bank_web_yn == 'Y') {
			$(".acnt_web").show();
			$("#frm_acnt_web_id").attr("data-parsley-required", true);
			$("#frm_acnt_web_pw").attr("data-parsley-required", true);
		} else {
			$(".acnt_web").hide();
			$("#frm_acnt_web_id").attr("data-parsley-required", false);
			$("#frm_acnt_web_pw").attr("data-parsley-required", false);
		}
	});

	$("#btnRegist").on("click", function () {
		if (!parsleyFormValidate("submitForm")) return false;
		if (!checkResultValidate("submitForm", "checkResult")) return false;
		if (!confirm("저장하시겠습니까?")) return false;

		$.ajax({
			type: "POST"
			, url: "/accounting/acnt/regist"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				bank_code: $("#frm_bank_code").val()
				, acnt_name: $("#frm_acnt_name").val()
				, acnt_numb: $("#frm_acnt_numb").val()
				, acnt_pw: $("#frm_acnt_pw").val()
				, acnt_web_id: $("#frm_acnt_web_id").val()
				, acnt_web_pw: $("#frm_acnt_web_pw").val()
				, acnt_note: $("#frm_acnt_note").val()
			})
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
	});

	$("#listTable tbody").on("dblclick", "tr", function () {
		var acnt_code = $(this).data("acnt_code");
		getItem(acnt_code);
	});

	function getItem(acnt_code) {
		initDataTable("dataTable");
		$("#btnRegist").hide();
		$("#btnModify").show();
		$("#tr_acnt_pw").hide();
		$("#frm_acnt_pw").attr("data-parsley-required", false);
		$("#tr_acnt_pw_modify").show();
		$("#modifyDescription").show();
		$("#formModal").modal("show");

		$.ajax({
			type: "POST"
			, url: "/accounting/acnt/item/" + acnt_code
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, success: function (data) {
				setFrmValue(data);
				$("#frm_bank_code").attr("disabled", true);
				$("#frm_acnt_numb").attr("disabled", true);
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
			, url: "/accounting/acnt/modify/" + $("#frm_acnt_code").val()
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				acnt_name: $("#frm_acnt_name").val()
				, acnt_numb: $("#frm_acnt_numb").val()
				, acnt_pw: $("#frm_acnt_pw_modify").val()
				, acnt_web_id: $("#frm_acnt_web_id").val()
				, acnt_web_pw: $("#frm_acnt_web_pw").val()
				, acnt_note: $("#frm_acnt_note").val()
			})
			, success: function (data) {
				if (data == 'success') {
					$("#formModal").modal("hide");
					$("#frm_acnt_pw_modify").val("");
					getPage();
				} else {
					alert(data);
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	});

	function checkDelete(acnt_code) {
		$("#delete_acnt_code").val(acnt_code);
		$("#deleteModal").modal("show");
	}

	function acntDelete(delete_type) {
		$.ajax({
			type: "DELETE"
			, url: "/accounting/acnt/delete/" + $("#delete_acnt_code").val() + "/" + delete_type
			, dataType: "text"
			, success: function (data) {
				if (data == 'success') {
					$("#deleteModal").modal("hide");
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