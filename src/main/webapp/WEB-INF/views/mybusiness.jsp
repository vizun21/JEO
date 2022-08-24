<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.erowm.common.config.TypeVal" %>
<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-1"></div>
			<div class="col-10">
				<div class="row">
					<div class="col-xl-2 col-md-3 col-sm-4">
						<div class="form-group">
							<select class="select2" id="bsns_cate" data-minimum-results-for-search="Infinity" style="width: 100%;">
								<option value="">[사업유형선택]</option>
								<c:forEach var="bsns_cate" items="${bsns_cate_list}" varStatus="status">
									<option value="${bsns_cate.cddt_val}">${bsns_cate.cddt_name}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="col-xl-10 col-md-9 col-sm-8">
						<div class="form-group">
							<div class="input-group input-group-md">
								<select class="select2" id="keyword_column" data-minimum-results-for-search="Infinity" style="width: 180px;">
									<option value="bsns_name">사업명</option>
									<option value="bsns_cond">업태</option>
									<option value="bsns_sect">업종</option>
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
			<div class="col-1"></div>
		</div>
		<div class="row">
			<div class="col-1"></div>
			<div class="col-10">
				<div class="card">
					<div class="card-body">
						<div class="row">
							<div class="col-md-5"></div>
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
										<th>사업유형</th>
										<th>사업명</th>
										<th>업태</th>
										<th>업종</th>
										<th>전화번호</th>
										<c:if test="${loginVO.user_level == TypeVal.LEVEL_COMP_ADMIN}">
										<th>권한관리</th>
										</c:if>
										<th>전환</th>
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
			<div class="col-1"></div>
		</div>
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="formModal" tabindex="-1" role="dialog" aria-labelledby="formModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="formModalLabel">사업정보</h5>
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
							<th>사업명<span class="required">*</span></th>
							<td colspan="3">
								<input type="hidden" id="frm_bsns_code">
								<input type="text" class="form-control form-control-sm" id="frm_bsns_name" name="bsns_name" title="사업명"
									   data-parsley-required="true" data-parsley-maxlength="20">
							</td>
						</tr>
						<tr>
							<th>사업유형<span class="required">*</span></th>
							<td>
								<select class="select2 form-control-sm" data-minimum-results-for-search="Infinity" style="width: 100%;"
										id="frm_bsns_cate" name="bsns_cate" title="사업유형" data-parsley-required="true">
									<option value="">[사업유형선택]</option>
									<c:forEach var="bsns_cate" items="${bsns_cate_list}" varStatus="status">
										<option value="${bsns_cate.cddt_val}">${bsns_cate.cddt_name}</option>
									</c:forEach>
								</select>
							</td>
							<th>회기시작월</th>
							<td>
								<select class="select2 form-control-sm" data-minimum-results-for-search="Infinity" style="width: 100%;"
										id="frm_bsns_sess_start_month" name="bsns_sess_start_month" title="회기시작월" data-parsley-required="true">
								<c:forEach var="m" begin="1" end="12">
									<option value="${m}">${m}월</option>
								</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th>업태<span class="required">*</span></th>
							<td>
								<input type="text" class="form-control form-control-sm" id="frm_bsns_cond" name="bsns_cond" title="업태"
									   data-parsley-required="true" data-parsley-maxlength="50">
							</td>
							<th>업종<span class="required">*</span></th>
							<td>
								<input type="text" class="form-control form-control-sm" id="frm_bsns_sect" name="bsns_sect" title="업종"
									   data-parsley-required="true" data-parsley-maxlength="50">
							</td>
						</tr>
						<tr>
							<th>전화번호<span class="required">*</span></th>
							<td>
								<input type="text" class="form-control form-control-sm" id="frm_bsns_tel" name="bsns_tel" title="전화번호"
									   data-parsley-required="true" data-parsley-maxlength="20">
							</td>
							<th>팩스</th>
							<td>
								<input type="text" class="form-control form-control-sm" id="frm_bsns_fax" name="bsns_fax" title="팩스"
									   data-parsley-maxlength="20">
							</td>
						</tr>
						<tr>
							<th>주소<span class="required">*</span></th>
							<td>
								<input type="text" class="form-control form-control-sm" id="frm_bsns_zipcode" name="bsns_zipcode" title="우편번호"
									   data-parsley-required="true" data-parsley-length="[5,5]" readonly style="background-color: white;">
							</td>
							<td colspan="2">
								<input type="text" class="form-control form-control-sm" id="frm_bsns_addr" name="bsns_addr" title="주소"
									   data-parsley-required="true" data-parsley-maxlength="100" readonly style="background-color: white;">
							</td>
						</tr>
						<tr>
							<th>상세주소</th>
							<td colspan="3">
								<input type="text" class="form-control form-control-sm" id="frm_bsns_detail_addr" name="bsns_detail_addr" title="상세주소"
									   data-parsley-maxlength="100">
							</td>
						</tr>
						<tr id="tr_s_auth_key" style="display: none;">
							<th><small class="text-bold">회계보고 시설인증키</small><span class="required">*</span></th>
							<td colspan="3">
								<input type="text" class="form-control form-control-sm" id="frm_s_auth_key" name="s_auth_key" title="회계보고 시설인증키"
									   data-parsley-maxlength="32">
							</td>
						</tr>
						<tr>
							<th>원장도장</th>
							<td colspan="3">
								<img class="mr-1" id="frm_bsns_director_stamp_image" name="bsns_director_stamp_image" width="50" height="50" src="/img/none.png">
								<input type="file" accept="image/png" id="frm_bsns_director_stamp" name="bsns_director_stamp" title="원장도장">
							</td>
						</tr>
						<tr>
							<th>담당자도장</th>
							<td colspan="3">
								<img class="mr-1" id="frm_bsns_manager_stamp_image" name="frm_bsns_manager_stamp_image" width="50" height="50" src="/img/none.png">
								<input type="file" accept="image/png" id="frm_bsns_manager_stamp" name="bsns_manager_stamp" title="담당자도장">
							</td>
						</tr>
						<tr>
							<th>직인</th>
							<td colspan="3">
								<img class="mr-1" id="frm_bsns_seal_image" name="frm_bsns_seal_image" width="50" height="50" src="/img/none.png">
								<input type="file" accept="image/png" id="frm_bsns_seal" name="bsns_seal" title="직인">
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
<div class="modal fade" id="authModal" role="dialog" aria-labelledby="authModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-md" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="authModalLabel">권한관리</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<i class="fas fa-times"></i>
				</button>
			</div>
			<div class="modal-body">
				<div id="modifyDescription" class="mb-3" style="display: none;">
					<span class="red" style="font-size: 9pt;">※은행 및 계좌번호는 수정이 불가능합니다.<br>※은행 및 계좌번호를 수정하시려면 계좌를 삭제 후 다시 등록을 해주세요.</span>
				</div>
				<div class="row">
					<input type="hidden" id="bsns_code">
					<div class="col-5">
						<label>미권한사용자</label>
						<select class="custom-select" id="unauth_user" multiple></select>
					</div>
					<div class="col-2 align-self-center">
						<button type="button" class="btn btn-xs btn-block btn-info" id="btnAuthAdd"><i class="fas fa-angle-double-right"></i> 추가</button>
						<button type="button" class="btn btn-xs btn-block btn-danger" id="btnAuthDelete"><i class="fas fa-angle-double-left"></i> 삭제</button>
					</div>
					<div class="col-5">
						<label>권한사용자</label>
						<select class="custom-select" id="auth_user" multiple></select>
					</div>
				</div>
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
			, excludeOrderColumns: [6,7]
			, useColvis: true
		}
		setDatatables("listTable", args);

		getPage();
	});

	$("#frm_bsns_tel, #frm_bsns_fax").on("keyup focusout", function () {
		$(this).val(formatPhone($(this).val()));
	});

	$("#frm_bsns_zipcode, #frm_bsns_addr").on("click", function () {
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
				$("#frm_bsns_zipcode").val(data.zonecode);
				$("#frm_bsns_addr").val(addr + extraAddr);
				// 커서를 상세주소 필드로 이동한다.
				$("#frm_bsns_detail_addr").focus();
			}
		}).open();
	});

	$("#frm_bsns_director_stamp, #frm_bsns_manager_stamp, #frm_bsns_seal").change(function(){
		if(this.files && this.files[0]) {
			var id = $(this).attr("id");
			var reader = new FileReader;
			reader.onload = function(data) {
				$("#" + id + "_image").attr("src", data.target.result);
			}
			reader.readAsDataURL(this.files[0]);
		}
	});

	$("#bsns_cate").on("change", function () {
		getPage();
	});

	$("#listTable tbody").on("dblclick", "tr", function () {
		var bsns_code = $(this).data("bsns_code");
		getItem(bsns_code);
	});

	$("#frm_bsns_cate").on("change", function () {
		if ($(this).val() == "DC") {
			$("#tr_s_auth_key").show();
			$("#frm_s_auth_key").attr("data-parsley-required", true);
		} else {
			$("#tr_s_auth_key").hide();
			$("#frm_s_auth_key").attr("data-parsley-required", false);
		}
	});

	function getPage() {
		$(".overlay").show();

		$.ajax({
			type: "POST"
			, url: "/mybusiness/page"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				bsns_cate: $("#bsns_cate").val()
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
					html.push(item.bsns_cate_name);
					html.push(item.bsns_name);
					html.push(item.bsns_cond);
					html.push(item.bsns_sect);
					html.push(item.bsns_tel);
					<c:if test="${loginVO.user_level == TypeVal.LEVEL_COMP_ADMIN}">
					html.push("<button type='button' class='btn btn-xs btn-secondary' onclick=\"openAuthModal('" + item.bsns_code + "')\">권한관리</button>");
					</c:if>
					html.push("<button type='button' class='btn btn-xs btn-warning' onclick=\"businessTransform('" + item.bsns_code + "')\"><i class='fas fa-sync'></i> 전환</button>");
					html.push(item.bsns_reg_date);
					html.push(item.bsns_mod_date);
					html.push(item.bsns_mod_user_name);

					var rowNode = $("#listTable").DataTable().row.add(html).node();
					$(rowNode).attr("data-bsns_code", item.bsns_code);
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

	function getItem(bsns_code) {
		initDataTable("dataTable");
		$("#btnRegist").hide();
		$("#btnModify").show();
		$("#formModal").modal("show");

		$.ajax({
			type: "POST"
			, url: "/mybusiness/item/" + bsns_code
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, success: function (data) {
				setFrmValue(data);
				$("#frm_bsns_cate").attr("disabled", true);
				$("#frm_bsns_sess_start_month").attr("disabled", true);
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

		var formData = new FormData($("#submitForm")[0]);

		$.ajax({
			type: "POST"
			, url: "/mybusiness/regist"
			, dataType: "text"
			, contentType: false
			, processData: false
			, data: formData
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
		if (!confirm("수정하시겠습니까?")) return false;

		var formData = new FormData($("#submitForm")[0]);

		$.ajax({
			type: "POST"
			, url: "/mybusiness/modify/" + $("#frm_bsns_code").val()
			// , headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, contentType: false
			, processData: false
			, data: formData
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

	function businessTransform(bsns_code) {
		$.ajax({
			type: "POST"
			, url: "/mybusiness/transform/" + bsns_code
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, success: function (data) {
				if (data == "success") {
					self.location = "/";
				} else {
					alert(data);
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	<c:if test="${loginVO.user_level == TypeVal.LEVEL_COMP_ADMIN}">
	function openAuthModal(bsns_code) {
		$("#bsns_code").val(bsns_code);

		// 권한사용자
		$.ajax({
			type: "POST"
			, url: "/mybusiness/auth/user"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				bsns_code: bsns_code
			})
			, success: function (data) {
				$("#auth_user").empty();
				$.each(data, function(index, item) {
					$("#auth_user").append("<option value='" + item.user_id +"'>" + item.user_name + "</option>");
				});
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});

		// 미권한사용자
		$.ajax({
			type: "POST"
			, url: "/mybusiness/unauth/user"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				bsns_code: bsns_code
			})
			, success: function (data) {
				$("#unauth_user").empty();
				$.each(data, function(index, item) {
					$("#unauth_user").append("<option value='" + item.user_id +"'>" + item.user_name + "</option>");
				});
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});

		$("#authModal").modal("show");
	}
	</c:if>

	$("#btnAuthAdd").on("click", function () {
		var bsns_code = $("#bsns_code").val()
		$.ajax({
			type: "POST"
			, url: "/mybusiness/auth/regist"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				bsns_code: bsns_code
				, user_id_list: $("#unauth_user").val()
			})
			, success: function (data) {
				if (data == "success") {
					$("#authModal").modal("hide");
					Toast.fire({
						icon: 'success',
						title: '저장되었습니다.'
					});
				} else {
					alert(data);
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	});

	$("#btnAuthDelete").on("click", function () {
		var bsns_code = $("#bsns_code").val()
		$.ajax({
			type: "POST"
			, url: "/mybusiness/auth/delete"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				bsns_code: bsns_code
				, user_id_list: $("#auth_user").val()
			})
			, success: function (data) {
				if (data == "success") {
					$("#authModal").modal("hide");
					Toast.fire({
						icon: 'success',
						title: '저장되었습니다.'
					});
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