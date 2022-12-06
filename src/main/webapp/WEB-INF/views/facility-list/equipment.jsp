<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="content">
	<div class="container-fluid">
		<form id="searchForm">
			<div class="row">
				<div class="col-2">
					<select class="select2" id="construction_code" name="construction_code"
							data-minimum-results-for-search="Infinity" style="width: 100%;">
						<option value="">공종선택</option>
						<c:forEach var="constructionType" items="${constructionTypes}"
								   varStatus="status">
							<option value="${constructionType.construction_code}">${constructionType.construction_name}</option>
						</c:forEach>
					</select>
				</div>
				<div class="col-2">
					<select class="select2" id="category_code" name="category_code"
							data-minimum-results-for-search="Infinity" style="width: 100%;">
						<option value="">구분선택</option>
						<c:forEach var="category" items="${categories}"
								   varStatus="status">
							<option value="${category.category_code}">${category.category_name}</option>
						</c:forEach>
					</select>
				</div>
				<div class="col-2">
					<div class="form-group">
						<div class="input-group input-group-md">
							<input type="search" class="form-control" id="facility_tag_no" name="facility_tag_no" placeholder="TAG NO.">
						</div>
					</div>
				</div>
				<div class="col-2">
					<div class="form-group">
						<div class="input-group input-group-md">
							<input type="search" class="form-control" id="facility_name" name="facility_name" placeholder="설비명">
						</div>
					</div>
				</div>
				<div class="col-2">
					<button type="button" class="btn btn-md btn-primary btn-block" id="btnSearch">
						<i class="fa fa-hourglass-half"></i> 검색
					</button>
				</div>
				<div class="col-2">
					<button type="button" class="btn btn-md btn-primary btn-block" id="btnPrint">
						<i class="fas fa-print"></i> 인쇄
					</button>
				</div>
			</div>
		</form>
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
										<th>NO</th>
										<th>설비명</th>
										<th>공종</th>
										<th>구분</th>
										<th>TAG NO.</th>
										<th>설치장소</th>
										<th>수량</th>
									</tr>
									</thead>
									<tbody>
									<c:forEach var="result" items="${resultList}" varStatus="status">
										<tr data-facility_tag_no="${result.facility_tag_no}">
											<td></td>
											<td>${status.count}</td>
											<td>${result.facility_name}</td>
											<td>${result.construction_code}</td>
											<td>${result.category_code}</td>
											<td>${result.facility_tag_no}</td>
											<td>${result.emplacement}</td>
											<td>${result.facility_quantity}</td>
										</tr>
									</c:forEach>
									</tbody>
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
	function getPage() {
		$(".overlay").show();

		console.log($("#searchForm").serialize());

		$.ajax({
			type: "POST"
			, url: "/facility-list/equipment/page"
			, dataType: "json"
			, data: $("#searchForm").serialize()
			, success: function (data) {
				if($.fn.DataTable.isDataTable("#listTable")) {
					$("#listTable").DataTable().clear();
				}

				$.each(data, function(index, item) {
					var html = [];
					html.push("");	// dtr-control 위치
					html.push(index + 1);
					html.push(item.facility_name);
					html.push(item.construction_name);
					html.push(item.category_name);
					html.push(item.facility_tag_no);
					html.push(item.emplacement);
					html.push(item.facility_quantity);

					$("#listTable").DataTable().row.add(html).node();
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

	$(function () {
		var args = {
			orderColumns: [[1, "asc"]]
		}
		setDatatables("listTable", args);

		$("#listTable").DataTable().columns.adjust().draw();


		$("#listTable tr").on('click', function () {
			console.log($(this).data("facility_tag_no"));
			window.location.href = $(this).data("facility_tag_no");
		});
	});
</script>
