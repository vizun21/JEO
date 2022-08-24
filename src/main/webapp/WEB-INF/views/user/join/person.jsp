<head>
	<style>
		.icheck-info {font-size: 14px;}
		.icheck-info a {color: #17a2b8!important;}
	</style>
</head>

<body class="hold-transition register-page">
<div class="register-box">
	<div class="register-logo">
		<a href="/"><b>JEO</b></a>
	</div>

	<div class="card">
		<div class="card-body register-card-body">
			<form id="joinForm" action="/user/join/person" method="POST">
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

				<hr>

				<div class="form-group clearfix mb-0">
					<label>사업자</label>
					<input type="hidden" id="comp_code" name="comp_code">
					<div class="input-group mb-3">
						<input type="text" class="form-control" id="comp_name" name="comp_name" placeholder="사업자" title="사업자"
							   data-parsley-required="true" readonly style="background-color: white;">
						<div class="input-group-append">
							<div class="input-group-text"></div>
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

<!-- Modal -->
<div class="modal fade" id="searchModal" tabindex="-1" role="dialog" aria-labelledby="searchModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-md" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="searchModalLabel">사업자검색</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<i class="fas fa-times"></i>
				</button>
			</div>
			<div class="modal-body">
				<table class="table-form table table-sm table-bordered mb-1">
					<colgroup>
						<col width="30%">
						<col width="70%">
					</colgroup>
					<tr>
						<th>사업자명</th>
						<td>
							<div class="form-inline">
								<div class="form-group">
									<input type="text" class="form-control form-control-sm" id="keyword">
									<button type="button" class="btn btn-sm btn-info ml-1" id="btnCompSearch">검색</button>
								</div>
							</div>
						</td>
					</tr>
				</table>

				<table id="listTable" class="table-list table table-sm table-bordered table-hover">
					<thead>
					<tr>
						<th>사업자명</th>
						<th>대표자명</th>
						<th>사업자번호</th>
						<th></th>
					</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	$(function () {
		var args = {
			responsive: false
			, ordering: false
			, info: false
		}
		setDatatables("listTable", args);
	});

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

	$("#comp_name").on("click", function () {
		$("#searchModal").modal("show");
		$("#searchModal").on('shown.bs.modal', function() {
			$('#keyword').focus()
		});
	});

	$("#keyword").on("keypress", function (e) {
		if (e.keyCode == 13) getCompList();
	});

	$("#btnCompSearch").on("click", function () {
		getCompList();
	});

	function getCompList() {
		$(".overlay").show();

		$.ajax({
			type: "POST"
			, url: "/user/join/comp/list"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				keyword: $("#keyword").val()
			})
			, success: function (data) {
				if($.fn.DataTable.isDataTable("#listTable")) {
					$("#listTable").DataTable().clear();
				}

				$.each(data, function(index, item) {
					var html = [];
					html.push(item.comp_name);
					html.push(item.ceo_name);
					html.push(item.comp_reg_numb);
					html.push("<button type='button' class='btn btn-sm btn-info ml-1' onclick=\"selectComp('" + item.comp_code + "', '" + item.comp_name + "')\">선택</button>");

					$("#listTable").DataTable().row.add(html).node();
				});

				$("#listTable").DataTable().draw(false);
				$("#listTable").DataTable().columns.adjust().draw();	// 테이블 컬럼 사이즈 조절
				$(".overlay").hide();
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	function selectComp(comp_code, comp_name) {
		$("#comp_code").val(comp_code);
		$("#comp_name").val(comp_name);
		$("#searchModal").modal("hide");
	}
</script>
</body>
