<div class="content">
    <div class="container">
        <div class="row">
            <div class="col-lg-6">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Oauth!!!!!</h5>

                        <p class="card-text">
							${sessionScope.token}
                        </p>

                        <a href="/user/kakao/logout" class="card-link">카카오 로그아웃</a>
						<a href="https://kauth.kakao.com/oauth/logout
							?client_id=9e69d402407f4bbd0b0023737702e900
							&logout_redirect_uri=http://192.168.0.49:8080/user/logout" class="card-link">카카오계정과 함께 로그아웃</a>
						<a href="/user/kakao/unlink" class="card-link">연결끊기</a>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">사용자정보</h5>

						<button type="button" class="btn btn-info btn-block" id="btnUserInfo">사용자정보 가져오기</button>
						<table class="table">
							<tr>
								<td>아이디</td>
								<td><span id="id"></span></td>
							</tr>
							<tr>
								<td>닉네임</td>
								<td>
									<input type="text" id="properties_nickname"/>
									<img id="thumbnail_image" src="">
								</td>
							</tr>
							<tr>
								<td>이메일</td>
								<td><span id="email"></span></td>
							</tr>
							<tr>
								<td>생일</td>
								<td><span id="birthday"></span></td>
							</tr>
							<tr>
								<td>성별</td>
								<td><span id="gender"></span></td>
							</tr>
							<tr>
								<td>사업자코드</td>
								<td><input type="text" id="properties_comp_code"/></td>
							</tr>
						</table>
						<button type="button" class="btn btn-info btn-block" id="btnUserUpdate">사용자정보 수정</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
	$("#btnUserInfo").on("click", function () {
		$.ajax({
			type: "POST"
			, url: "/user/kakao/info"
			, dataType: "json"
			, success: function (data) {
				console.log(data);
				$("#id").html(data.id);
				$("#properties_nickname").val(data.properties.nickname);
				$("#thumbnail_image").attr("src", data.properties.thumbnail_image);
				$("#email").html(data.kakao_account.email);
				$("#birthday").html(data.kakao_account.birthday);
				$("#gender").html(data.kakao_account.gender);
				$("#properties_comp_code").val(data.properties.comp_code);
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	});

	$("#btnUserUpdate").on("click", function () {
		$.ajax({
			type: "POST"
			, url: "/user/kakao/update"
			, contentType: "application/json; charset=utf-8"
			, data: JSON.stringify({
				nickname : $("#properties_nickname").val()
				, comp_code : $("#properties_comp_code").val()
			})
			, success: function (data) {
				console.log(data);
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	});
</script>