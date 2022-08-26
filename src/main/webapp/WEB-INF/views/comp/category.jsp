<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
										<th>연번</th>
										<th>구분</th>
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
<div class="modal fade" id="formModal" tabindex="-1" role="dialog" aria-labelledby="formModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-md" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="formModalLabel">구분정보</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<i class="fas fa-times"></i>
				</button>
			</div>
			<div class="modal-body">
				<form id="categoryForm" action="<c:url value="/category"/>" method="post"
					  onsubmit="return checkForm();">
					<table class="table-form table table-sm table-bordered">
						<colgroup>
							<col width="30%">
							<col width="70%">
						</colgroup>
						<tr>
							<th>구분<span class="required">*</span></th>
							<td>
								<input type="hidden" id="category_code" name="category_code">
								<input type="text" class="form-control form-control-sm" id="category_name" name="category_name"
									   title="구분" data-parsley-required="true" data-parsley-maxlength="20">
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
			orderColumns: [[2, "asc"]]
		}
		setDatatables("listTable", args);

		$("#listTable").DataTable().columns.adjust().draw();
	});

	$("#btnAdd").on("click", function () {
		initDataTable("categoryForm");
		$("#btnRegist").show();
		$("#btnModify").hide();
		$("#formModal").modal("show");
	});

	function checkForm() {
		if (!parsleyFormValidate("categoryForm")) return false;
	}
</script>
