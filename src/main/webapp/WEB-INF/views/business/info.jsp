<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="content">
	<div class="container-fluid">
		<form id="submitForm">
			<div class="row">
				<div class="col-12">
					<div class="card">
						<div class="card-body">
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
										<img class="mr-1" id="frm_bsns_director_stamp_image" name="bsns_director_stamp_image" width="70" height="70" src="/img/none.png">
										<input type="file" accept="image/png" id="frm_bsns_director_stamp" name="bsns_director_stamp" title="원장도장">
									</td>
								</tr>
								<tr>
									<th>담당자도장</th>
									<td colspan="3">
										<img class="mr-1" id="frm_bsns_manager_stamp_image" name="frm_bsns_manager_stamp_image" width="70" height="70" src="/img/none.png">
										<input type="file" accept="image/png" id="frm_bsns_manager_stamp" name="bsns_manager_stamp" title="담당자도장">
									</td>
								</tr>
								<tr>
									<th>직인</th>
									<td colspan="3">
										<img class="mr-1" id="frm_bsns_seal_image" name="frm_bsns_seal_image" width="70" height="70" src="/img/none.png">
										<input type="file" accept="image/png" id="frm_bsns_seal" name="bsns_seal" title="직인">
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-12">
					<button type="button" class="btn btn-info float-right" id="btnModify"><i class="far fa-save"></i> 수정</button>
				</div>
			</div>
		</form>
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

		getItem("${businessVO.bsns_code}");

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

	function getItem(bsns_code) {
		initDataTable("dataTable");

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

	$("#btnModify").on("click", function () {
		if (!parsleyFormValidate("submitForm")) return false;
		if (!confirm("수정하시겠습니까?")) return false;

		var formData = new FormData($("#submitForm")[0]);

		$.ajax({
			type: "POST"
			, url: "/mybusiness/modify/" + $("#frm_bsns_code").val()
			, dataType: "text"
			, contentType: false
			, processData: false
			, data: formData
			, success: function (data) {
				if (data == 'success') {
					Toast.fire({
						icon: 'success',
						title: '저장되었습니다.'
					});
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	});

</script>
