<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-6">
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
										<th>코드아이디</th>
										<th>코드명</th>
									</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-6">
				<div class="card">
					<div class="card-body">
						<div class="row">
							<div class="col-md-5">
								<div class="float-left">
									<button type="button" class="btn btn-sm btn-default" onclick='datatablesButtonTrigger({tableID:"listTable2", extend:"excel"});'><i class="far fa-file-excel"></i> 엑셀</button>
									<button type="button" class="btn btn-sm btn-default" onclick='datatablesButtonTrigger({tableID:"listTable2", extend:"print"});'><i class="fas fa-print"></i> 인쇄</button>
								</div>
							</div>
							<div class="col-md-2" id="listTable2_colvis"></div>
							<div class="col-md-5">
								<div class="float-right">
									<button type="button" class="btn btn-sm btn-info btn-hide" id="btnAddDetail"><i class="fas fa-plus"></i> 추가</button>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-12">
								<input type="hidden" id="select_code_id">
								<table id="listTable2" class="table-list table table-sm table-bordered table-hover" style="display: none;">
									<thead>
									<tr>
										<th class="no_toggle"></th>	<%-- dtr-control 위치 --%>
										<th>순서</th>
										<th>코드값</th>
										<th>코드이름</th>
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
	<div class="modal-dialog modal-md" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="formModalLabel">코드정보</h5>
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
							<th>코드아이디</th>
							<td>
								<input type="text" class="form-control form-control-sm" id="frm_code_id" name="frm_code_id" title="코드아이디"
									   data-parsley-required="true" data-parsley-maxlength="20">
								<small class="checkResult font-italic"></small>
							</td>
						</tr>
						<tr>
							<th>코드명</th>
							<td>
								<input type="text" class="form-control form-control-sm" id="frm_code_name" name="frm_code_name" title="코드명"
									   data-parsley-required="true" data-parsley-maxlength="20">
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
<div class="modal fade" id="formModal2" tabindex="-1" role="dialog" aria-labelledby="formModal2Label" aria-hidden="true">
	<div class="modal-dialog modal-md" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="formModal2Label">코드정보</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<i class="fas fa-times"></i>
				</button>
			</div>
			<div class="modal-body">
				<form id="submitForm2">
					<table id="dataTable2" class="table-form table table-sm table-bordered">
						<colgroup>
							<col width="30%">
							<col width="70%">
						</colgroup>
						<tr>
							<th>코드값</th>
							<td>
								<input type="text" class="form-control form-control-sm" id="frm_cddt_val" name="frm_code_id" title="코드값"
									   data-parsley-required="true" data-parsley-maxlength="2">
								<small class="checkResult font-italic"></small>
							</td>
						</tr>
						<tr>
							<th>코드이름</th>
							<td>
								<input type="text" class="form-control form-control-sm" id="frm_cddt_name" name="frm_code_name" title="코드이름"
									   data-parsley-required="true" data-parsley-maxlength="20">
								<small class="checkResult font-italic"></small>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" id="btnDetailRegist">저장</button>
			</div>
		</div>
	</div>
</div>

<script>
	$(function () {
		var args = {
			hideColumns: []
			, orderColumns: [[1, "asc"]]
			, excludeOrderColumns: []
			, useColvis: true
		}
		setDatatables("listTable", args);

		var maxIndex = $("#listTable2 th").length - 1
		var args = {
			hideColumns: [maxIndex-2, maxIndex-1, maxIndex]
			, orderColumns: [[1, "asc"]]
			, excludeOrderColumns: []
			, useColvis: true
		}
		setDatatables("listTable2", args);

		$("#listTable2").sortable({
			handle: ".handle"
			, items: ".sort"
			, helper: function (e, ui) {
				// tr 너비유지
				ui.children().each(function () {
					$(this).width($(this).width());
				});
				return ui;
			}
			, update: function (event, ui) {
				// 순서변경
				var code_id = $("#select_code_id").val();
				var cddt_val_list = [];
				$("#listTable2 tbody tr.sort").each(function (index, item) {
					cddt_val_list.push($(this).data("cddt_val"));
				});

				$.ajax({
					type: "POST"
					, url: "/admin/system/code/detail/sort"
					, headers: {"Content-Type": "application/json"}
					, dataType: "text"
					, data: JSON.stringify({
						code_id: code_id
						, cddt_val_list: cddt_val_list
					})
					, success: function (data) {
						getSubList(code_id);
					}
					, error: function (request, status, error) {
						alertAjaxError(request, status, error);
					}
				});
			}
		});

		getPage();
	});

	$("#frm_cddt_val").on("keyup focusout", function () {
		$(this).val(formatCode($(this).val()));
	});

	$("#frm_code_id").on("keyup focusout", function () {
		var data = {code_id: $(this).val()};
		overlapCheck($(this), "/admin/system/code/overlapCheck", data);
	});

	$("#frm_cddt_val").on("keyup focusout", function () {
		var code_id = $("#select_code_id").val();
		var data = {code_id: code_id, cddt_val: $(this).val()};
		overlapCheck($(this), "/admin/system/code/detail/overlapCheck", data);
	});

	$("#frm_cddt_name").on("keyup focusout", function () {
		var code_id = $("#select_code_id").val();
		var data = {code_id: code_id, cddt_name: $(this).val()};
		overlapCheck($(this), "/admin/system/code/detail/overlapCheck", data);
	});

	$("#listTable tbody").on("click", "tr", function () {
		var code_id = $(this).data("code_id");
		$("#select_code_id").val(code_id);
		getSubList(code_id);
	});

	$("#btnAdd").on("click", function () {
		initDataTable("dataTable");
		$("#btnRegist").show();
		$("#formModal").modal("show");
	});

	$("#btnAddDetail").on("click", function () {
		initDataTable("dataTable2");
		$("#btnDetailRegist").show();
		$("#formModal2").modal("show");
	});

	function getPage() {
		$(".overlay").show();

		$.ajax({
			type: "POST"
			, url: "/admin/system/code/page"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({})
			, success: function (data) {
				if($.fn.DataTable.isDataTable("#listTable")) {
					$("#listTable").DataTable().clear();
				}

				$.each(data, function(index, item) {
					var html = [];
					html.push("");	// dtr-control 위치
					html.push(item.code_id);
					html.push(item.code_name);

					var rowNode = $("#listTable").DataTable().row.add(html).node();
					$(rowNode).attr("data-code_id", item.code_id);
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

	$("#btnRegist").on("click", function () {
		if (!parsleyFormValidate("submitForm")) return false;
		if (!checkResultValidate("checkResult")) return false;
		if (!confirm("저장하시겠습니까?")) return false;

		$.ajax({
			type: "POST"
			, url: "/admin/system/code/regist"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				code_id: $("#frm_code_id").val()
				, code_name: $("#frm_code_name").val()
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

	function getSubList(code_id) {
		$("#btnAddDetail").show();

		$.ajax({
			type: "POST"
			, url: "/admin/system/code/detail/list"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				code_id: code_id
			})
			, success: function (data) {
				if($.fn.DataTable.isDataTable("#listTable2")) {
					$("#listTable2").DataTable().clear();
				}

				$.each(data, function(index, item) {
					var html = [];
					html.push("");	// dtr-control 위치
					// html.push(item.cddt_seq);
					html.push("<div class='handle'>" + (index + 1) + "</div>");
					html.push(item.cddt_val);
					html.push(item.cddt_name);
					html.push(item.cddt_reg_date);
					html.push(item.cddt_mod_date);
					html.push(item.cddt_mod_user_name);

					var rowNode = $("#listTable2").DataTable().row.add(html).node();
					$(rowNode).addClass('sort');
					$(rowNode).attr("data-cddt_val", item.cddt_val);
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

	$("#btnDetailRegist").on("click", function () {
		if (!parsleyFormValidate("submitForm2")) return false;
		if (!checkResultValidate("checkResult")) return false;
		if (!confirm("저장하시겠습니까?")) return false;

		$.ajax({
			type: "POST"
			, url: "/admin/system/code/detail/regist"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				code_id: $("#select_code_id").val()
				, cddt_val: $("#frm_cddt_val").val()
				, cddt_name: $("#frm_cddt_name").val()
			})
			, success: function (data) {
				if (data == 'success') {
					$("#formModal2").modal("hide");
					getSubList($("#select_code_id").val());
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	});

</script>