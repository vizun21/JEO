<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-12">
				<div class="card">
					<div class="card-body">
						<form id="submitForm">
							<table id="dataTable" class="table-form table table-sm table-bordered">
								<colgroup>
									<col width="10%">
									<col width="90%">
								</colgroup>
								<tr>
									<th>제목</th>
									<td>
										${notice.noti_name}
									</td>
								</tr>
								<tr>
									<td colspan="2" class="p-5">
										${notice.noti_content}
									</td>
								</tr>
							</table>
							<div class="mt-1 text-center">
								<button type="button" class="btn btn-sm btn-default" id="btnToList" style="width:200px;"><i class="fas fa-list"></i> 목록으로</button>
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
		$("#content_title").html("공지사항");
	})
	$("#btnToList").on("click", function () {
		self.location = "/accounting/notice/list";
	});

</script>