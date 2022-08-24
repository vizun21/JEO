<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="row">
					<div class="col-12">
						<div class="form-group">
							<div class="input-group input-group-md">
								<select class="select2" id="keyword_column" data-minimum-results-for-search="Infinity" style="width: 180px;">
									<option value="room_name">반이름</option>
									<option value="room_teacher_name">담임명</option>
									<option value="room_sub_teacher_name">부담임</option>
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
										<th>번호</th>
										<th>반이름</th>
										<th>반정원</th>
										<th>담임명</th>
										<th>부담임</th>
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
				<h5 class="modal-title" id="formModalLabel">반정보</h5>
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
							<th>반이름<span class="required">*</span></th>
							<td>
								<input type="hidden" id="frm_room_code">
								<input type="text" class="form-control form-control-sm" id="frm_room_name" name="room_name" title="반이름"
									   data-parsley-required="true" data-parsley-maxlength="20">
							</td>
						</tr>
						<tr>
							<th>반정원<span class="required">*</span></th>
							<td>
								<input type="text" class="form-control form-control-sm" id="frm_room_limit" name="frm_room_limit" title="반정원"
									   data-parsley-required="true">
							</td>
						</tr>
						<tr>
							<th>담임명<span class="required">*</span></th>
							<td>
								<input type="text" class="form-control form-control-sm" id="frm_room_teacher_name" name="room_teacher_name" title="담임명"
									   data-parsley-required="true" data-parsley-maxlength="20">
							</td>
						</tr>
						<tr>
							<th>부담임</th>
							<td>
								<input type="text" class="form-control form-control-sm" id="frm_room_sub_teacher_name" name="room_sub_teacher_name" title="부담임"
									   data-parsley-maxlength="20">
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

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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

	$("#frm_room_limit").on("keyup focusout", function () {
		$(this).val(formatNumber($(this).val()));
	});

	$("#listTable tbody").on("dblclick", "tr", function () {
		var room_code = $(this).data("room_code");
		getItem(room_code);
	});

	function getPage() {
		$(".overlay").show();

		$.ajax({
			type: "POST"
			, url: "/accounting/room/page"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				keyword_column: $("#keyword_column").val()
				, keyword: $("#keyword").val()
			})
			, success: function (data) {
				if($.fn.DataTable.isDataTable("#listTable")) {
					$("#listTable").DataTable().clear();
				}

				$.each(data, function(index, item) {
					var html = [];
					html.push("");	// dtr-control 위치
					html.push(index + 1);
					html.push(item.room_name);
					html.push(item.room_limit);
					html.push(item.room_teacher_name);
					html.push(item.room_sub_teacher_name);
					html.push(dateFormat(item.room_reg_date));
					html.push(dateFormat(item.room_mod_date));
					html.push(item.room_mod_user_name);

					var rowNode = $("#listTable").DataTable().row.add(html).node();
					$(rowNode).attr("data-room_code", item.room_code);
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

	function getItem(room_code) {
		initDataTable("dataTable");
		$("#btnRegist").hide();
		$("#btnModify").show();
		$("#formModal").modal("show");

		$.ajax({
			type: "POST"
			, url: "/accounting/room/item/" + room_code
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, success: function (data) {
				setFrmValue(data);
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

	$("#btnRegist").on("click", function () {
		if (!parsleyFormValidate("submitForm")) return false;
		if (!checkResultValidate("checkResult")) return false;
		if (!confirm("저장하시겠습니까?")) return false;

		$.ajax({
			type: "POST"
			, url: "/accounting/room/regist"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				room_name: $("#frm_room_name").val()
				, room_limit: $("#frm_room_limit").val()
				, room_teacher_name: $("#frm_room_teacher_name").val()
				, room_sub_teacher_name: $("#frm_room_sub_teacher_name").val()
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

	$("#btnModify").on("click", function () {
		if (!parsleyFormValidate("submitForm")) return false;
		if (!confirm("수정하시겠습니까?")) return false;

		$.ajax({
			type: "PUT"
			, url: "/accounting/room/modify/" + $("#frm_room_code").val()
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				room_name: $("#frm_room_name").val()
				, room_limit: $("#frm_room_limit").val()
				, room_teacher_name: $("#frm_room_teacher_name").val()
				, room_sub_teacher_name: $("#frm_room_sub_teacher_name").val()
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

</script>