<%@ page import="com.jeo.webapp.accounting.child.domain.EnrollmentStatus" %>
<%@ page import="com.jeo.webapp.accounting.parent.domain.ParentType" %>
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
									<option value="child_name">원아명</option>
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
										<th>원아명</th>
										<th>원아반</th>
										<th>입학일</th>
										<th>졸업일</th>
										<th>상태</th>
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
				<h5 class="modal-title" id="formModalLabel">원아정보</h5>
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
							<th>원아명<span class="required">*</span></th>
							<td>
								<input type="hidden" id="frm_child_code">
								<input type="text" class="form-control form-control-sm" id="frm_child_name" name="child_name" title="원아명"
									   data-parsley-required="true" data-parsley-maxlength="20">
							</td>
							<th>주민등록번호<span class="required">*</span></th>
							<td>
								<div class="input-group">
									<input type="text" class="form-control form-control-sm" id="frm_child_reg_numb_1" name="frm_child_reg_numb_1"
										   placeholder="앞 6자리" title="주민등록번호" data-parsley-required="true" data-parsley-length="[6,6]">
									<input type="text" class="form-control form-control-sm" id="frm_child_reg_numb_2" name="frm_child_reg_numb_2"
										   placeholder="뒤 7자리" title="주민등록번호" data-parsley-required="true" data-parsley-length="[7,7]">
								</div>
							</td>
						</tr>
						<tr>
							<th>반선택<span class="required">*</span></th>
							<td>
								<select class="select2 form-control-sm" style="width: 100%;" id="frm_room_code" name="frm_room_code" title="반선택" data-parsley-required="true">
									<option value="">[반선택]</option>
									<c:forEach var="room" items="${room_list}">
										<option value="${room.room_code}">${room.room_name}</option>
									</c:forEach>
								</select>
							</td>
							<th>상태<span class="required">*</span></th>
							<td>
								<select class="select2 form-control-sm" style="width: 100%;" id="frm_child_status" name="frm_child_status" title="상태" data-parsley-required="true">
									<option value="">[상태선택]</option>
									<c:forEach items="${EnrollmentStatus.values()}" var="status">
										<option value="${status}">${status.label}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th>입학일<span class="required">*</span></th>
							<td>
								<input type="text" class="datepicker form-control form-control-sm" id="frm_child_admission_date" name="frm_child_admission_date" title="입학일"
									   data-parsley-required="true" readonly>
							</td>
							<th>졸업(퇴소)일</th>
							<td>
								<input type="text" class="datepicker-removable form-control form-control-sm" id="frm_child_graduation_date" name="frm_child_graduation_date" title="졸업(퇴소)일" readonly>
							</td>
						</tr>
						<tr>
							<th>주소<span class="required">*</span></th>
							<td>
								<input type="text" class="form-control form-control-sm" id="frm_child_zipcode" name="child_zipcode" title="우편번호"
									   data-parsley-required="true" data-parsley-length="[5,5]" readonly style="background-color: white;">
							</td>
							<td colspan="2">
								<input type="text" class="form-control form-control-sm" id="frm_child_addr" name="child_addr" title="주소"
									   data-parsley-required="true" data-parsley-maxlength="100" readonly style="background-color: white;">
							</td>
						</tr>
						<tr>
							<th>상세주소</th>
							<td colspan="3">
								<input type="text" class="form-control form-control-sm" id="frm_child_detail_addr" name="child_detail_addr" title="상세주소"
									   data-parsley-maxlength="100">
							</td>
						</tr>
					</table>
					<table id="listTable2" class="table-list table table-sm table-bordered table-hover mt-2 mb-0" style="table-layout: fixed;">
						<colgroup>
							<col width="15%">
							<col width="25%">
							<col width="25%">
							<col width="25%">
							<col width="10%">
						</colgroup>
						<thead>
						<tr>
							<th>관계<span class="required">*</span></th>
							<th>성명<span class="required">*</span></th>
							<th>주민등록번호<span class="required">*</span></th>
							<th>핸드폰번호<span class="required">*</span></th>
							<th><button type="button" class="btn btn-xs btn-info" onclick="addPopRow()"><i class="fas fa-plus"></i> 추가</button></th>
						</tr>
						</thead>
						<tbody></tbody>
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

<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
<script id="popTemplate" type="text/x-handlebars-template">
	<tr class="row_{{numb}} main">
		<input type="hidden" name="pop_parent_code" value="{{parent_code}}">
		<td>
			<select class="select2 form-control-sm" name="pop_parent_type" data-minimum-results-for-search="Infinity"
					title="관계" data-parsley-required="true" style="width: 100%;">
				{{#select parent_type}}
				<option value="">[관계]</option>
			<c:forEach items="${ParentType.values()}" var="item">
				<option value="${item}">${item.label}</option>
			</c:forEach>
				{{/select}}
			</select>
		</td>
		<td>
			<input type="text" class="form-control form-control-sm" name="pop_parent_name" value="{{parent_name}}"
				   placeholder="성명" data-parsley-required="true" data-parsley-maxlength="100" title="성명">
		</td>
		<td>
			<div class="input-group">
				<input type="text" class="form-control form-control-sm" name="pop_parent_reg_numb_1" value="{{parent_reg_numb_1}}"
					   placeholder="앞 6자리" title="보호자 주민등록번호" data-parsley-required="true" data-parsley-length="[6,6]">
				<input type="text" class="form-control form-control-sm" name="pop_parent_reg_numb_2" value="{{parent_reg_numb_2}}"
					   placeholder="뒤 7자리" title="보호자 주민등록번호" data-parsley-required="true" data-parsley-length="[7,7]">
			</div>
		</td>
		<td>
			<input type="text" class="form-control form-control-sm" name="pop_parent_mobile" value="{{parent_mobile}}"
				   placeholder="핸드폰번호" title="핸드폰번호" data-parsley-required="true" data-parsley-maxlength="20">
		</td>
		<td>
			<button type="button" class="btn btn-xs btn-danger" onclick="popRowDelete('{{numb}}')"><i class="fas fa-minus-circle"></i> 삭제</button>
		</td>
	</tr>
</script>

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

		Handlebars.registerHelper("select", function(value, options) {
			var $el = $('<select />').html( options.fn(this) );
			$el.find('[value="' + value + '"]').attr({'selected':'selected'});
			return $el.html();
		});

		getPage();
	});

	$("#frm_child_limit").on("keyup focusout", function () {
		$(this).val(formatNumber($(this).val()));
	});

	$("#listTable tbody").on("dblclick", "tr", function () {
		var child_code = $(this).data("child_code");
		getItem(child_code);
	});

	$("#frm_child_zipcode, #frm_child_addr").on("click", function () {
		new daum.Postcode({
			oncomplete: function(data) {
				var addr = ''; // 주소 변수
				var extraAddr = ''; // 참고항목 변수

				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}

				// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
				if(data.userSelectedType === 'R'){
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
						extraAddr += data.bname;
					}
					// 건물명이 있을 경우 추가한다.
					if(data.buildingName !== ''){
						extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
					}
					// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					if(extraAddr !== ''){
						extraAddr = ' (' + extraAddr + ')';
					}
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				$("#frm_child_zipcode").val(data.zonecode);
				$("#frm_child_addr").val(addr + extraAddr);
				// 커서를 상세주소 필드로 이동한다.
				$("#frm_child_detail_addr").focus();
			}
		}).open();
	});

	function getPage() {
		$(".overlay").show();

		$.ajax({
			type: "POST"
			, url: "/accounting/child/page"
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
					html.push(item.child_name);
					html.push(item.room_name);
					html.push(dateFormat(item.child_admission_date));
					html.push(dateFormat(item.child_graduation_date));
					html.push(item.child_status_name);
					html.push(datetimeFormat(item.child_reg_date));
					html.push(datetimeFormat(item.child_mod_date));
					html.push(item.child_mod_user_name);

					var rowNode = $("#listTable").DataTable().row.add(html).node();
					$(rowNode).attr("data-child_code", item.child_code);
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

	function getItem(child_code) {
		initDataTable("dataTable");
		$("#btnRegist").hide();
		$("#btnModify").show();
		$("#formModal").modal("show");

		$.ajax({
			type: "POST"
			, url: "/accounting/child/item/" + child_code
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, success: function (data) {
				setFrmValue(data);
				getSubList(child_code);
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	$("#btnAdd").on("click", function () {
		initDataTable("dataTable");

		$("#listTable2 tbody").empty();
		addPopRow();

		$("#btnRegist").show();
		$("#btnModify").hide();
		$("#formModal").modal("show");
	});

	$("#btnRegist").on("click", function () {
		if (!parsleyFormValidate("submitForm")) return false;
		if (!confirm("저장하시겠습니까?")) return false;

		var parent_code_list = [];
		var parent_type_list = [];
		var parent_name_list = [];
		var parent_reg_numb_1_list = [];
		var parent_reg_numb_2_list = [];
		var parent_mobile_list = [];

		$.each($("#listTable2 tbody tr.main"), function () {
			parent_code_list.push($("#pop_parent_code").val());
			parent_type_list.push($(this).find("select[name=pop_parent_type]").val());
			parent_name_list.push($(this).find("input[name=pop_parent_name]").val());
			parent_reg_numb_1_list.push($(this).find("input[name=pop_parent_reg_numb_1]").val());
			parent_reg_numb_2_list.push($(this).find("input[name=pop_parent_reg_numb_2]").val());
			parent_mobile_list.push($(this).find("input[name=pop_parent_mobile]").val());
		});

		$.ajax({
			type: "POST"
			, url: "/accounting/child/regist"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				child_name: $("#frm_child_name").val()
				, child_reg_numb_1: $("#frm_child_reg_numb_1").val()
				, child_reg_numb_2: $("#frm_child_reg_numb_2").val()
				, child_admission_date: $("#frm_child_admission_date").val()
				, child_graduation_date: $("#frm_child_graduation_date").val()
				, child_zipcode: $("#frm_child_zipcode").val()
				, child_addr: $("#frm_child_addr").val()
				, child_detail_addr: $("#frm_child_detail_addr").val()
				, child_status: $("#frm_child_status").val()
				, room_code: $("#frm_room_code").val()
				, parent_code_list: parent_code_list
				, parent_type_list: parent_type_list
				, parent_name_list: parent_name_list
				, parent_reg_numb_1_list: parent_reg_numb_1_list
				, parent_reg_numb_2_list: parent_reg_numb_2_list
				, parent_mobile_list: parent_mobile_list
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

		var parent_code_list = [];
		var parent_type_list = [];
		var parent_name_list = [];
		var parent_reg_numb_1_list = [];
		var parent_reg_numb_2_list = [];
		var parent_mobile_list = [];

		$.each($("#listTable2 tbody tr.main"), function () {
			parent_code_list.push($("#pop_parent_code").val());
			parent_type_list.push($(this).find("select[name=pop_parent_type]").val());
			parent_name_list.push($(this).find("input[name=pop_parent_name]").val());
			parent_reg_numb_1_list.push($(this).find("input[name=pop_parent_reg_numb_1]").val());
			parent_reg_numb_2_list.push($(this).find("input[name=pop_parent_reg_numb_2]").val());
			parent_mobile_list.push($(this).find("input[name=pop_parent_mobile]").val());
		});

		var delete_parent_code_list = [];
		$.each($("input[name=pop_delete_parent_code]"), function () {
			delete_parent_code_list.push($(this).val());
		});

		$.ajax({
			type: "PUT"
			, url: "/accounting/child/modify/" + $("#frm_child_code").val()
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				child_name: $("#frm_child_name").val()
				, child_reg_numb_1: $("#frm_child_reg_numb_1").val()
				, child_reg_numb_2: $("#frm_child_reg_numb_2").val()
				, child_admission_date: $("#frm_child_admission_date").val()
				, child_graduation_date: $("#frm_child_graduation_date").val()
				, child_zipcode: $("#frm_child_zipcode").val()
				, child_addr: $("#frm_child_addr").val()
				, child_detail_addr: $("#frm_child_detail_addr").val()
				, child_status: $("#frm_child_status").val()
				, room_code: $("#frm_room_code").val()
				, parent_code_list: parent_code_list
				, parent_type_list: parent_type_list
				, parent_name_list: parent_name_list
				, parent_reg_numb_1_list: parent_reg_numb_1_list
				, parent_reg_numb_2_list: parent_reg_numb_2_list
				, parent_mobile_list: parent_mobile_list
				, delete_parent_code_list: delete_parent_code_list
			})
			, success: function (data) {
				if (data == 'success') {
					$("input[name=pop_delete_parent_code]").remove();

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

	function getSubList(child_code) {
		$.ajax({
			type: "POST"
			, url: "/accounting/parent/list"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				child_code: child_code
			})
			, async: false
			, success: function (data) {
				$("#listTable2 tbody").empty();
				if (data.length > 0) {
					$.each(data, function (index, item) {
						addPopRow(item);
					});
				} else {
					addPopRow();
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}


	var p_row_numb = 0;
	function addPopRow(data) {
		var popTemplate = $("#popTemplate").html();
		var popBindTemplate = Handlebars.compile(popTemplate);

		var html = "";
		if (isNull(data)) {
			var item = {
				numb: ++p_row_numb
			}
			html += popBindTemplate(item);
		} else {
			var item = {
				numb: ++p_row_numb
				, parent_code: data.parent_code
				, parent_type: data.parent_type
				, parent_name: data.parent_name
				, parent_reg_numb_1: data.parent_reg_numb_1
				, parent_reg_numb_2: data.parent_reg_numb_2
				, parent_mobile: data.parent_mobile
			}
			html += popBindTemplate(item);
		}
		$("#listTable2 tbody").append(html);

		$("#listTable2 tbody tr.row_" + p_row_numb + " .select2").select2();

		// 분할합계 및 차액 계산
		$("#listTable2 tbody tr.row_" + p_row_numb).find("input[name=pop_parent_mobile]").on("keyup focusout", function () {
			$(this).val(formatPhone($(this).val()));
		});
	}

	function popRowDelete(numb) {
		if ($("#listTable2 tbody tr.main").length == 1) {
			alert("첫행은 삭제 불가합니다.");
			return false;
		}

		var parent_code = $("#listTable2 tbody tr.row_" + numb).find("input[name=pop_parent_code]").val();
		if (isNotNull(parent_code)) {
			// 데이터 삭제 목록 추가
			$("#submitForm").append("<input type='hidden' name='pop_delete_parent_code' value='" + parent_code + "'>");
		}
		// 행 삭제
		$("#listTable2 tbody tr.row_" + numb).remove();
	}

</script>
