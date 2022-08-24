<head>
	<style>
		.icheck-info {font-size: 14px;}
		.icheck-info a {color: #17a2b8!important;}
	</style>
</head>

<body class="hold-transition register-page">
<div class="register-box">
	<div class="register-logo">
		<a href="/"><b>EROWM</b></a>
	</div>

	<div class="card">
		<div class="card-body register-card-body">
			<form id="joinForm" action="/user/join/comp" method="POST">
				<div class="form-group mb-3">
					<label for="user_id">아이디 <small>(6-32자 이내, 영문/숫자 사용가능)</small></label>
					<div class="input-group">
						<input type="text" class="form-control" id="user_id" name="user_id" placeholder="아이디" title="아이디"
							   data-parsley-required="true" data-parsley-length="[6,32]">
						<div class="input-group-append">
							<div class="input-group-text">
								<span class="fas fa-user"></span>
							</div>
						</div>
					</div>
					<small class="checkResult font-italic"></small>
				</div>
				<div class="form-group">
					<label for="user_pw">비밀번호 <small>(8자 이상, 문자/숫자/기호 사용가능)</small></label>
					<div class="input-group mb-3">
						<input type="password" class="form-control" id="user_pw" name="user_pw" placeholder="비밀번호" title="비밀번호"
							   data-parsley-required="true" data-parsley-length="[8,45]">
						<div class="input-group-append">
							<div class="input-group-text">
								<span class="fas fa-lock"></span>
							</div>
						</div>
					</div>
					<div class="input-group mb-3">
						<input type="password" class="form-control" id="user_pw_confirm" name="user_pw_confirm"
							   placeholder="비밀번호 확인" title="비밀번호 확인"
							   data-parsley-required="true" data-parsley-equalto="#user_pw">
						<div class="input-group-append">
							<div class="input-group-text">
								<span class="fas fa-lock"></span>
							</div>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label for="user_email">이메일</label>
					<div class="input-group mb-3">
						<input type="email" class="form-control" id="user_email" name="user_email" placeholder="이메일" title="이메일"
							   data-parsley-required="true" data-parsley-maxlength="320">
						<div class="input-group-append">
							<div class="input-group-text">
								<span class="fas fa-envelope"></span>
							</div>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label for="user_name">이름</label>
					<div class="input-group mb-3">
						<input type="text" class="form-control" id="user_name" name="user_name" placeholder="이름" title="이름"
							   data-parsley-required="true" data-parsley-length="[2,10]">
						<div class="input-group-append">
							<div class="input-group-text">
								<span class="fas fa-user"></span>
							</div>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label for="user_tel">전화번호(선택)</label>
					<div class="input-group mb-3">
						<input type="text" class="form-control" id="user_tel" name="user_tel" placeholder="전화번호" title="전화번호">
						<div class="input-group-append" data-parsley-maxlength="20">
							<div class="input-group-text">
								<span class="fas fa-phone"></span>
							</div>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label for="user_mobile">핸드폰번호</label>
					<div class="input-group mb-3">
						<input type="text" class="form-control" id="user_mobile" name="user_mobile" placeholder="핸드폰번호" title="핸드폰번호"
							   data-parsley-required="true" data-parsley-maxlength="20">
						<div class="input-group-append">
							<div class="input-group-text">
								<span class="fas fa-mobile-alt"></span>
							</div>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label for="user_reg_numb_1" class="mr-2">주민등록번호</label>
					<div class="input-group mb-3">
						<input type="text" class="form-control" id="user_reg_numb_1" name="user_reg_numb_1"
							   placeholder="앞 6자리" title="주민등록번호" data-parsley-required="true" data-parsley-length="[6,6]">
						<input type="text" class="form-control" id="user_reg_numb_2" name="user_reg_numb_2"
							   placeholder="뒤 7자리" title="주민등록번호" data-parsley-required="true" data-parsley-length="[7,7]">
						<div class="input-group-append">
							<div class="input-group-text">
							</div>
						</div>
					</div>
				</div>

				<hr>

				<div class="form-group clearfix mb-0">
					<label>사업구분</label>
					<div class="input-group mb-3">
						<div class="icheck-info d-inline mr-5">
							<input type="radio" name="comp_type" id="comp_type_p" value="P" title="사업구분" data-parsley-errors-container="#comp_type-errors" required>
							<label for="comp_type_p">
								개인
							</label>
						</div>
						<div class="icheck-info d-inline">
							<input type="radio" name="comp_type" id="comp_type_c" value="C" title="사업구분">
							<label for="comp_type_c">
								법인
							</label>
						</div>
						<div id="comp_type-errors"></div>
					</div>
				</div>
				<div class="form-group">
					<label for="comp_reg_numb_1" class="mr-2">사업자등록번호</label>
					<div class="input-group mb-3">
						<input type="text" class="form-control" id="comp_reg_numb_1" name="comp_reg_numb_1" placeholder="3자리" title="사업자등록번호"
							   data-parsley-required="true" data-parsley-length="[3,3]">
						<input type="text" class="form-control" id="comp_reg_numb_2" name="comp_reg_numb_2" placeholder="2자리" title="사업자등록번호"
							   data-parsley-required="true" data-parsley-length="[2,2]">
						<input type="text" class="form-control" id="comp_reg_numb_3" name="comp_reg_numb_3" placeholder="5자리" title="사업자등록번호"
							   data-parsley-required="true" data-parsley-length="[5,5]">
						<div class="input-group-append">
							<div class="input-group-text">
							</div>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label for="comp_name">사업자명</label>
					<div class="input-group mb-3">
						<input type="text" class="form-control" id="comp_name" name="comp_name" placeholder="사업자명" title="사업자명"
							   data-parsley-required="true" data-parsley-maxlength="20">
						<div class="input-group-append">
							<div class="input-group-text">
							</div>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label>약관동의</label>
					<div class="input-group mb-3">
						<div class="icheck-info">
							<input type="checkbox" id="agreeTerms1" name="terms1" value="agree" title="이용약관 동의" data-parsley-required="true">
							<label for="agreeTerms1">
								<a data-toggle="modal" data-target="#agreeTermsModal1">이용약관 동의</a>
							</label>
						</div>
					</div>
					<div class="input-group mb-3">
						<div class="icheck-info">
							<input type="checkbox" id="agreeTerms2" name="terms2" value="agree" title="개인정보 수집 및 이용 동의" data-parsley-required="true">
							<label for="agreeTerms2">
								<a data-toggle="modal" data-target="#agreeTermsModal2">개인정보 수집 및 이용 동의</a>
							</label>
						</div>
					</div>
				</div>
				<div class="input-group">
					<button type="button" class="btn btn-info btn-block" id="joinRegist">가입하기</button>
				</div>
			</form>
		</div>
	</div>
</div>

<div class="modal fade" id="agreeTermsModal1">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">이용약관</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<p>내용</p>
			</div>
			<div class="modal-footer justify-content-flex-end">
				<button type="button" class="btn btn-info" id="btnAgreeTerms1">약관동의</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="agreeTermsModal2">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">개인정보 수집 및 이용</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<p>내용</p>
			</div>
			<div class="modal-footer justify-content-flex-end">
				<button type="button" class="btn btn-info" id="btnAgreeTerms2">약관동의</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	$("#user_id").on("keyup focusout", function () {
		$(this).val(formatID($(this).val()));
		overlapCheck($(this));
	});

	$("#user_email").on("keyup focusout", function () {
		$(this).val(formatEmail($(this).val()));
	});

	$("#user_tel, #user_mobile").on("keyup focusout", function () {
		$(this).val(formatPhone($(this).val()));
	});

	$("#user_reg_numb_1, #user_reg_numb_2, #comp_reg_numb_1, #comp_reg_numb_2, #comp_reg_numb_3").on("keyup focusout", function () {
		$(this).val(formatNumber($(this).val()));
	});

	$("#btnAgreeTerms1").on("click", function () {
		$("#agreeTerms1").attr("checked", "checked");
		$("#agreeTermsModal1").modal("hide");
	});

	$("#btnAgreeTerms2").on("click", function () {
		$("#agreeTerms2").attr("checked", "checked");
		$("#agreeTermsModal2").modal("hide");
	});

	$("#joinRegist").on("click", function () {
		if (!parsleyFormValidate("joinForm")) return false;
		if (!checkResultValidate("checkResult")) return false;

		if (!isValidJuminRegNumb($("#user_reg_numb_1"), $("#user_reg_numb_2"))) return false;
		if (!isValidCompRegNumb($("#comp_reg_numb_1"), $("#comp_reg_numb_2"), $("#comp_reg_numb_3"))) return false;

		$("#joinForm").submit();
	});

	function overlapCheck(obj) {
		var minLength = obj.data("parsley-length") ? obj.data("parsley-length")[0] : 0;
		if (obj.val().length < minLength) return false;

		$.ajax({
			type: "POST"
			, url: "/user/join/overlapCheck"
			, dataType: "json"
			, contentType: "application/json; charset=utf-8"
			, data: JSON.stringify({
				user_id: obj.val()
			})
			, success: function (data) {
				if (data) {
					obj.parent().next(".checkResult")
						.html("중복된 " + obj.prop("title") + "입니다.")
				} else {
					obj.parent().next(".checkResult").html("");
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	function isValidJuminRegNumb(reg_numb_1, reg_numb_2) {
		var valid = false;
		$.ajax({
			type: "POST"
			, url: "/user/join/juminRegNumbCheck"
			, dataType: "text"
			, contentType: "application/json; charset=utf-8"
			, data: JSON.stringify({
				user_reg_numb_1: reg_numb_1.val()
				, user_reg_numb_2: reg_numb_2.val()
			})
			, async: false
			, success: function (data) {
				if (data == "success") {
					valid = true;
				} else {
					alert(data);
					reg_numb_2.focus();
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
		return valid;
	}

	function isValidCompRegNumb(reg_numb_1, reg_numb_2, reg_numb_3) {
		var valid = false;
		$.ajax({
			type: "POST"
			, url: "/user/join/compRegNumbCheck"
			, dataType: "text"
			, contentType: "application/json; charset=utf-8"
			, data: JSON.stringify({
				comp_reg_numb_1: reg_numb_1.val()
				, comp_reg_numb_2: reg_numb_2.val()
				, comp_reg_numb_3: reg_numb_3.val()
			})
			, async: false
			, success: function (data) {
				if (data == "success") {
					valid = true;
				} else {
					alert(data);
					reg_numb_3.focus();
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
		return valid;
	}
</script>
</body>