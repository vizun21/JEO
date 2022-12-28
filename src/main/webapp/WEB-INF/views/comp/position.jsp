<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.jeo.common.config.TypeVal" %>

<div class="content">
	<div class="container-fluid">
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
								<c:if test="${loginVO.user_level == TypeVal.LEVEL_COMP_ADMIN}">
								<div class="float-right">
									<button type="button" class="btn btn-sm btn-info" id="btnAdd"><i class="fas fa-plus"></i> 추가</button>
								</div>
								</c:if>
							</div>
						</div>
						<div class="row">
							<div class="col-12">
								<table id="listTable" class="table-list table table-sm table-bordered table-hover" style="display: none;">
									<thead>
									<tr>
										<th class="no_toggle"></th>	<%-- dtr-control 위치 --%>
										<th>순서</th>
										<th>직책코드</th>
										<th>직책</th>
									</tr>
									</thead>
									<tbody>
									<c:forEach var="result" items="${resultList}">
										<tr>
											<td></td>
											<td>${result.cddt_seq}</td>
											<td>${result.cddt_val}</td>
											<td>${result.cddt_name}</td>
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

<!-- Modal -->
<div class="modal fade" id="formModal" tabindex="-1" role="dialog" aria-labelledby="formModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-md" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="formModalLabel">직책정보</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<i class="fas fa-times"></i>
				</button>
			</div>
			<div class="modal-body">
				<form id="categoryForm" action="<c:url value="/position"/>" method="post" onsubmit="return checkForm();">
					<table class="table-form table table-sm table-bordered">
						<colgroup>
							<col width="30%">
							<col width="70%">
						</colgroup>
						<tr>
							<th>직책코드<span class="required">*</span></th>
							<td>
								<input type="text" class="form-control form-control-sm" id="cddt_val" name="cddt_val" title="직책코드"
									   data-parsley-required="true" data-parsley-maxlength="2">
								<small class="checkResult font-italic"></small>
							</td>
						</tr>
						<tr>
							<th>직책<span class="required">*</span></th>
							<td>
								<input type="text" class="form-control form-control-sm" id="cddt_name" name="cddt_name" title="직책"
									   data-parsley-required="true" data-parsley-maxlength="20">
								<small class="checkResult font-italic"></small>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="modal-footer">
				<button type="submit" form="categoryForm" class="btn btn-info" id="btnRegist">저장</button>
			</div>
		</div>
	</div>
</div>

<script>
	$(function () {
		var args = {
			orderColumns: [[1, "asc"]]
		}
		setDatatables("listTable", args);

		$("#listTable").DataTable().columns.adjust().draw();
	});

	$("#cddt_val").on("keyup focusout", function () {
		$(this).val(formatCode($(this).val()));
	});

	$("#cddt_val").on("keyup focusout", function () {
		var data = {code_id: 'USER_POSITION', cddt_val: $(this).val()};
		overlapCheck($(this), "/admin/system/code/detail/overlapCheck", data);
	});

	$("#cddt_name").on("keyup focusout", function () {
		var data = {code_id: 'USER_POSITION', cddt_name: $(this).val()};
		overlapCheck($(this), "/admin/system/code/detail/overlapCheck", data);
	});

	$("#btnAdd").on("click", function () {
		initDataTable();
		$("#btnRegist").show();
		$("#btnModify").hide();
		$("#formModal").modal("show");
	});

	function checkForm() {
		if (!parsleyFormValidate("categoryForm")) return false;
		if (!checkResultValidate("categoryForm", "checkResult")) return false;
	}
</script>
