<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="content" id="content_list">
	<div class="container-fluid">
		<div class="row">
			<div class="col-12">
				<div class="form-group">
					<div class="input-group input-group-md">
						<select class="select2" id="keyword_column" data-minimum-results-for-search="Infinity" style="width: 180px;">
							<option value="noti_name">제목</option>
						</select>
						<input type="search" class="form-control" id="keyword" placeholder="검색어 입력">
						<div class="input-group-append">
							<button type="button" class="btn btn-md btn-default" id="btnSearch">
								<i class="fa fa-search"></i>
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<div class="card">
					<div class="card-body">
						<div class="row">
							<div class="col-md-5">
								<div class="float-left">
									<button type="button" class="btn btn-sm btn-default" onclick='datatablesButtonTrigger({tableID:"listTable", extend:"excel"});'><i class="far fa-file-excel"></i> 엑셀</button>
									<button type="button" class="btn btn-sm btn-default" onclick='datatablesButtonTrigger({tableID:"listTable", extend:"print"});'><i class="fas fa-print"></i> 인쇄</button>
								</div>
							</div>
							<div class="col-md-2" id="listTable_colvis"></div>
							<div class="col-md-5"></div>
						</div>
						<div class="row">
							<div class="col-12">
								<table id="listTable" class="table-list table table-sm table-bordered table-hover" style="display: none;">
									<thead>
									<tr>
										<th class="no_toggle"></th>	<%-- dtr-control 위치 --%>
										<th>번호</th>
										<th>제목</th>
										<th>등록일</th>
										<th>작성자</th>
									</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="content" id="content_view" style="display: none;">
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
										<span id="frm_noti_name"></span>
									</td>
								</tr>
								<tr>
									<td colspan="2" class="p-5">
										<span id="frm_noti_content"></span>
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
		var args = {
			excludeOrderColumns: [2,3,4]
		}
		setDatatables("listTable", args);

		getPage();
	});

	$("#listTable tbody").on("click", "tr", function () {
		var noti_code = $(this).data("noti_code");

		self.location = "/accounting/notice/view/" + noti_code;
	});

	function getPage() {
		$(".overlay").show();

		$.ajax({
			type: "POST"
			, url: "/accounting/notice/page"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				keyword_column: $("#keyword_column").val()
				, keyword: $("#keyword").val()
			})
			, success: function (data) {
				if($.fn.DataTable.isDataTable("#listTable")) {
					$("#listTable").DataTable().clear();
				}

				$.each(data, function(index, item) {
					var html = [];
					html.push("");	// dtr-control 위치
					html.push(data.length - index);
					html.push(item.noti_name);
					html.push(item.noti_reg_date);
					html.push(item.noti_mod_user_name);

					var rowNode = $("#listTable").DataTable().row.add(html).node();
					$(rowNode).attr("data-noti_code", item.noti_code);
					$(rowNode).css("cursor", "pointer");
				});

				$("#listTable").DataTable().draw(false);
				$("#listTable").DataTable().columns.adjust().draw();

				$(".overlay").hide();
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

</script>