<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-2 col-md-3 col-sm-4">
				<div class="form-group">
					<select class="select2" id="ghm_year" data-minimum-results-for-search="Infinity" style="width: 100%;">
						<c:forEach var="ghm_year" items="${ghm_year_list}">
							<option value="${ghm_year.ghm_year}" ${ghm_year}>${ghm_year.ghm_year}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="col-lg-10 col-md-9 col-sm-8"></div>
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
							<div class="col-md-7"></div>
						</div>
						<div class="row">
							<div class="col-12">
								<table id="listTable" class="table-list table table-sm table-bordered table-hover" style="display: none;font-size: small">
									<thead>
									<tr>
										<th rowspan="2" class="no_toggle"></th>	<%-- dtr-control 위치 --%>
										<th rowspan="2">구분</th>
										<th colspan="2">관</th>
										<th colspan="2">항</th>
										<th colspan="2">목</th>
										<th rowspan="2">비고</th>
									</tr>
									<tr>
										<th>번호</th>
										<th>명칭</th>
										<th>번호</th>
										<th>명칭</th>
										<th>번호</th>
										<th>명칭</th>
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

<script>
	$(function () {
		var args = {
			hideColumns: []
			, orderColumns: [[1, "asc"]]
			, excludeOrderColumns: [2,3,4,5,6,7,8]
			, useColvis: false
			, paging: false
			, rowspan: [1,2,3,4,5]
		}
		setDatatables("listTable", args);

		getSubPage();
	});

	$("#ghm_year").on("change", function () {
		getSubPage();
	});

	function getSubPage() {
		$(".overlay").show();

		$.ajax({
			type: "POST"
			, url: "/accounting/setting/ghm/page"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				ghm_year: $("#ghm_year").val()
			})
			, success: function (data) {
				if($.fn.DataTable.isDataTable("#listTable")) {
					$("#listTable").DataTable().clear();
				}

				$.each(data, function (index, item) {
					var html = [];
					html.push("");	// dtr-control 위치
					html.push(item.gwan_io_type_name);

					html.push("<div>" + item.gwan_numb + "</div>");
					html.push("<div>" + item.gwan_name + "</div>");

					html.push("<div>" + item.hang_numb + "</div>");
					html.push("<div>" + item.hang_name + "</div>");

					html.push("<div>" + item.mock_numb + "</div>");
					html.push("<div>" + item.mock_name + "</div>");
					html.push("<div class='text-left'>" + item.mock_note + "</div>");

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
</script>