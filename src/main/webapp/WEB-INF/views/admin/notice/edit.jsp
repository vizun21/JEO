<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-12">
				<div class="card">
					<div class="card-body">
						<form id="submitForm">
							<table id="dataTable" class="table-form table table-sm table-bordered" style="table-layout: fixed;">
								<colgroup>
									<col width="10%">
									<col width="65%">
									<col width="10%">
									<col width="15%">
								</colgroup>
								<tr>
									<th>제목</th>
									<td>
										<input type="text" class="form-control form-control-sm" id="frm_noti_name" name="frm_noti_name" title="제목"
											   data-parsley-required="true" data-parsley-maxlength="50" value="${notice.noti_name}">
									</td>
									<th>사업유형</th>
									<td>
										<select class="select2 form-control-sm" data-minimum-results-for-search="Infinity" style="width: 100%;"
												id="frm_bsns_cate" name="frm_bsns_cate" title="사업유형">
											<option value="">[사업유형선택]</option>
											<c:forEach var="bsns_cate" items="${bsns_cate_list}" varStatus="status">
												<option value="${bsns_cate.cddt_val}" ${bsns_cate.cddt_val == notice.bsns_cate ? "selected" : ""}>${bsns_cate.cddt_name}</option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<td colspan="4">
										<textarea class="summernote" id="frm_noti_content" name="frm_noti_content" title="내용" data-parsley-required="true"></textarea>
									</td>
								</tr>
							</table>
							<div class="mt-1 text-center">
						<c:choose>
							<c:when test="${notice.noti_code ne null}">
								<button type="button" class="btn btn-sm btn-info" id="btnModify" style="width:200px;"><i class="far fa-save"></i> 수정</button>
							</c:when>
							<c:otherwise>
								<button type="button" class="btn btn-sm btn-info" id="btnRegist" style="width:200px;"><i class="far fa-save"></i> 저장</button>
							</c:otherwise>
						</c:choose>
								<button type="button" class="btn btn-sm btn-default" id="btnCancel" style="width:200px;"><i class="far fa-save"></i> 취소</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	$(function () {
		$("#content_title").html("공지작성");

		$("#frm_noti_content").summernote({
			height: 550
			, focus: true
		});

		$("#frm_noti_content").summernote('code', '${notice.noti_content}');
	});

	$("#btnRegist").on("click", function () {
		if (!parsleyFormValidate("submitForm")) return false;
		if (!confirm("저장하시겠습니까?")) return false;

		$.ajax({
			type: "POST"
			, url: "/admin/notice/regist"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				noti_name: $("#frm_noti_name").val()
				, bsns_cate: $("#frm_bsns_cate").val()
				, noti_content: $("#frm_noti_content").val()
			})
			, success: function (data) {
				if (data == 'success') {
					self.location = "/admin/notice/list";
				} else {
					alert(data);
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	});

	$("#btnModify").on("click", function () {
		if (!parsleyFormValidate("submitForm")) return false;
		if (!confirm("수정하시겠습니까?")) return false;

		$.ajax({
			type: "POST"
			, url: "/admin/notice/modify/" + "${notice.noti_code}"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				noti_name: $("#frm_noti_name").val()
				, bsns_cate: $("#frm_bsns_cate").val()
				, noti_content: $("#frm_noti_content").val()
			})
			, success: function (data) {
				if (data == 'success') {
					self.location = "/admin/notice/list";
				} else {
					alert(data);
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	});

	$("#btnCancel").on("click", function () {
		if (!confirm("취소하시겠습니까?")) return false;
		self.location = "/admin/notice/list";
	});

</script>