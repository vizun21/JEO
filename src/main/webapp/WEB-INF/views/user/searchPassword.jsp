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
		<b>비밀번호 찾기</b>
	</div>

	<div class="card">
		<div class="card-body register-card-body">
			<form id="joinForm" action="/user/searchPassword" method="POST">
				<div class="form-group mb-3">
					<label for="user_id">사원번호 <small>(8자리 숫자)</small></label>
					<div class="input-group">
						<input type="text" class="form-control" id="user_id" name="user_id"
							   placeholder="사원번호" title="사원번호" data-parsley-required="true"
							   value="${user.user_id}">
						<div class="input-group-append">
							<div class="input-group-text">
								<span class="fas fa-user"></span>
							</div>
						</div>
					</div>
					<small class="checkResult font-italic"></small>
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
						<input type="text" class="form-control" id="password_hint_answer" name="password_hint_answer"
							   placeholder="비밀번호 확인질문 답변" title="비밀번호 확인질문 답변" data-parsley-required="true">
						<div class="input-group-append">
							<div class="input-group-text"></div>
						</div>
					</div>
				</div>
				<div class="input-group">
					<button type="submit" class="btn btn-info btn-block">비밀번호 찾기</button>
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
</script>

</body>
