<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="content">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-6 col-md-12">
				<div class="card">
					<div class="card-header">
						<h5 class="m-0">사업자정보</h5>
					</div>
					<div class="card-body">
						<table id="dataTable" class="table-form table table-sm table-bordered">
							<colgroup>
								<col width="40%">
								<col width="60%">
							</colgroup>
							<tr>
								<th>사업구분</th>
								<td>
									<div class="input-group d-flex justify-content-around">
										<div class="icheck-info d-inline">
											<input type="radio" name="frm_comp_type" id="frm_comp_type_p" value="P" title="사업구분" disabled>
											<label for="frm_comp_type_p">개인</label>
										</div>
										<div class="icheck-info d-inline">
											<input type="radio" name="frm_comp_type" id="frm_comp_type_c" value="C" title="사업구분" disabled>
											<label for="frm_comp_type_c">법인</label>
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<th>사업자명</th>
								<td><span id="frm_comp_name"></span></td>
							</tr>
							<tr>
								<th>사업자번호</th>
								<td><span id="frm_comp_reg_numb"></span></td>
							</tr>
							<tr>
								<th>만료일</th>
								<td><span id="frm_comp_exp_date"></span></td>
							</tr>
							<tr>
								<th>대표자</th>
								<td><span id="frm_ceo_name"></span></td>
							</tr>
							<tr>
								<th>대표핸드폰</th>
								<td><span id="frm_ceo_mobile"></span></td>
							</tr>
							<tr>
								<th>대표이메일</th>
								<td><span id="frm_ceo_email"></span></td>
							</tr>
						</table>
					</div>
				</div>
            </div>
			<div class="col-lg-6 col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h5 class="m-0">계정정보</h5>
                    </div>
                    <div class="card-body">
						<form id="submitForm">
							<table id="dataTable2" class="table-form table table-sm table-bordered">
								<colgroup>
									<col width="40%">
									<col width="60%">
								</colgroup>
								<tr>
									<th>아이디</th>
									<td><span id="frm_user_id"></span></td>
								</tr>
								<tr>
									<th>이름<span class="required">*</span></th>
									<td>
										<input type="text" class="form-control form-control-sm" id="frm_user_name" name="frm_user_name" placeholder="이름" title="이름"
											   data-parsley-required="true" data-parsley-length="[2,10]">
									</td>
								</tr>
								<tr>
									<th>이메일<span class="required">*</span></th>
									<td>
										<input type="email" class="form-control form-control-sm" id="frm_user_email" name="frm_user_email" placeholder="이메일" title="이메일"
											   data-parsley-required="true" data-parsley-maxlength="320">
									</td>
								</tr>
								<tr>
									<th>전화번호</th>
									<td>
										<input type="text" class="form-control form-control-sm" id="frm_user_tel" name="frm_user_tel" placeholder="전화번호" title="전화번호">
									</td>
								</tr>
								<tr>
									<th>핸드폰번호<span class="required">*</span></th>
									<td>
										<input type="text" class="form-control form-control-sm" id="frm_user_mobile" name="frm_user_mobile" placeholder="핸드폰번호" title="핸드폰번호"
											   data-parsley-required="true" data-parsley-maxlength="20">
									</td>
								</tr>
								<tr>
									<th>비밀번호</th>
									<td>
										<button type="button" class="btn btn-sm btn-warning btn-block" id="btnPasswordChange">비밀번호변경</button>
									</td>
								</tr>
							</table>
						</form>
                    </div>
					<div class="card-footer">
						<button type="button" class="btn btn-sm btn-info float-right" id="btnModify">수정</button>
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
				<h5 class="modal-title" id="formModalLabel">비밀번호변경</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<i class="fas fa-times"></i>
				</button>
			</div>
			<div class="modal-body">
				<form id="submitForm2">
					<input type="hidden" id="pop_tran_code">
					<table id="dataTable3" class="table-form table table-sm table-bordered mt-2 mb-0">
						<colgroup>
							<col width="40%">
							<col width="60%">
						</colgroup>
						<tbody>
						<tr>
							<th>비밀번호</th>
							<td>
								<input type="password" class="form-control form-control-sm" id="user_pw" name="user_pw" placeholder="비밀번호" title="비밀번호"
									   data-parsley-required="true" data-parsley-length="[8,45]">
								<small>8자 이상, 문자/숫자/기호 사용가능</small>
							</td>
						</tr>
						<tr>
							<th>비밀번호 확인</th>
							<td>
								<input type="password" class="form-control form-control-sm" id="user_pw_confirm" name="user_pw_confirm"
									   placeholder="비밀번호 확인" title="비밀번호 확인"
									   data-parsley-required="true" data-parsley-equalto="#user_pw">
							</td>
						</tr>
						</tbody>
					</table>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" id="btnChange">변경</button>
			</div>
		</div>
	</div>
</div>

<script>
	$(function () {
		<c:if test="${loginVO.user_level < 8}">
		getCompInfo();
		</c:if>
		getUserInfo();
	});

	function getCompInfo() {
		$.ajax({
			type: "POST"
			, url: "/comp/item"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				comp_code: '${loginVO.comp_code}'
			})
			, success: function (data) {
				setFrmValue(data);
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	function getUserInfo() {
		$.ajax({
			type: "POST"
			, url: "/user/item"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
			})
			, success: function (data) {
				setFrmValue(data);
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	$("#btnModify").on("click", function () {
		if (!parsleyFormValidate("submitForm")) return false;
		if (!confirm("수정하시겠습니까?")) return false;

		$(".overlay").show();

		$.ajax({
			type: "PUT"
			, url: "/user/modify"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				user_name: $("#frm_user_name").val()
				, user_email: $("#frm_user_email").val()
				, user_tel: $("#frm_user_tel").val()
				, user_mobile: $("#frm_user_mobile").val()
			})
			, success: function (data) {
				$(".overlay").hide();
				getCompInfo()
				getUserInfo();
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	});

	$("#btnPasswordChange").on("click", function () {
		$("#formModal").modal("show");
	});

	$("#btnChange").on("click", function () {
		if (!parsleyFormValidate("submitForm2")) return false;
		if (!confirm("변경하시겠습니까?")) return false;

		$.ajax({
			type: "PUT"
			, url: "/user/change/password"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				user_pw: $("#user_pw").val()
			})
			, success: function (data) {
				$("#formModal").modal("hide");
				$("#user_pw").val("");
				$("#user_pw_confirm").val("");
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	});

</script>