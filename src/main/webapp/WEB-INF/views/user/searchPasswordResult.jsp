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
	<div class="card">
		<div class="card-body register-card-body">
			<div class="register-logo">
				<b>${resultInfo}</b>
			</div>
			<div class="input-group">
				<button type="button" class="btn btn-info btn-block" onclick="javascript:fncGoAfterPage();">뒤로가기</button>
			</div>
			<div class="about_info text-center mt-3">
				<a href="/user/login">로그인페이지로 이동</a>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	function fncGoAfterPage(){
		history.back(-2);
	}
</script>

</body>
