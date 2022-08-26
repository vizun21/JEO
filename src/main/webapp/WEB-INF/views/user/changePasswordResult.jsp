<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
	<style>
        .register-box {width: 600px;}
        .register-logo {font-size: 2rem;margin-top: 0.9rem;font-weight: bold;}
        .about_info a {font-size: 14px;color: gray;}
        .icheck-info a {color: #17a2b8 !important;}
	</style>
</head>

<body class="hold-transition register-page">
<div class="register-box">
	<div class="card">
		<div class="card-body register-card-body">
			<div class="register-logo">
				<b>비밀번호 변경이 완료되었습니다.</b>
			</div>
			<div class="input-group">
				<button type="button" class="btn btn-info btn-block" onclick="javascript:fncGoLogin();">로그인</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	function fncGoLogin() {
		location.href = "<c:url value="/user/login"/>";
	}
</script>

</body>
