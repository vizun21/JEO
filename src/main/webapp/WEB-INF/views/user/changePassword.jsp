<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<head>
	<style>
        .register-box {width: 500px;}
        .register-logo {font-size: 2rem;margin-top: 0.9rem;font-weight: bold;}
        .about_info a {font-size: 14px;color: gray;}
        .icheck-info a {color: #17a2b8 !important;}
	</style>
</head>

<body class="hold-transition register-page">
<div class="register-box">
	<div class="register-logo">
		<b>비밀번호 변경</b>
	</div>

	<div class="card">
		<div class="card-body register-card-body">
			<form id="changePasswordForm" action="/user/changePassword" method="POST" onsubmit="return checkForm();">
				<input type="hidden" name="user_id" value="${user.user_id}">
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
				<div class="input-group">
					<button type="submit" class="btn btn-info btn-block">비밀번호 변경</button>
				</div>

				<div class="about_info text-center mt-3">
					<a href="/">로그인페이지로 이동</a>
				</div>

			</form>
		</div>
	</div>
</div>

<script type="text/javascript">
	$(function () {
		<c:if test="${not empty fn:trim(searchPasswordErrorMessage) &&  searchPasswordErrorMessage ne ''}">
		alert("<c:out value='${searchPasswordErrorMessage}'/>");
		</c:if>
	});

	function checkForm() {
		if (!parsleyFormValidate("changePasswordForm")) return false;
	}
</script>

</body>
