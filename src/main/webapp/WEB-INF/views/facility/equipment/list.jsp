<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="com.jeo.common.config.TypeVal" %>

<div class="content">
	<div class="container-fluid">
		<form id="searchForm">
			<div class="row">
				<div class="col-2">
					<select class="select2" id="construction_code" name="construction_code"
							data-minimum-results-for-search="Infinity" style="width: 100%;">
						<option value="">공종선택</option>
						<c:forEach var="constructionType" items="${constructionTypes}"
								   varStatus="status">
							<option value="${constructionType.construction_code}">${constructionType.construction_name}</option>
						</c:forEach>
					</select>
				</div>
				<div class="col-2">
					<select class="select2" id="category_code" name="category_code"
							data-minimum-results-for-search="Infinity" style="width: 100%;">
						<option value="">구분선택</option>
						<c:forEach var="category" items="${categories}"
								   varStatus="status">
							<option value="${category.category_code}">${category.category_name}</option>
						</c:forEach>
					</select>
				</div>
				<div class="col-2">
					<div class="form-group">
						<div class="input-group input-group-md">
							<input type="search" class="form-control" id="facility_tag_no_keyword" name="facility_tag_no_keyword" placeholder="TAG NO.">
						</div>
					</div>
				</div>
				<div class="col-2">
					<div class="form-group">
						<div class="input-group input-group-md">
							<input type="search" class="form-control" id="facility_name_keyword" name="facility_name_keyword" placeholder="설비명">
						</div>
					</div>
				</div>
				<div class="col-2">
					<button type="button" class="btn btn-md btn-primary btn-block" id="btnSearch">
						<i class="fa fa-hourglass-half"></i> 검색
					</button>
				</div>
				<div class="col-2">
					<button type="button" class="btn btn-md btn-primary btn-block" id="btnPrint">
						<i class="fas fa-print"></i> 인쇄
					</button>
				</div>
			</div>
		</form>

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
									<c:if test="${loginVO.user_level == TypeVal.LEVEL_COMP_ADMIN}">
									<button type="button" class="btn btn-sm btn-danger" id="btnDelete"><i class="fas fa-trash-alt"></i> 삭제</button>
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
										<th class="no_toggle"><input type="checkbox" name="tb_check_all"></th>
										<th>NO</th>
										<th>설비명</th>
										<th>공종</th>
										<th>구분</th>
										<th>TAG NO.</th>
										<th>설치장소</th>
										<th>수량</th>
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

<script>
	$(function () {
		var args = {
			excludeOrderColumns: [1]
		}
		setDatatables("listTable", args);

		getPage();
	});

	$("#btnPrint").on("click", function () {
		var url = "<c:url value='/print/html/equipment-list'/>"
			+ "?construction_code=" + $("#construction_code").val()
			+ "&category_code=" + $("#category_code").val()
			+ "&facility_tag_no_keyword=" + $("#facility_tag_no_keyword").val()
			+ "&facility_name_keyword=" + $("#facility_name_keyword").val();
		window.open(url, '_blank');
	});

	$("#listTable tbody").on("click", "td:not(:nth-child(2))", function () {
		let facility_tag_no = $(this).parent().data("facility_tag_no");
		if (facility_tag_no !== undefined) {
			window.location.href = "<c:url value="/facility/equipment"></c:url>/" + facility_tag_no;
		}
	});

	function getPage() {
		$(".overlay").show();

		$.ajax({
			type: "POST"
			, url: "/facilities"
			, dataType: "json"
			, data: $("#searchForm").serialize()
			, success: function (data) {
				if($.fn.DataTable.isDataTable("#listTable")) {
					$("#listTable").DataTable().clear();
				}

				$.each(data, function(index, item) {
					var html = [];
					html.push("");	// dtr-control 위치
					html.push("<input type='checkbox' name='tb_check_list'>");
					html.push(data.length - index);
					html.push(item.facility_name);
					html.push(item.construction_name);
					html.push(item.category_name);
					html.push(item.facility_tag_no);
					html.push(item.emplacement);
					html.push(item.facility_quantity);

					var rowNode = $("#listTable").DataTable().row.add(html).node();
					$(rowNode).attr("data-facility_tag_no", item.facility_tag_no);
					$(rowNode).css("cursor", "pointer");
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

	$("#btnDelete").on("click", function () {
		var checked_list = $("#listTable input:checkbox[name=tb_check_list]:checked");
		// 설비 선택체크
		if (checked_list.length == 0) {
			alert("선택된 설비가 없습니다.");
			return false;
		}
		if (!confirm("삭제하시겠습니까?")) return false;

		var facility_list = [];
		$.each(checked_list, function () {
			var facility_tag_no = $(this).closest("tr").data("facility_tag_no");
			facility_list.push(facility_tag_no);
		});

		$.ajax({
			type: "DELETE"
			, url: "/facilities"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				facility_list: facility_list
			})
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
	});
</script>
