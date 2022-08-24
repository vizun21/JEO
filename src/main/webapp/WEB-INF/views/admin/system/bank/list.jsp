<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="row">
					<div class="col-xl-2 col-md-3 col-sm-4">
						<div class="form-group">
							<select class="select2" id="bank_yn" data-minimum-results-for-search="Infinity" style="width: 100%;">
								<option value="">사용여부</option>
								<option value="Y">사용</option>
								<option value="N">미사용</option>
							</select>
						</div>
					</div>
					<div class="col-xl-10 col-md-9 col-sm-8">
						<div class="form-group">
							<div class="input-group input-group-md">
								<select class="select2" id="keyword_column" data-minimum-results-for-search="Infinity" style="width: 180px;">
									<option value="bank_code">은행코드</option>
									<option value="bank_name">은행명</option>
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
										<th>은행코드</th>
										<th>은행명</th>
										<th>인터넷뱅킹</th>
										<th>사용여부</th>
										<th>비고</th>
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
				<h5 class="modal-title" id="formModalLabel">페이지정보</h5>
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
							<th>은행코드</th>
							<td>
								<input type="text" class="form-control form-control-sm" id="frm_bank_code" name="frm_bank_code" title="은행코드"
									   data-parsley-required="true" data-parsley-maxlength="2">
								<small class="checkResult font-italic"></small>
							</td>
						</tr>
						<tr>
							<th>은행명</th>
							<td>
								<input type="text" class="form-control form-control-sm" id="frm_bank_name" name="frm_bank_name" title="은행명"
									   data-parsley-required="true" data-parsley-maxlength="20">
							</td>
						</tr>
						<tr>
							<th>비고</th>
							<td>
								<input type="text" class="form-control form-control-sm" id="frm_bank_note" name="frm_bank_note" title="비고"
									   data-parsley-maxlength="100">
							</td>
						</tr>
						<tr>
							<th>인터넷뱅킹</th>
							<td>
								<div class="input-group d-flex justify-content-around">
									<div class="icheck-info d-inline">
										<input type="radio" name="frm_bank_web_yn" id="frm_bank_web_yn_y" value="Y" title="인터넷뱅킹" checked required>
										<label for="frm_bank_web_yn_y">사용</label>
									</div>
									<div class="icheck-info d-inline">
										<input type="radio" name="frm_bank_web_yn" id="frm_bank_web_yn_n" value="N" title="인터넷뱅킹">
										<label for="frm_bank_web_yn_n">미사용</label>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<th>사용여부</th>
							<td>
								<div class="input-group d-flex justify-content-around">
									<div class="icheck-info d-inline">
										<input type="radio" name="frm_bank_yn" id="frm_bank_yn_y" value="Y" title="사용여부" checked required>
										<label for="frm_bank_yn_y">사용</label>
									</div>
									<div class="icheck-info d-inline">
										<input type="radio" name="frm_bank_yn" id="frm_bank_yn_n" value="N" title="사용여부">
										<label for="frm_bank_yn_n">미사용</label>
									</div>
								</div>
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
			hideColumns: [maxIndex-2, maxIndex-1, maxIndex]
			, orderColumns: [[1, "asc"]]
			, excludeOrderColumns: []
			, useColvis: true
		}
		setDatatables("listTable", args);

		getPage();
	});

	$("#bank_yn").on("change", function () {
		getPage();
	});

	$("#listTable tbody").on("dblclick", "tr", function () {
		var bank_code = $(this).data("bank_code");
		getItem(bank_code);
	});

	$("#btnAdd").on("click", function () {
		initDataTable("dataTable");
		$("#btnRegist").show();
		$("#btnModify").hide();
		$("#formModal").modal("show");
	});

	$("#frm_bank_code").on("keyup focusout", function () {
		var data = {bank_code: $(this).val()};
		overlapCheck($(this), "/admin/system/bank/overlapCheck", data);
	});

	function getPage() {
		$(".overlay").show();

		$.ajax({
			type: "POST"
			, url: "/admin/system/bank/page"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				bank_yn: $("#bank_yn").val()
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
					html.push(item.bank_code);
					html.push(item.bank_name);
					if (item.bank_web_yn == 'Y') {
						html.push(item.bank_web_yn_name);
					} else {
						html.push("<div class='text-danger text-bold'>" + item.bank_web_yn_name + "</div>");
					}
					if (item.bank_yn == 'Y') {
						html.push(item.bank_yn_name);
					} else {
						html.push("<div class='text-danger text-bold'>" + item.bank_yn_name + "</div>");
					}
					html.push("<div class='text-left'>" + item.bank_note + "</div>");
					html.push(item.bank_reg_date);
					html.push(item.bank_mod_date);
					html.push(item.bank_mod_user_name);

					var rowNode = $("#listTable").DataTable().row.add(html).node();
					$(rowNode).attr("data-bank_code", item.bank_code);
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

	function getItem(bank_code) {
		initDataTable("dataTable");
		$("#btnRegist").hide();
		$("#btnModify").show();
		$("#formModal").modal("show");

		$.ajax({
			type: "POST"
			, url: "/admin/system/bank/item/" + bank_code
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, success: function (data) {
				setFrmValue(data);
				$("#frm_bank_code").attr("disabled", true);
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
			, url: "/admin/system/bank/regist"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				bank_code: $("#frm_bank_code").val()
				, bank_name: $("#frm_bank_name").val()
				, bank_web_yn: $("input:radio[name=frm_bank_web_yn]:checked").val()
				, bank_yn: $("input:radio[name=frm_bank_yn]:checked").val()
				, bank_note: $("#frm_bank_note").val()
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

	$("#btnModify").on("click", function () {
		if (!parsleyFormValidate("submitForm")) return false;
		if (!checkResultValidate("checkResult")) return false;
		if (!confirm("수정하시겠습니까?")) return false;

		$.ajax({
			type: "PUT"
			, url: "/admin/system/bank/modify/" + $("#frm_bank_code").val()
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				bank_name: $("#frm_bank_name").val()
				, bank_web_yn: $("input:radio[name=frm_bank_web_yn]:checked").val()
				, bank_yn: $("input:radio[name=frm_bank_yn]:checked").val()
				, bank_note: $("#frm_bank_note").val()
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

</script>