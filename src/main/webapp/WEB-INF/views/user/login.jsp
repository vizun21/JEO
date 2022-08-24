<head>
    <style>
        .about_info a {font-size: 14px;color: gray;}
        .icheck-info {font-size: 14px;}
    </style>
</head>

<body class="hold-transition login-page">
<div class="login-box">
    <div class="login-logo">
        <a href="/"><b>JEO</b></a>
    </div>

    <div class="card">
        <div class="card-body login-card-body">
            <form id="loginForm">
                <div class="input-group mb-3">
                    <input type="id" class="form-control" id="user_id" name="user_id" placeholder="ID" title="아이디"
						   data-parsley-required="true">
                    <div class="input-group-append">
                        <div class="input-group-text">
                            <span class="fas fa-user"></span>
                        </div>
                    </div>
                </div>
                <div class="input-group mb-3">
                    <input type="password" class="form-control" id="user_pw" name="user_pw" placeholder="Password" title="비밀번호"
						   data-parsley-required="true">
                    <div class="input-group-append">
                        <div class="input-group-text">
                            <span class="fas fa-lock"></span>
                        </div>
                    </div>
                </div>
                <div class="input-group mb-3">
                    <button type="button" id="btnLogin" class="btn btn-info btn-block">로그인</button>
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

<%--			<div class="input-group mb-3">--%>
<%--				<button type="button" class="btn p-0 w-100" id="btnLoginKakao">--%>
<%--				<a href="https://kauth.kakao.com/oauth/authorize--%>
<%--					?client_id=9e69d402407f4bbd0b0023737702e900--%>
<%--					&redirect_uri=http://192.168.0.49:8080/user/kakao/token--%>
<%--					&response_type=code--%>
<%--					&scope=profile,account_email,gender,birthday">--%>
<%--					<img src="/resources/img/kakao_login_medium_wide.png" class="w-100">--%>
<%--				</a>--%>
<%--				</button>--%>
<%--			</div>--%>

<%--            <hr>--%>

            <div class="input-group mb-3">
                <a class="btn btn-info btn-block" href="/user/join/person">개인회원가입</a>
                <a class="btn btn-info btn-block" href="/user/join/comp">기업회원가입</a>
            </div>

            <div class="about_info text-center mt-3">
                <a id="findID" href="#">아이디 찾기</a>
                <span class="bar" aria-hidden="true">|</span>
                <a id="findPW" href="#">비밀번호 찾기</a>
            </div>

        </div>
    </div>
</div>

<script type="text/javascript">
	$("#user_id, #user_pw").on("keyup", function (event) {
		if (event.keyCode === 13) {
			$("#btnLogin").trigger("click");
		}
	});

	$("#btnLogin").on("click", function () {
		if (!parsleyFormValidate("loginForm")) return false;


		$.ajax({
			type: "POST"
			, url: "/user/loginCheck"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				user_id: $("#user_id").val()
				, user_pw: $("#user_pw").val()
			})
			, success: function (data) {
				if (data == "success") {
					var destination = "${sessionScope.destination}";
					self.location = isNull(destination) ? "/" : destination;
				} else {
					alert(data);
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});

	});

	<%--$("#btnLoginKakao").on("click", function () {--%>
	<%--	$.ajax({--%>
	<%--		type: "GET"--%>
	<%--		, url: "/user/login/kakao"--%>
	<%--		// , headers: {"Content-Type": "application/json"}--%>
	<%--		, dataType: "text"--%>
	<%--		// , data: JSON.stringify({--%>
	<%--		// })--%>
	<%--		, success: function (data) {--%>
	<%--			&lt;%&ndash;if (data == "success") {&ndash;%&gt;--%>
	<%--			&lt;%&ndash;	var destination = "${sessionScope.destination}";&ndash;%&gt;--%>
	<%--			&lt;%&ndash;	self.location = isNull(destination) ? "/" : destination;&ndash;%&gt;--%>
	<%--			&lt;%&ndash;} else {&ndash;%&gt;--%>
	<%--			&lt;%&ndash;	alert(data);&ndash;%&gt;--%>
	<%--			&lt;%&ndash;}&ndash;%&gt;--%>
	<%--		}--%>
	<%--		, error: function (request, status, error) {--%>
	<%--			// alert(error);--%>
	<%--		}--%>
	<%--	})--%>
	<%--});--%>

	<%--$("#btnLoginKakao").on("click", function () {--%>
	<%--	$.ajax({--%>
	<%--		type: "GET"--%>
	<%--		, url: "/user/oauth"--%>
	<%--		, success: function (data) {--%>
	<%--			console.log(data);--%>
	<%--			&lt;%&ndash;if (data == "success") {&ndash;%&gt;--%>
	<%--			&lt;%&ndash;	var destination = "${sessionScope.destination}";&ndash;%&gt;--%>
	<%--			&lt;%&ndash;	self.location = isNull(destination) ? "/" : destination;&ndash;%&gt;--%>
	<%--			&lt;%&ndash;} else {&ndash;%&gt;--%>
	<%--			&lt;%&ndash;	alert(data);&ndash;%&gt;--%>
	<%--			&lt;%&ndash;}&ndash;%&gt;--%>
	<%--		}--%>
	<%--		, error: function (request, status, error) {--%>
	<%--			// alert(error);--%>
	<%--		}--%>
	<%--	})--%>
	<%--});--%>
</script>
</body>
