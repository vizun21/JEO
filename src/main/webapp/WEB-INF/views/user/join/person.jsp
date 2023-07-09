<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
	<style>
        .register-box {width: 500px;}
        .register-logo {font-size: 2rem;margin-top: 0.9rem;font-weight: bold;}
		.icheck-info {font-size: 14px;}
		.icheck-info a {color: #17a2b8!important;}
	</style>
</head>

<body class="hold-transition register-page">
<div class="register-box">
	<div class="register-logo">
		<a href="/"><b>전주환경사업소 설비관리시스템</b></a>
	</div>

	<div class="card">
		<div class="card-body register-card-body">
			<form id="joinForm" action="/user/join/person" method="POST">
				<div class="form-group mb-3">
					<label for="user_id">사원번호 <small>(8자리. 숫자만 사용가능)</small></label>
					<div class="input-group">
						<input type="text" class="form-control" id="user_id" name="user_id" placeholder="사원번호" title="사원번호"
							   data-parsley-required="true" data-parsley-length="[8,8]">
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
					<label for="user_name">직책</label>
					<div class="input-group mb-3 input-group-append">
						<select class="select2 form-control" id="user_position" name="user_position" title="직책"
								data-parsley-required="true" data-minimum-results-for-search="Infinity" style="width: 100%;">
							<option value="">[직책선택]</option>
							<c:forEach var="position" items="${positionList}" varStatus="status">
								<option value="${position.cddt_val}">${position.cddt_name}</option>
							</c:forEach>
						</select>
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
					<label for="password_hint">비밀번호 확인질문</label>
					<div class="input-group mb-3 input-group-append">
						<select class="select2 form-control" id="password_hint" name="password_hint" title="비밀번호 확인질문"
								data-parsley-required="true" data-minimum-results-for-search="Infinity" style="width: 100%;">
							<option value="">[비밀번호 확인질문 선택]</option>
							<c:forEach var="passwordHint" items="${passwordHintList}" varStatus="status">
								<option value="${passwordHint.cddt_val}">${passwordHint.cddt_name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="password_hint_answer">비밀번호 확인질문 답변</label>
					<div class="input-group mb-3">
						<input type="text" class="form-control" id="password_hint_answer" name="password_hint_answer" placeholder="비밀번호 확인질문 답변" title="비밀번호 확인질문 답변"
							   data-parsley-required="true" data-parsley-maxlength="20">
						<div class="input-group-append">
							<div class="input-group-text"></div>
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
		$(this).val(formatNumber($(this).val()));
		overlapCheck($(this));
	});

	$("#user_mobile").on("keyup focusout", function () {
		$(this).val(formatPhone($(this).val()));
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

		$("#joinForm").submit();
	});

	function overlapCheck(obj) {
		var minLength = obj.data("parsley-length") ? 1 : 0;
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
</script>
</body>
