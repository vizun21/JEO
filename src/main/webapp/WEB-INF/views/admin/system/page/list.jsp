<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="row">
					<div class="col-xl-2 col-md-3 col-sm-4">
						<div class="form-group">
							<select class="select2" id="bsns_cate" data-minimum-results-for-search="Infinity" style="width: 100%;">
								<option value="">[전체]</option>
							<c:forEach var="bsns_cate" items="${bsns_cate_list}" varStatus="status">
								<option value="${bsns_cate.cddt_val}">${bsns_cate.cddt_name}</option>
							</c:forEach>
							</select>
						</div>
					</div>
					<div class="col-xl-2 col-md-3 col-sm-4">
						<div class="form-group">
							<select class="select2" id="page_yn" data-minimum-results-for-search="Infinity" style="width: 100%;">
								<option value="">사용여부</option>
								<option value="Y">사용</option>
								<option value="N">미사용</option>
							</select>
						</div>
					</div>
					<div class="col-xl-8 col-md-6 col-sm-4">
						<div class="form-group">
							<div class="input-group input-group-md">
								<select class="select2" id="keyword_column" data-minimum-results-for-search="Infinity" style="width: 180px;">
									<option value="page_name">페이지명</option>
									<option value="page_url">URL</option>
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
										<th>코드</th>
										<th>사업구분</th>
										<th>페이지명</th>
										<th>URL</th>
										<th>아이콘</th>
										<th>사용여부</th>
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
							<th>페이지명<span class="required">*</span></th>
							<td>
								<input type="hidden" id="frm_page_code" name="frm_page_code">
								<input type="text" class="form-control form-control-sm" id="frm_page_name" name="frm_page_name" title="페이지명"
									   data-parsley-required="true" data-parsley-maxlength="20">
							</td>
						</tr>
						<tr>
							<th>URL<span class="required">*</span></th>
							<td>
								<input type="hidden" id="frm_page_url_old" name="frm_page_url_old">
								<input type="text" class="form-control form-control-sm" id="frm_page_url" name="frm_page_url" title="URL"
									   data-parsley-required="true" data-parsley-length="[2,50]">
								<small class="checkResult font-italic"></small>
							</td>
						</tr>
						<tr>
							<th>아이콘</th>
							<td>
								<input type="text" class="form-control form-control-sm" id="frm_page_icon" name="frm_page_icon" title="아이콘"
									   data-parsley-maxlength="50">
							</td>
						</tr>
						<tr>
							<th>사용여부</th>
							<td>
								<div class="input-group d-flex justify-content-around">
									<div class="icheck-info d-inline">
										<input type="radio" name="frm_page_yn" id="frm_page_yn_y" value="Y" title="사용여부" checked required>
										<label for="frm_page_yn_y">사용</label>
									</div>
									<div class="icheck-info d-inline">
										<input type="radio" name="frm_page_yn" id="frm_page_yn_n" value="N" title="사용여부">
										<label for="frm_page_yn_n">미사용</label>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<th>사업유형</th>
							<td>
								<select class="select2 form-control-sm" data-minimum-results-for-search="Infinity" style="width: 100%;"
										id="frm_bsns_cate" name="frm_bsns_cate" title="사업유형">
									<option value="">[전체]</option>
								<c:forEach var="bsns_cate" items="${bsns_cate_list}" varStatus="status">
									<option value="${bsns_cate.cddt_val}">${bsns_cate.cddt_name}</option>
								</c:forEach>
								</select>
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
			hideColumns: [1, maxIndex-3, maxIndex-2, maxIndex-1]
			, orderColumns: [[4, "asc"]]
			, excludeOrderColumns: []
			, useColvis: true
		}
		setDatatables("listTable", args);

		getPage();
	});

	$("#frm_page_url").on("keyup", function () {
		var data = {page_url: $(this).val()};
		overlapCheck($(this), "/admin/system/page/overlapCheck", data);
	});

	$("#bsns_cate, #page_yn").on("change", function () {
		getPage();
	});

	$("#listTable tbody").on("dblclick", "tr", function () {
		var page_code = $(this).data("page_code");
		getItem(page_code);
	});

	$("#btnAdd").on("click", function () {
		initDataTable("dataTable");
		$("#btnRegist").show();
		$("#btnModify").hide();
		$("#formModal").modal("show");
	});

	function getPage() {
		$(".overlay").show();

		$.ajax({
			type: "POST"
			, url: "/admin/system/page/page"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				bsns_cate: $("#bsns_cate").val()
				, page_yn: $("#page_yn").val()
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
					html.push(item.page_code);
					html.push(item.bsns_cate_name);
					html.push("<div class='text-left'>" + item.page_name + "</div>");
					html.push("<div class='text-left'>" + item.page_url + "</div>");
					html.push(item.page_icon);
					if (item.page_yn == 'Y') {
						html.push(item.page_yn_name);
					} else {
						html.push("<div class='text-danger text-bold'>" + item.page_yn_name + "</div>");
					}
					html.push(item.page_reg_date);
					html.push(item.page_mod_date);
					html.push(item.page_mod_user_name);
					html.push("<button type='button' class='btn btn-xs btn-danger' onclick=\"pageDelete('" + item.page_code + "')\"><i class='fas fa-minus-circle'></i> 삭제</button>");

					var rowNode = $("#listTable").DataTable().row.add(html).node();
					$(rowNode).attr("data-page_code", item.page_code);
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

	function getItem(page_code) {
		initDataTable("dataTable");
		$("#btnRegist").hide();
		$("#btnModify").show();
		$("#formModal").modal("show");

		$.ajax({
			type: "POST"
			, url: "/admin/system/page/item"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				page_code: page_code
			})
			, success: function (data) {
				setFrmValue(data);
				$("#frm_page_url_old").val(data.page_url);
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
			, url: "/admin/system/page/regist"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				page_name: $("#frm_page_name").val()
				, page_url: $("#frm_page_url").val()
				, page_icon: $("#frm_page_icon").val()
				, page_yn: $(":input:radio[name=frm_page_yn]:checked").val()
				, bsns_cate: $("#frm_bsns_cate").val()
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
			, url: "/admin/system/page/modify/" + $("#frm_page_code").val()
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				page_name: $("#frm_page_name").val()
				, page_url: $("#frm_page_url").val()
				, page_icon: $("#frm_page_icon").val()
				, page_yn: $(":input:radio[name=frm_page_yn]:checked").val()
				, bsns_cate: $("#frm_bsns_cate").val()
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

	function pageDelete(page_code) {
		if (!confirm("삭제하시겠습니까?")) return false;

		$.ajax({
			type: "DELETE"
			, url: "/admin/system/page/delete/" + page_code
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({})
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