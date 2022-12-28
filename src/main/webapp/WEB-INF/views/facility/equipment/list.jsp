<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
							<input type="search" class="form-control" id="facility_tag_no_keyword" name="facility_tag_no_keyword" placeholder="TAG NO.">
						</div>
					</div>
				</div>
				<div class="col-2">
					<div class="form-group">
						<div class="input-group input-group-md">
							<input type="search" class="form-control" id="facility_name_keyword" name="facility_name_keyword" placeholder="설비명">
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
	$(function () {
		var args = {
			orderColumns: []
		}
		setDatatables("listTable", args);

		getPage();
	});

	$("#btnPrint").on("click", function () {
		var url = "<c:url value='/print/html/equipment-list'/>"
			+ "?construction_code=" + $("#construction_code").val()
			+ "&category_code=" + $("#category_code").val()
			+ "&facility_tag_no_keyword=" + $("#facility_tag_no_keyword").val()
			+ "&facility_name_keyword=" + $("#facility_name_keyword").val();
		window.open(url, '_blank');
	});

	$("#listTable tbody").on("click", "tr", function () {
		let facility_tag_no = $(this).data("facility_tag_no");
		if (facility_tag_no !== undefined) {
			window.location.href = "<c:url value="/facility/equipment"></c:url>/" + facility_tag_no;
		}
	});

	function getPage() {
		$(".overlay").show();

		$.ajax({
			type: "POST"
			, url: "/facilities"
			, dataType: "json"
			, data: $("#searchForm").serialize()
			, success: function (data) {
				if($.fn.DataTable.isDataTable("#listTable")) {
					$("#listTable").DataTable().clear();
				}

				$.each(data, function(index, item) {
					var html = [];
					html.push("");	// dtr-control 위치
					html.push(data.length - index);
					html.push(item.facility_name);
					html.push(item.construction_name);
					html.push(item.category_name);
					html.push(item.facility_tag_no);
					html.push(item.emplacement);
					html.push(item.facility_quantity);

					var rowNode = $("#listTable").DataTable().row.add(html).node();
					$(rowNode).attr("data-facility_tag_no", item.facility_tag_no);
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
