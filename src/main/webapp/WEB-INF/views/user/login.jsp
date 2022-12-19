<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<head>
    <style>
        .login-box {width: 500px;}
        .login-logo {font-size: 2rem;margin-top: 0.9rem;font-weight: bold;}
        .about_info a {font-size: 14px;color: gray;}
        .icheck-info {font-size: 14px;}
    </style>
</head>

<body class="hold-transition login-page">
<div class="login-box">
    <div class="login-logo">
        <a href="/"><b>전주환경사업소 설비관리시스템</b></a>
    </div>

    <div class="card">
        <div class="card-body login-card-body">
			<form id="loginForm" action="<c:url value='/user/login'/>" method="post">
                <div class="input-group mb-3">
                    <input type="id" class="form-control" id="user_id" name="user_id" placeholder="사원번호" title="사원번호"
						   data-parsley-required="true">
                    <div class="input-group-append">
                        <div class="input-group-text">
                            <span class="fas fa-user"></span>
                        </div>
                    </div>
                </div>
                <div class="input-group mb-3">
                    <input type="password" class="form-control" id="user_pw" name="user_pw" placeholder="비밀번호" title="비밀번호"
						   data-parsley-required="true">
                    <div class="input-group-append">
                        <div class="input-group-text">
                            <span class="fas fa-lock"></span>
                        </div>
                    </div>
                </div>
                <div class="input-group mb-3">
                    <button type="submit" id="btnLogin" class="btn btn-info btn-block">로그인</button>
                </div>
                <div class="input-group mb-3">
                    <div class="icheck-info">
                        <input type="checkbox" id="remember">
                        <label for="remember">
                            로그인 상태 유지
                        </label>
                    </div>
                </div>
            </form>

			<hr>

            <div class="input-group mb-3">
                <a class="btn btn-info btn-block" href="/user/join/person">회원가입</a>
            </div>

            <div class="about_info text-center mt-3">
                <a id="findPW" href="/user/searchPassword">비밀번호 찾기</a>
            </div>

        </div>
    </div>
</div>

<script type="text/javascript">
	$(function () {
		<c:if test="${not empty fn:trim(loginErrorMessage) &&  loginErrorMessage ne ''}">
		alert("<c:out value='${loginErrorMessage}'/>");
		</c:if>
	});
</script>

</body>
